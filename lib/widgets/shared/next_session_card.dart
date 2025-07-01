import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/session_detail_view.dart';
import 'package:table_calendar/table_calendar.dart';

class NextSessionCard extends StatelessWidget {
  final TrainingProgram program;
  const NextSessionCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    if (program.startedAt == null) {
      return const SizedBox.shrink();
    }

    final allEvents = _getEventsForProgram(program);
    final upcomingSession = _findNextSession(allEvents);

    if (upcomingSession == null) {
      return const SizedBox.shrink();
    }

    return _NextSessionCardView(
      session: upcomingSession.session,
      date: upcomingSession.date,
    );
  }
}

class _UpcomingSession {
  final DailySession session;
  final DateTime date;
  _UpcomingSession(this.session, this.date);
}

_UpcomingSession? _findNextSession(Map<DateTime, List<DailySession>> events) {
  final today = DateTime.now();
  final todayDateOnly = DateTime(today.year, today.month, today.day);

  final upcomingDates =
      events.keys.where((date) => !date.isBefore(todayDateOnly)).toList()
        ..sort();

  if (upcomingDates.isEmpty) {
    return null;
  }

  final nextSessionDate = upcomingDates.first;
  final nextSessions = events[nextSessionDate];

  if (nextSessions == null || nextSessions.isEmpty) {
    return null;
  }

  return _UpcomingSession(nextSessions.first, nextSessionDate);
}

Map<DateTime, List<DailySession>> _getEventsForProgram(
  TrainingProgram program,
) {
  final Map<DateTime, List<DailySession>> events = {};
  if (program.durationWeeks == null || program.durationWeeks == 0) {
    return events;
  }

  final programStartDate = program.startedAt ?? DateTime.now();

  final startOfFirstProgramWeek = programStartDate.subtract(
    Duration(days: programStartDate.weekday - 1),
  );

  for (int week = 1; week <= program.durationWeeks!; week++) {
    final weeklySession = program.getWeeklySessionForWeek(week);

    if (weeklySession != null) {
      final weekOffset = week - 1;
      weeklySession.dailySessions?.forEach((dailySession) {
        final dayOfWeek = _dayOfWeekToInt(dailySession.dayOfTheWeek ?? '');
        if (dayOfWeek != -1) {
          final sessionDate = startOfFirstProgramWeek.add(
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

class _NextSessionCardView extends StatelessWidget {
  final DailySession session;
  final DateTime date;

  const _NextSessionCardView({required this.session, required this.date});

  String _formatDate(BuildContext context) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    if (isSameDay(date, today)) {
      return 'Today';
    } else if (isSameDay(date, tomorrow)) {
      return 'Tomorrow';
    } else {
      return DateFormat('E, MMM d').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionDetailView(session: session),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.secondary.withOpacity(0.4),
              theme.colorScheme.primary.withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.secondary.withOpacity(0.7),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.secondary.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Next Session',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Text(
                    _formatDate(context),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.sessionType ?? 'Workout',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
