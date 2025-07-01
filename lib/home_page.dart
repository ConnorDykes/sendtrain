import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/profile_page.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/providers/program_provider.dart';
import 'package:sendtrain/training_form.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/plan_page.dart';
import 'package:sendtrain/widgets/shared/sendtrain_logo.dart';
import 'package:collection/collection.dart';
import 'package:sendtrain/widgets/shared/next_session_card.dart';
import 'package:sendtrain/widgets/shared/weekly_calendar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        ref.read(appStateProvider.notifier).setSelectedTrainingProgram(null);
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(appStateProvider).user;

    final List<Widget> pages = [
      if (user != null)
        _HomeContent(user: user, onViewPlan: () => _onItemTapped(1)),
      const PlanPage(),
      if (user != null) ProfilePage(user: user),
    ];

    return Scaffold(
      extendBody: true,
      body: BackgroundContainer(
        child: SafeArea(child: pages.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: _buildBottomNavBar(theme),
    );
  }

  Widget _buildBottomNavBar(ThemeData theme) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: theme.colorScheme.secondary,

      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Plan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _HomeContent extends ConsumerWidget {
  final UserModel user;
  final VoidCallback onViewPlan;
  const _HomeContent({required this.user, required this.onViewPlan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appState = ref.watch(appStateProvider);
    final trainingPrograms = appState.trainingPrograms ?? [];
    final activeProgram = trainingPrograms.firstWhereOrNull(
      (p) => p.startedAt != null,
    );
    final hasActiveProgram = trainingPrograms.any((p) => p.startedAt != null);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SendTrainLogo(),
          const SizedBox(height: 32),
          if (appState.isGeneratingPlan)
            _buildGeneratingPlanCard(context)
          else if (trainingPrograms.isNotEmpty) ...[
            if (activeProgram != null) ...[
              NextSessionCard(program: activeProgram),
              WeeklyCalendar(program: activeProgram),
            ],
            ...trainingPrograms.map(
              (p) => _TrainingProgramCard(program: p, onViewPlan: onViewPlan),
            ),
            const SizedBox(height: 24),
            _buildSecondaryCreatePlanCard(
              context,
              hasActiveProgram,
              trainingPrograms,
            ),
          ] else
            const CreatePlanCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGeneratingPlanCard(BuildContext context) {
    final theme = Theme.of(context);
    return _buildGlassmorphicCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            CircularProgressIndicator(color: theme.colorScheme.secondary),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Generating Your Personalized Plan...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This can take a number of minutes. We will notify you when it is ready.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasReachedGenerationLimit(List<TrainingProgram> programs) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final recentPlans = programs.where((program) {
      // Note: Using createdAt if available, otherwise falling back to a reasonable default
      final createdDate = program.startedAt ?? DateTime.now();
      return createdDate.isAfter(thirtyDaysAgo);
    }).length;

    return recentPlans >= 3;
  }

  void _showGenerationLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Plan Generation Limit Reached'),
        content: const Text(
          'Oops, you\'ve reached your limit on plan generation for this month. You can only generate 3 plans every 30 days.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleCreatePlan(
    BuildContext context,
    List<TrainingProgram> trainingPrograms,
  ) {
    // Check generation limit first
    if (_hasReachedGenerationLimit(trainingPrograms)) {
      _showGenerationLimitDialog(context);
      return;
    }

    final hasActiveProgram = trainingPrograms.any((p) => p.startedAt != null);

    if (hasActiveProgram) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Replace Active Plan?'),
          content: const Text(
            'You already have an active training plan. Creating a new one will remove your current plan. Are you sure you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrainingForm()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TrainingForm()),
      );
    }
  }

  Widget _buildSecondaryCreatePlanCard(
    BuildContext context,
    bool hasActiveProgram,
    List<TrainingProgram> trainingPrograms,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _handleCreatePlan(context, trainingPrograms),
      child: _buildGlassmorphicCard(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              const Icon(
                Icons.auto_awesome_outlined,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create A Training Plan',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Let our custom AI craft a unique training system tailored to your goals.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrainingProgramCard extends ConsumerWidget {
  final TrainingProgram program;
  final VoidCallback onViewPlan;

  const _TrainingProgramCard({required this.program, required this.onViewPlan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.programTitle ?? '',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            program.programFocus ?? '',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.timer_outlined,
            '${program.durationWeeks} Weeks',
            context,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(appStateProvider.notifier)
                    .setSelectedTrainingProgram(program);
                onViewPlan();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('View Plan'),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

Widget _buildGlassmorphicCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: child,
      ),
    ),
  );
}

Widget _buildStatItem(
  String title,
  String value,
  IconData icon,
  ThemeData theme,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 16),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlanItem(
  String title,
  String time,
  IconData icon,
  ThemeData theme,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 16),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const Spacer(),
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white54),
        ),
      ],
    ),
  );
}

class CreatePlanCard extends ConsumerWidget {
  const CreatePlanCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appState = ref.watch(appStateProvider);
    final trainingPrograms = appState.trainingPrograms ?? [];

    return GestureDetector(
      onTap: () {
        // Check generation limit first
        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
        final recentPlans = trainingPrograms.where((program) {
          final createdDate = program.startedAt ?? DateTime.now();
          return createdDate.isAfter(thirtyDaysAgo);
        }).length;

        if (recentPlans >= 3) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Plan Generation Limit Reached'),
              content: const Text(
                'Oops, you\'ve reached your limit on plan generation for this month. You can only generate 3 plans every 30 days.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrainingForm()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.auto_awesome_outlined,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create A Training Plan',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let our custom AI craft a unique training system tailored to your goals.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
