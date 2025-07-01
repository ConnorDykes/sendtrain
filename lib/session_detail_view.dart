import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';

class SessionDetailView extends StatefulWidget {
  final DailySession session;
  const SessionDetailView({super.key, required this.session});

  @override
  State<SessionDetailView> createState() => _SessionDetailViewState();
}

class _SessionDetailViewState extends State<SessionDetailView> {
  late final PageController _pageController;
  int _currentPage = 0;

  late final List<_PhaseItem> _phases;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _phases = [
      if (widget.session.warmUp != null)
        _PhaseItem('Warm Up', widget.session.warmUp!),
      if (widget.session.mainSession != null)
        _PhaseItem('Main Session', widget.session.mainSession!),
      if (widget.session.coolDown != null)
        _PhaseItem('Cool Down', widget.session.coolDown!),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.session.sessionType ?? 'Session'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            children: [
              _buildSessionHeader(),
              if (_phases.isNotEmpty) ...[
                _buildPhaseIndicator(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _phases.length,
                    onPageChanged: (page) =>
                        setState(() => _currentPage = page),
                    itemBuilder: (context, index) {
                      return _AnimatedPhaseView(phase: _phases[index].phase);
                    },
                  ),
                ),
              ] else
                const Expanded(
                  child: Center(
                    child: Text(
                      'This session has no activities.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionHeader() {
    final session = widget.session;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (session.sessionFocus != null)
            Text(
              session.sessionFocus!,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (session.dayOfTheWeek != null) ...[
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  session.dayOfTheWeek!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_phases.length, (index) {
          final isSelected = _currentPage == index;
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _phases[index].title,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PhaseItem {
  final String title;
  final SessionPhase phase;
  _PhaseItem(this.title, this.phase);
}

class _AnimatedPhaseView extends StatefulWidget {
  final SessionPhase phase;
  const _AnimatedPhaseView({required this.phase});

  @override
  _AnimatedPhaseViewState createState() => _AnimatedPhaseViewState();
}

class _AnimatedPhaseViewState extends State<_AnimatedPhaseView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    final exercises = widget.phase.exercises ?? widget.phase.activities ?? [];
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250 * (exercises.isNotEmpty ? exercises.length : 1),
      ),
    );
    _animations = List.generate(exercises.length, (index) {
      final start = index / exercises.length;
      final end = start + 0.5;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end > 1.0 ? 1.0 : end, curve: Curves.easeOut),
        ),
      );
    });

    if (exercises.isNotEmpty) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = widget.phase.exercises ?? widget.phase.activities ?? [];
    if (exercises.isEmpty) {
      return const Center(
        child: Text(
          'No activities for this phase.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return FadeTransition(
          opacity: _animations[index],
          child: SlideTransition(
            position: _animations[index].drive(
              Tween(begin: const Offset(0.3, 0), end: Offset.zero),
            ),
            child: _ExerciseCard(exercise: exercises[index]),
          ),
        );
      },
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.15),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.exerciseName ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            if (exercise.details != null)
              Text(
                exercise.details!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (exercise.sets != null) _buildInfo('Sets', exercise.sets!),
                if (exercise.reps != null) _buildInfo('Reps', exercise.reps!),
                if (exercise.rest != null) _buildInfo('Rest', exercise.rest!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
