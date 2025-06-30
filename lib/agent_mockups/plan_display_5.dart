import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanDisplay5 extends StatelessWidget {
  const PlanDisplay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: PlanAgendaView()),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(theme.textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
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
          fontSize: 14,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}

class PlanAgendaView extends StatefulWidget {
  const PlanAgendaView({super.key});

  @override
  _PlanAgendaViewState createState() => _PlanAgendaViewState();
}

class _PlanAgendaViewState extends State<PlanAgendaView> {
  late final TrainingProgram _program;
  bool _showCalendar = false;

  @override
  void initState() {
    super.initState();
    _program = _getDummyProgram();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(
            programTitle: _program.programTitle ?? "Training Plan",
            showCalendar: _showCalendar,
            onToggle: (value) {
              setState(() {
                _showCalendar = value;
              });
            },
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _showCalendar
                  ? CalendarView(
                      key: const ValueKey('calendar'),
                      program: _program,
                    )
                  : AgendaView(
                      key: const ValueKey('agenda'),
                      program: _program,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String programTitle;
  final bool showCalendar;
  final ValueChanged<bool> onToggle;

  const Header({
    super.key,
    required this.programTitle,
    required this.showCalendar,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(programTitle, style: Theme.of(context).textTheme.titleLarge),
          IconButton(
            icon: Icon(
              showCalendar
                  ? Icons.view_agenda_outlined
                  : Icons.calendar_today_outlined,
            ),
            onPressed: () => onToggle(!showCalendar),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class AgendaView extends StatelessWidget {
  final TrainingProgram program;
  const AgendaView({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: program.weeklySchedule?.length ?? 0,
      itemBuilder: (context, index) {
        final weeklySession = program.weeklySchedule![index];
        return WeekCard(weeklySession: weeklySession);
      },
    );
  }
}

class WeekCard extends StatelessWidget {
  final WeeklySession weeklySession;
  const WeekCard({super.key, required this.weeklySession});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: const Color(0xFF1F1E3D).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week ${weeklySession.week} - ${weeklySession.phase ?? ""}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              weeklySession.weeklyFocus ?? "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(color: Colors.white24, height: 24),
            ...?weeklySession.dailySessions?.map(
              (session) => DayTile(session: session),
            ),
          ],
        ),
      ),
    );
  }
}

class DayTile extends StatelessWidget {
  final DailySession session;
  const DayTile({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              session.dayOfTheWeek ?? "Day",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ),
          Icon(
            _getIconForSession(session.sessionType),
            color: const Color(0xFF40E0D0),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.sessionType ?? "Session",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (session.sessionFocus != null)
                  Text(
                    session.sessionFocus!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
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

class CalendarView extends StatefulWidget {
  final TrainingProgram program;
  const CalendarView({super.key, required this.program});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<DailySession>> _events = {};

  @override
  void initState() {
    super.initState();
    _events = _getEventsForProgram(widget.program);
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        eventLoader: (day) =>
            _events[DateTime(day.year, day.month, day.day)] ?? [],
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onPageChanged: (focused) {
          _focusedDay = focused;
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.titleMedium!,
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(color: Colors.white70),
          weekendTextStyle: const TextStyle(color: Colors.white),
          selectedDecoration: const BoxDecoration(
            color: Color(0xFF8A2BE2),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// Dummy data
TrainingProgram _getDummyProgram() {
  return TrainingProgram(
    programTitle: 'Agenda & Timeline',
    programFocus: 'Linear Progression',
    durationWeeks: 4,
    weeklySchedule: [
      WeeklySession(
        week: 1,
        phase: "Foundation",
        weeklyFocus: "Build core strength and endurance.",
        dailySessions: [
          DailySession(
            dayOfTheWeek: 'Monday',
            sessionType: 'Strength',
            sessionFocus: 'Upper Body',
          ),
          DailySession(
            dayOfTheWeek: 'Wednesday',
            sessionType: 'Strength',
            sessionFocus: 'Lower Body',
          ),
          DailySession(
            dayOfTheWeek: 'Friday',
            sessionType: 'Cardio',
            sessionFocus: '30 min run',
          ),
        ],
      ),
      WeeklySession(
        week: 2,
        phase: "Intensity",
        weeklyFocus: "Increase weights and cardio duration.",
        dailySessions: [
          DailySession(
            dayOfTheWeek: 'Tuesday',
            sessionType: 'Strength',
            sessionFocus: 'Full Body',
          ),
          DailySession(
            dayOfTheWeek: 'Thursday',
            sessionType: 'Cardio',
            sessionFocus: 'HIIT',
          ),
          DailySession(
            dayOfTheWeek: 'Saturday',
            sessionType: 'Strength',
            sessionFocus: 'Accessory Lifts',
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
