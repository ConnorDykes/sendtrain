import 'package:flutter/material.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/session_detail_view.dart';
import 'package:table_calendar/table_calendar.dart';

class WeeklyCalendar extends StatefulWidget {
  final TrainingProgram program;

  const WeeklyCalendar({super.key, required this.program});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late DateTime _selectedDay;
  bool _isExpanded = false;
  Map<DateTime, List<DailySession>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = _getEventsForProgram(widget.program);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final dateKey = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );
    final hasEvents =
        _events.containsKey(dateKey) && _events[dateKey]!.isNotEmpty;

    setState(() {
      if (!isSameDay(_selectedDay, selectedDay)) {
        _selectedDay = selectedDay;
        _isExpanded = hasEvents;
      } else {
        _isExpanded = hasEvents ? !_isExpanded : false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.program.startedAt == null) {
      return const SizedBox.shrink();
    }

    final today = DateTime.now();
    final selectedDateKey = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    final selectedDayEvents = _events[selectedDateKey] ?? [];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TableCalendar<DailySession>(
            calendarFormat: CalendarFormat.week,
            headerVisible: false,
            firstDay: today.subtract(const Duration(days: 365)),
            lastDay: today.add(const Duration(days: 365)),
            focusedDay: today,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
              return _events[DateTime(day.year, day.month, day.day)] ?? [];
            },
            daysOfWeekStyle: _daysOfWeekStyle(),
            calendarBuilders: _calendarBuilders(),
            calendarStyle: const CalendarStyle(outsideDaysVisible: false),
          ),
          if (_isExpanded && selectedDayEvents.isNotEmpty) ...[
            const Divider(color: Colors.white24, height: 24),
            ...selectedDayEvents.map(
              (session) => _SessionInfo(session: session),
            ),
          ],
        ],
      ),
    );
  }

  DaysOfWeekStyle _daysOfWeekStyle() {
    return const DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
      weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  CalendarBuilders<DailySession> _calendarBuilders() {
    return CalendarBuilders(
      markerBuilder: (context, date, events) {
        if (events.isNotEmpty) {
          return Positioned(
            bottom: 8,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF40E0D0),
              ),
              width: 6,
              height: 6,
            ),
          );
        }
        return null;
      },
      defaultBuilder: (context, day, focusedDay) {
        return Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      todayBuilder: (context, day, focusedDay) {
        return Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      selectedBuilder: (context, day, focusedDay) {
        return Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: const Color(0xFF8A2BE2),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SessionInfo extends StatelessWidget {
  final DailySession session;

  const _SessionInfo({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionDetailView(session: session),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.sessionType ?? 'Workout',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  if (session.sessionFocus != null)
                    Text(
                      session.sessionFocus!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

Map<DateTime, List<DailySession>> _getEventsForProgram(
  TrainingProgram program,
) {
  final Map<DateTime, List<DailySession>> events = {};
  final weeks = program.durationWeeks ?? 0;
  final schedule = program.weeklySchedule ?? [];
  if (weeks == 0 || schedule.isEmpty) return events;

  final sorted = List<WeeklySession>.from(schedule)
    ..sort((a, b) => (a.week ?? 0).compareTo(b.week ?? 0));

  final startMonday = (program.startedAt ?? DateTime.now()).subtract(
    Duration(days: (program.startedAt ?? DateTime.now()).weekday - 1),
  );

  WeeklySession? activeSession;
  int nextIdx = 0;

  for (int w = 1; w <= weeks; w++) {
    if (nextIdx < sorted.length && (sorted[nextIdx].week ?? 0) == w) {
      if (sorted[nextIdx].dailySessions != null &&
          sorted[nextIdx].dailySessions!.isNotEmpty) {
        activeSession = sorted[nextIdx];
      }
      nextIdx++;
    }

    if (activeSession == null) continue;

    final offset = w - 1;
    for (final s in activeSession.dailySessions!) {
      final dow = _dayOfWeekToInt(s.dayOfTheWeek ?? '');
      if (dow == -1) continue;
      final date = startMonday.add(Duration(days: offset * 7 + dow - 1));
      final key = DateTime(date.year, date.month, date.day);
      (events[key] ??= []).add(s);
    }
  }
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
