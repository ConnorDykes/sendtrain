import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sendtrain/models/state/app_state.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:sendtrain/session_detail_view.dart';
import 'package:sendtrain/widgets/shared/next_session_card.dart';

// Note: This mockup uses 'fl_chart', which might need to be added to your pubspec.yaml
// if it's not already there from the previous mockups.
// dev_dependencies:
//   fl_chart: ^0.68.0

class PlanDetailView extends ConsumerWidget {
  final TrainingProgram program;
  const PlanDetailView({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: _buildTheme(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BackgroundContainer(child: SuperPlanView(program: program)),
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

class SuperPlanView extends StatefulWidget {
  final TrainingProgram program;
  const SuperPlanView({super.key, required this.program});

  @override
  _SuperPlanViewState createState() => _SuperPlanViewState();
}

class _SuperPlanViewState extends State<SuperPlanView>
    with TickerProviderStateMixin {
  bool _showCalendar = false;

  // State from PlanDisplay3
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(
            programTitle: "Your Plan",
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
                  ? InteractiveCalendarView(
                      key: const ValueKey('calendar'),
                      program: widget.program,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      events: _getEventsForProgram(widget.program),
                      calendarFormat: _calendarFormat,
                      animationController: _animationController,
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            _animationController.forward(from: 0.0);
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
                      getEventsForDay: (day) =>
                          _getEventsForProgram(widget.program)[DateTime(
                            day.year,
                            day.month,
                            day.day,
                          )] ??
                          [],
                    )
                  : AgendaViewWithStats(
                      key: const ValueKey('agenda'),
                      program: widget.program,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white12,
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

// --- Copied from PlanDisplay5 ---
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
          Expanded(
            child: Text(
              programTitle,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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

class _UpcomingSession {
  final DailySession session;
  final DateTime date;
  _UpcomingSession(this.session, this.date);
}

_UpcomingSession? _findNextSession(Map<DateTime, List<DailySession>> events) {
  final today = DateTime.now();
  final todayDateOnly = DateTime(today.year, today.month, today.day);

  // Get all future or today's dates with events, and sort them
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

class _NextSessionCard extends StatelessWidget {
  final DailySession session;
  final DateTime date;

  const _NextSessionCard({required this.session, required this.date});

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

// --- Combination of PlanDisplay4 and PlanDisplay5 ---
class AgendaViewWithStats extends StatelessWidget {
  final TrainingProgram program;
  const AgendaViewWithStats({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final schedule = program.weeklySchedule ?? [];
    final sortedSchedule = [...schedule]
      ..sort((a, b) => (a.week ?? 0).compareTo(b.week ?? 0));

    if (schedule.isEmpty) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ProgramInfoCard(program: program),
          const SizedBox(height: 24),
          NextSessionCard(program: program),
          const Center(child: Text("No weekly schedule found.")),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: ProgramInfoCard(program: program),
        ),
        NextSessionCard(program: program),
        ..._buildWeekCards(sortedSchedule, program.durationWeeks ?? 0),
      ],
    );
  }

  // Helper to create a WeekCard for every week, repeating the last defined
  // weeklySession until a new one appears.
  List<Widget> _buildWeekCards(List<WeeklySession> sorted, int durationWeeks) {
    final List<Widget> cards = [];
    if (sorted.isEmpty) return cards;

    WeeklySession? active;
    int idx = 0;

    for (int w = 1; w <= durationWeeks; w++) {
      if (idx < sorted.length && (sorted[idx].week ?? 0) == w) {
        // Only update the active session if the new one has content.
        if (sorted[idx].dailySessions != null &&
            sorted[idx].dailySessions!.isNotEmpty) {
          active = sorted[idx];
        }
        idx++;
      }

      if (active == null) continue;

      cards.add(
        WeekCard(
          key: ValueKey('week_card_$w'),
          weeklySession: WeeklySession(
            week: w,
            phase: active.phase,
            weeklyFocus: active.weeklyFocus,
            dailySessions: active.dailySessions,
          ),
          endWeek: w,
        ),
      );
    }
    return cards;
  }
}

class ProgramInfoCard extends ConsumerWidget {
  final TrainingProgram program;

  const ProgramInfoCard({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final startDate = program.startedAt;
    DateTime? endDate;
    if (startDate != null && program.durationWeeks != null) {
      endDate = startDate.add(Duration(days: program.durationWeeks! * 7));
    }

    return GlassmorphicContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.programTitle ?? "Your Plan",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              program.programDescripton ?? 'No description available.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (program.glossary != null)
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          _showGlossaryDialog(context, program.glossary!),
                      child: const InfoChip(
                        label: 'Glossary',
                        icon: Icons.book_outlined,
                      ),
                    ),
                  ),
                SizedBox(width: 12),
                if (program.programNotes != null)
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          _showNotesDialog(context, program.programNotes!),
                      child: const InfoChip(
                        label: 'Notes',
                        icon: Icons.notes_outlined,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),
            if (startDate != null)
              _buildDateInfo(theme, startDate, endDate)
            else
              GradientButton(
                text: 'Start Now',
                onPressed: () {
                  final uid = ref.read(appStateProvider).user?.uid;
                  if (uid != null && program.id != null) {
                    ref
                        .read(firestoreServiceProvider)
                        .startTrainingPlan(uid, program.id!);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(
    ThemeData theme,
    DateTime startDate,
    DateTime? endDate,
  ) {
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Started At:', style: theme.textTheme.bodyMedium),
            Text(formatter.format(startDate), style: theme.textTheme.bodyLarge),
          ],
        ),
        if (endDate != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ends At:', style: theme.textTheme.bodyMedium),
              Text(formatter.format(endDate), style: theme.textTheme.bodyLarge),
            ],
          ),
        ],
      ],
    );
  }

  void _showGlossaryDialog(BuildContext context, List<GlossaryItem> glossary) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1E3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Glossary', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: glossary.length,
            itemBuilder: (context, index) {
              final item = glossary[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.term ?? 'Term',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.definition ?? 'No definition.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFF40E0D0)),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotesDialog(BuildContext context, ProgramNotes notes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1E3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Program Notes',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (notes.safetyDisclaimer != null) ...[
                Text(
                  'Safety Disclaimer',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  notes.safetyDisclaimer!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
              ],
              if (notes.injuryModifications != null) ...[
                Text(
                  'Injury Modifications',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  notes.injuryModifications!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
              ],
              if (notes.assumptionsMade != null) ...[
                Text(
                  'Assumptions Made',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  notes.assumptionsMade!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFF40E0D0)),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const InfoChip({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Copied from PlanDisplay5 ---
class WeekCard extends StatefulWidget {
  final WeeklySession weeklySession;
  final int? endWeek;
  const WeekCard({super.key, required this.weeklySession, this.endWeek});

  @override
  State<WeekCard> createState() => _WeekCardState();
}

class _WeekCardState extends State<WeekCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final sessionMap = {
      for (var session in widget.weeklySession.dailySessions ?? [])
        if (session.dayOfTheWeek != null) session.dayOfTheWeek!: session,
    };

    final startWeek = widget.weeklySession.week;
    String weekTitle;

    if (startWeek != null) {
      if (widget.endWeek != null && widget.endWeek! > startWeek) {
        weekTitle = 'Weeks $startWeek-${widget.endWeek}';
      } else {
        weekTitle = 'Week $startWeek';
      }
    } else {
      weekTitle = 'Weekly Plan'; // Fallback
    }

    return GlassmorphicContainer(
      margin: const EdgeInsets.only(bottom: 20),
      borderRadius: 15,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Row(
                children: [
                  Text(
                    weekTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: Text(
                      widget.weeklySession.phase ?? "",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ConstrainedBox(
                constraints: _isExpanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      widget.weeklySession.weeklyFocus ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Divider(color: Colors.white24, height: 24),
                    ...daysOfWeek.map((day) {
                      final session = sessionMap[day];
                      if (session != null) {
                        return DayTile(session: session);
                      } else {
                        return RestDayTile(dayName: day);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestDayTile extends StatelessWidget {
  final String dayName;
  const RestDayTile({super.key, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              dayName,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Rest Day",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              session.dayOfTheWeek ?? "Day",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionDetailView(session: session),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.sessionType ?? "Session",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white70,
                      applyTextScaling: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveCalendarView extends StatelessWidget {
  final TrainingProgram program;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<DailySession>> events;
  final CalendarFormat calendarFormat;
  final AnimationController animationController;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final List<DailySession> Function(DateTime) getEventsForDay;

  const InteractiveCalendarView({
    super.key,
    required this.program,
    required this.focusedDay,
    this.selectedDay,
    required this.events,
    required this.calendarFormat,
    required this.animationController,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.getEventsForDay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CalendarWithGestures(
            focusedDay: focusedDay,
            selectedDay: selectedDay,
            calendarFormat: calendarFormat,
            events: events,
            onDaySelected: onDaySelected,
            onFormatChanged: onFormatChanged,
            onPageChanged: onPageChanged,
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
                key: ValueKey<DateTime?>(selectedDay),
                sessions: getEventsForDay(selectedDay!),
                selectedDate: selectedDay!,
                animationController: animationController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarWithGestures extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<DailySession>> events;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarWithGestures({
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
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
          daysOfWeekStyle: _daysOfWeekStyle(),
          calendarStyle: _calendarStyle(),
        ),
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
              width: 8,
              height: 8,
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

  HeaderStyle _headerStyle() {
    return HeaderStyle(
      titleCentered: true,
      formatButtonShowsNext: false,
      formatButtonTextStyle: const TextStyle(color: Colors.white),
      formatButtonDecoration: BoxDecoration(
        color: Color(0xFF007BFF),
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
    return const CalendarStyle(
      outsideDaysVisible: false,
      // All styling is now handled by calendarBuilders
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
              final intervalStart = (0.2 * index).clamp(0.0, 1.0);
              final intervalEnd = (intervalStart + 0.4).clamp(0.0, 1.0);

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
                              intervalStart,
                              intervalEnd,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animationController,
                        curve: Interval(
                          intervalStart,
                          intervalEnd,
                          curve: Curves.easeOut,
                        ),
                      ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionDetailView(session: session),
          ),
        );
      },
      child: GlassmorphicContainer(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        borderRadius: 15,
        child: ListTile(
          title: Text(
            session.sessionType ?? 'Session',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            session.sessionFocus ?? 'No focus',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.white70),
        ),
      ),
    );
  }
}

// --- Universal Helpers & Data ---
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

  // Pointer that always holds the last weeklySession that has non-empty dailySessions.
  WeeklySession? activeSession;
  int nextScheduleIdx = 0;

  for (int w = 1; w <= weeks; w++) {
    // Bump the schedule index if the next defined week starts now.
    if (nextScheduleIdx < sorted.length &&
        (sorted[nextScheduleIdx].week ?? 0) == w) {
      if (sorted[nextScheduleIdx].dailySessions != null &&
          sorted[nextScheduleIdx].dailySessions!.isNotEmpty) {
        activeSession = sorted[nextScheduleIdx];
      }
      nextScheduleIdx++;
    }

    // If we still don't have an activeSession with content, skip.
    if (activeSession == null) continue;

    final weekOffset = w - 1;
    for (final session in activeSession.dailySessions!) {
      final dow = _dayOfWeekToInt(session.dayOfTheWeek ?? '');
      if (dow == -1) continue;
      final date = startMonday.add(Duration(days: weekOffset * 7 + dow - 1));
      final key = DateTime(date.year, date.month, date.day);
      (events[key] ??= []).add(session);
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
