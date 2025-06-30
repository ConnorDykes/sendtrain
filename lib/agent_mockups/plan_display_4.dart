import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class PlanDisplay4 extends StatelessWidget {
  const PlanDisplay4({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: PlanDashboardView()),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(theme.textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.8),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}

class PlanDashboardView extends StatefulWidget {
  const PlanDashboardView({super.key});

  @override
  _PlanDashboardViewState createState() => _PlanDashboardViewState();
}

class _PlanDashboardViewState extends State<PlanDashboardView> {
  late final TrainingProgram _program;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<DailySession>> _events = {};

  @override
  void initState() {
    super.initState();
    _program = _getDummyProgram();
    _selectedDay = _focusedDay;
    _events = _getEventsForProgram(_program);
  }

  List<DailySession> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Dashboard',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 8),
            Text(
              _program.programTitle ?? "No Title",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            StatsGrid(program: _program),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CalendarMinimal(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    events: _events,
                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: SessionDetails(
                    sessions: _getEventsForDay(_selectedDay!),
                    date: _selectedDay!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatsGrid extends StatelessWidget {
  final TrainingProgram program;
  const StatsGrid({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final sessionCounts = _getSessionCounts();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _buildStatCard(
          'Duration',
          '${program.durationWeeks} Weeks',
          Icons.timelapse,
          const Color(0xFF8A2BE2),
          context,
        ),
        _buildStatCard(
          'Focus',
          program.programFocus ?? 'N/A',
          Icons.track_changes,
          const Color(0xFF007BFF),
          context,
        ),
        _buildStatCard(
          'Strength',
          '${sessionCounts['Strength'] ?? 0} sessions',
          Icons.fitness_center,
          const Color(0xFF40E0D0),
          context,
        ),
        _buildStatCard(
          'Cardio',
          '${sessionCounts['Cardio'] ?? 0} sessions',
          Icons.directions_run,
          Colors.orange,
          context,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: color),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Map<String, int> _getSessionCounts() {
    final Map<String, int> counts = {'Strength': 0, 'Cardio': 0};
    program.weeklySchedule?.forEach((week) {
      week.dailySessions?.forEach((session) {
        if (session.sessionType != null &&
            counts.containsKey(session.sessionType)) {
          counts[session.sessionType!] = (counts[session.sessionType] ?? 0) + 1;
        }
      });
    });
    return counts;
  }
}

class CalendarMinimal extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<DailySession>> events;
  final Function(DateTime, DateTime) onDaySelected;

  const CalendarMinimal({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.events,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.titleMedium!,
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: Colors.white54,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Colors.white54,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
          weekendTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          selectedDecoration: BoxDecoration(
            color: const Color(0xFF8A2BE2),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 4,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF40E0D0),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}

class SessionDetails extends StatelessWidget {
  final List<DailySession> sessions;
  final DateTime date;

  const SessionDetails({super.key, required this.sessions, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('MMMM d').format(date),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(color: Colors.white24, height: 20),
          if (sessions.isEmpty)
            Center(
              child: Text(
                'Rest Day',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          else
            ...sessions.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(
                      _getIconForSession(s.sessionType),
                      size: 16,
                      color: const Color(0xFF40E0D0),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        s.sessionType ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIconForSession(String? sessionType) {
    switch (sessionType?.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      default:
        return Icons.help_outline;
    }
  }
}

// Dummy data
TrainingProgram _getDummyProgram() {
  return TrainingProgram(
    programTitle: 'Athlete Performance Dashboard',
    programFocus: 'Peak Performance',
    durationWeeks: 4,
    weeklySchedule: [
      WeeklySession(
        week: 1,
        dailySessions: [
          DailySession(dayOfTheWeek: 'Monday', sessionType: 'Strength'),
          DailySession(dayOfTheWeek: 'Tuesday', sessionType: 'Cardio'),
          DailySession(dayOfTheWeek: 'Thursday', sessionType: 'Strength'),
          DailySession(dayOfTheWeek: 'Friday', sessionType: 'Cardio'),
        ],
      ),
      WeeklySession(
        week: 2,
        dailySessions: [
          DailySession(dayOfTheWeek: 'Monday', sessionType: 'Strength'),
          DailySession(dayOfTheWeek: 'Wednesday', sessionType: 'Strength'),
          DailySession(dayOfTheWeek: 'Friday', sessionType: 'Cardio'),
        ],
      ),
    ],
  );
}

Map<DateTime, List<DailySession>> _getEventsForProgram(
  TrainingProgram program,
) {
  final Map<DateTime, List<DailySession>> events = {};
  final today = DateTime.now();
  final startOfProgram = today.subtract(Duration(days: today.weekday - 1));

  program.weeklySchedule?.forEach((weeklySession) {
    final weekOffset = (weeklySession.week ?? 1) - 1;
    weeklySession.dailySessions?.forEach((dailySession) {
      final dayOfWeek = _dayOfWeekToInt(dailySession.dayOfTheWeek ?? '');
      if (dayOfWeek != -1) {
        final sessionDate = startOfProgram.add(
          Duration(days: weekOffset * 7 + dayOfWeek - 1),
        );
        final dateOnly = DateTime(
          sessionDate.year,
          sessionDate.month,
          sessionDate.day,
        );
        if (events[dateOnly] == null) events[dateOnly] = [];
        events[dateOnly]!.add(dailySession);
      }
    });
  });
  return events;
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
