import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanDisplay2 extends StatelessWidget {
  const PlanDisplay2({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: PlanViewModern()),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(theme.textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}

class PlanViewModern extends StatefulWidget {
  const PlanViewModern({super.key});

  @override
  _PlanViewModernState createState() => _PlanViewModernState();
}

class _PlanViewModernState extends State<PlanViewModern> {
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          expandedHeight: 220.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              _program.programTitle ?? "Your Plan",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            background: ProgramHeaderCard(program: _program),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CalendarCardModern(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  calendarFormat: _calendarFormat,
                  events: _events,
                  onDaySelected: _onDaySelected,
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
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: DailyScheduleList(
                    key: ValueKey<DateTime?>(_selectedDay),
                    sessions: _getEventsForDay(_selectedDay!),
                    selectedDate: _selectedDay!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgramHeaderCard extends StatelessWidget {
  final TrainingProgram program;

  const ProgramHeaderCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8A2BE2).withOpacity(0.8),
            const Color(0xFF007BFF).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.programDescripton ?? "No description",
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Duration', '${program.durationWeeks} Weeks'),
                _buildStat('Focus', program.programFocus ?? 'General'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class CalendarCardModern extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<DailySession>> events;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarCardModern({
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E3D),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar<DailySession>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarFormat: calendarFormat,
        eventLoader: (day) =>
            events[DateTime(day.year, day.month, day.day)] ?? [],
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        onPageChanged: onPageChanged,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(color: Colors.white70),
          weekendTextStyle: const TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.5),
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
                bottom: 5,
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

class DailyScheduleList extends StatelessWidget {
  final List<DailySession> sessions;
  final DateTime selectedDate;

  const DailyScheduleList({
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
          "Plan for ${DateFormat.yMMMd().format(selectedDate)}",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        if (sessions.isEmpty)
          const Center(
            child: Text("Rest Day!", style: TextStyle(color: Colors.white70)),
          )
        else
          ...sessions.map((session) => SessionCard(session: session)),
      ],
    );
  }
}

class SessionCard extends StatelessWidget {
  final DailySession session;
  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1F1E3D),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(
          _getIconForSession(session.sessionType),
          color: const Color(0xFF40E0D0),
          size: 30,
        ),
        title: Text(
          session.sessionType ?? 'Session',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          session.sessionFocus ?? 'No focus specified',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white30,
          size: 16,
        ),
      ),
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

// Dummy data remains the same as plan_display_1
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
