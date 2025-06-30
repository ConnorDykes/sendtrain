import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:intl/intl.dart';

// Note: This mockup requires the following packages:
// - table_calendar: ^3.0.0
// - google_fonts: ^6.1.0
// - intl: ^0.19.0
// Please add them to your pubspec.yaml

class PlanDisplay1 extends StatelessWidget {
  const PlanDisplay1({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: PlanView()),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(theme.textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.white.withOpacity(0.8),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  late final TrainingProgram _program;
  CalendarFormat _calendarFormat = CalendarFormat.month;
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgramHeader(),
            const SizedBox(height: 24),
            ProgramInfoCard(program: _program),
            const SizedBox(height: 24),
            CalendarCard(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              events: _events,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 24),
            DailyScheduleCard(
              sessions: _getEventsForDay(_selectedDay!),
              selectedDate: _selectedDay!,
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramHeader extends StatelessWidget {
  const ProgramHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Training Plan',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ProgramInfoCard extends StatelessWidget {
  final TrainingProgram program;

  const ProgramInfoCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.programTitle ?? 'No Title',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            program.programDescripton ?? 'No description available.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoPill(
                '${program.durationWeeks} Weeks',
                Icons.calendar_today,
                theme,
              ),
              _buildInfoPill(
                program.programFocus ?? 'General',
                Icons.track_changes,
                theme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPill(String text, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(text, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<DailySession>> events;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarCard({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.calendarFormat,
    required this.events,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TableCalendar<DailySession>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarFormat: calendarFormat,
        eventLoader: (day) {
          return events[DateTime(day.year, day.month, day.day)] ?? [];
        },
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        onPageChanged: onPageChanged,
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          titleTextStyle: theme.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          formatButtonTextStyle: theme.textTheme.bodySmall!.copyWith(
            color: Colors.white,
          ),
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: Colors.white30),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: theme.textTheme.bodySmall!.copyWith(
            color: Colors.white70,
          ),
          weekendTextStyle: theme.textTheme.bodySmall!.copyWith(
            color: Colors.white,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: Color(0xFF8A2BE2),
            shape: BoxShape.circle,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              );
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF40E0D0),
      ),
      width: 8.0,
      height: 8.0,
    );
  }
}

class DailyScheduleCard extends StatelessWidget {
  final List<DailySession> sessions;
  final DateTime selectedDate;
  const DailyScheduleCard({
    super.key,
    required this.sessions,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Schedule for ${DateFormat.yMMMd().format(selectedDate)}",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1E3D),
            borderRadius: BorderRadius.circular(16),
          ),
          child: sessions.isEmpty
              ? _buildEmptyState(theme)
              : _buildSessionList(theme),
        ),
      ],
    );
  }

  Widget _buildSessionList(ThemeData theme) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return ListTile(
          leading: Icon(
            _getIconForSession(session.sessionType),
            color: const Color(0xFF40E0D0),
          ),
          title: Text(
            session.sessionType ?? 'Session',
            style: theme.textTheme.bodyMedium,
          ),
          subtitle: Text(
            session.sessionFocus ?? 'No focus specified',
            style: theme.textTheme.bodySmall,
          ),
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white12),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.sentiment_satisfied_alt,
          color: Colors.white54,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          "No sessions scheduled. Enjoy your rest!",
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  IconData _getIconForSession(String? sessionType) {
    switch (sessionType?.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'rest':
        return Icons.hotel;
      default:
        return Icons.help_outline;
    }
  }
}

TrainingProgram _getDummyProgram() {
  return TrainingProgram(
    programTitle: 'Strength & Endurance Pro',
    programFocus: 'Build muscle and improve cardiovascular health.',
    durationWeeks: 8,
    programDescripton:
        'An 8-week balanced program for intermediate athletes looking to push their limits and achieve new personal bests.',
    weeklySchedule: [
      WeeklySession(
        week: 1,
        phase: 'Acclimatization',
        weeklyFocus: 'Foundation building and technique focus.',
        dailySessions: [
          DailySession(
            dayOfTheWeek: 'Monday',
            sessionType: 'Strength',
            sessionFocus: 'Full Body A',
          ),
          DailySession(
            dayOfTheWeek: 'Wednesday',
            sessionType: 'Strength',
            sessionFocus: 'Full Body B',
          ),
          DailySession(
            dayOfTheWeek: 'Friday',
            sessionType: 'Cardio',
            sessionFocus: 'HIIT',
          ),
        ],
      ),
      WeeklySession(
        week: 2,
        phase: 'Acclimatization',
        weeklyFocus: 'Increasing volume slightly.',
        dailySessions: [
          DailySession(
            dayOfTheWeek: 'Monday',
            sessionType: 'Strength',
            sessionFocus: 'Full Body A',
          ),
          DailySession(
            dayOfTheWeek: 'Tuesday',
            sessionType: 'Cardio',
            sessionFocus: 'LISS',
          ),
          DailySession(
            dayOfTheWeek: 'Thursday',
            sessionType: 'Strength',
            sessionFocus: 'Full Body B',
          ),
          DailySession(
            dayOfTheWeek: 'Saturday',
            sessionType: 'Cardio',
            sessionFocus: 'HIIT',
          ),
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
        if (events[dateOnly] == null) {
          events[dateOnly] = [];
        }
        events[dateOnly]!.add(dailySession);
      }
    });
  });
  return events;
}

int _dayOfWeekToInt(String day) {
  switch (day.toLowerCase()) {
    case 'monday':
      return 1;
    case 'tuesday':
      return 2;
    case 'wednesday':
      return 3;
    case 'thursday':
      return 4;
    case 'friday':
      return 5;
    case 'saturday':
      return 6;
    case 'sunday':
      return 7;
    default:
      return -1;
  }
}
