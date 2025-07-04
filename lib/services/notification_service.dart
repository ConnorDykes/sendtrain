import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:sendtrain/models/training_program/training_program.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize timezone data
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _notificationsPlugin.initialize(initializationSettings);
    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    // For iOS
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    // For Android
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _notificationsPlugin.show(0, title, body, notificationDetails);
  }

  Future<bool> hasNotificationPermissions() async {
    // Check iOS permissions
    final iosImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    // For iOS, we'll assume permissions are granted after requestPermissions() is called
    // since permission checking requires additional platform-specific handling

    // Check Android permissions
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidImplementation != null) {
      final hasPermission = await androidImplementation
          .areNotificationsEnabled();
      return hasPermission ?? false;
    }

    return false;
  }

  Future<void> scheduleWorkoutNotifications(TrainingProgram program) async {
    // Check if permissions are granted first
    final hasPermissions = await hasNotificationPermissions();
    if (!hasPermissions) {
      print('Notification permissions not granted, skipping scheduling');
      return;
    }

    // Cancel any existing workout notifications
    await cancelWorkoutNotifications();

    final workoutDates = _getWorkoutDatesForProgram(program);

    int notificationId = 1000; // Start with a base ID for workout notifications

    for (final date in workoutDates) {
      await _scheduleWorkoutNotification(
        notificationId++,
        date,
        'Session Reminder',
        'You have a training session today',
      );
    }

    print('Scheduled ${workoutDates.length} workout notifications');
  }

  Future<void> _scheduleWorkoutNotification(
    int id,
    DateTime date,
    String title,
    String body,
  ) async {
    // Schedule for 8:00 AM on the workout date
    final scheduledDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      8, // 8 AM
      0, // 0 minutes
    );

    // Only schedule if the date is in the future
    if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            'workout_reminders',
            'Workout Reminders',
            channelDescription: 'Daily reminders for scheduled workouts',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'workout_reminder',
          );

      const DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails(threadIdentifier: 'workout_reminders');

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
      );

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  Future<void> cancelWorkoutNotifications() async {
    // Cancel notifications with IDs starting from 1000 (workout notifications)
    for (int i = 1000; i < 2000; i++) {
      await _notificationsPlugin.cancel(i);
    }
  }

  List<DateTime> _getWorkoutDatesForProgram(TrainingProgram program) {
    final List<DateTime> workoutDates = [];

    if (program.durationWeeks == null || program.durationWeeks == 0) {
      return workoutDates;
    }

    final programStartDate = program.startedAt ?? DateTime.now();

    // Use the program's start date to determine the first day of the first week (e.g., Monday).
    final startOfFirstProgramWeek = programStartDate.subtract(
      Duration(days: programStartDate.weekday - 1),
    );

    // Iterate through every week of the program's duration
    for (int week = 1; week <= program.durationWeeks!; week++) {
      // Get the correct weekly session, filling in gaps
      final weeklySession = program.getWeeklySessionForWeek(week);

      if (weeklySession != null) {
        final weekOffset = week - 1;
        weeklySession.dailySessions?.forEach((dailySession) {
          final dayOfWeek = _dayOfWeekToInt(dailySession.dayOfTheWeek ?? '');
          if (dayOfWeek != -1) {
            // Calculate the session date for the current week.
            final sessionDate = startOfFirstProgramWeek.add(
              Duration(days: weekOffset * 7 + dayOfWeek - 1),
            );
            final dateOnly = DateTime(
              sessionDate.year,
              sessionDate.month,
              sessionDate.day,
            );
            workoutDates.add(dateOnly);
          }
        });
      }
    }

    return workoutDates;
  }

  int _dayOfWeekToInt(String day) {
    final days = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };
    return days[day.toLowerCase()] ?? -1;
  }
}
