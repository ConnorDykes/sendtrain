import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanDisplay3 extends StatelessWidget {
  const PlanDisplay3({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: PlanViewInteractive()),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(theme.textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}

class PlanViewInteractive extends StatefulWidget {
  const PlanViewInteractive({super.key});

  @override
  _PlanViewInteractiveState createState() => _PlanViewInteractiveState();
}

class _PlanViewInteractiveState extends State<PlanViewInteractive>
    with TickerProviderStateMixin {
  late final TrainingProgram _program;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<DailySession>> _events = {};
  late final PageController _pageController;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _program = _getDummyProgram();
    _selectedDay = _focusedDay;
    _events = _getEventsForProgram(_program);
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProgramTitle(title: _program.programTitle ?? "Training Plan"),
            const SizedBox(height: 16),
            CalendarWithGestures(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              events: _events,
              pageController: _pageController,
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: DailyScheduleDynamic(
                  key: ValueKey<DateTime?>(_selectedDay),
                  sessions: _getEventsForDay(_selectedDay!),
                  selectedDate: _selectedDay!,
                  animationController: _animationController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramTitle extends StatelessWidget {
  final String title;
  const ProgramTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CalendarWithGestures extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<DailySession>> events;
  final PageController pageController;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarWithGestures({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.calendarFormat,
    required this.events,
    required this.pageController,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: const Color(0xFF8A2BE2).withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color(0xFF1F1E3D),
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
        calendarBuilders: _calendarBuilders(),
        headerStyle: _headerStyle(),
        calendarStyle: _calendarStyle(),
      ),
    );
  }

  CalendarBuilders<DailySession> _calendarBuilders() {
    return CalendarBuilders(
      markerBuilder: (context, date, events) {
        if (events.isNotEmpty) {
          return Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFF8A2BE2), const Color(0xFF40E0D0)],
                ),
              ),
              width: 8,
              height: 8,
            ),
          );
        }
        return null;
      },
    );
  }

  HeaderStyle _headerStyle() {
    return HeaderStyle(
      titleCentered: true,
      formatButtonShowsNext: false,
      formatButtonTextStyle: const TextStyle(color: Colors.white),
      formatButtonDecoration: BoxDecoration(
        color: const Color(0xFF8A2BE2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
      rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
    );
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
      outsideDaysVisible: false,
      defaultTextStyle: const TextStyle(color: Colors.white70),
      weekendTextStyle: const TextStyle(color: Colors.white),
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      todayDecoration: BoxDecoration(
        color: const Color(0xFF007BFF).withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: const Color(0xFF8A2BE2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A2BE2).withOpacity(0.7),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}

class DailyScheduleDynamic extends StatelessWidget {
  final List<DailySession> sessions;
  final DateTime selectedDate;
  final AnimationController animationController;

  const DailyScheduleDynamic({
    super.key,
    required this.sessions,
    required this.selectedDate,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return sessions.isEmpty
        ? _buildRestDay(context)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.5, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Interval(
                              0.2 * index,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: FadeTransition(
                      opacity: animationController,
                      child: child,
                    ),
                  );
                },
                child: SessionItem(session: session),
              );
            },
          );
  }

  Widget _buildRestDay(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bedtime_outlined,
          color: Colors.white.withOpacity(0.5),
          size: 60,
        ),
        const SizedBox(height: 16),
        Text("Rest & Recover", style: Theme.of(context).textTheme.titleMedium),
        Text(
          "No activities scheduled for today.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class SessionItem extends StatelessWidget {
  final DailySession session;
  const SessionItem({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1F1E3D),
            const Color(0xFF1F1E3D).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF40E0D0).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getIconForSession(session.sessionType),
            color: const Color(0xFF40E0D0),
          ),
        ),
        title: Text(
          session.sessionType ?? 'Session',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          session.sessionFocus ?? 'No focus',
          style: Theme.of(context).textTheme.bodySmall,
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
      default:
        return Icons.help_outline;
    }
  }
}

// Dummy data remains the same
TrainingProgram _getDummyProgram() {
  return TrainingProgram(
    programTitle: 'Interactive Strength & Endurance',
    programFocus: 'Dynamic Training',
    durationWeeks: 4,
    programDescripton: 'A highly interactive and engaging training plan.',
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
      // ... more sessions
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
