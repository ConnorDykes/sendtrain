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
import 'package:sendtrain/services/subscriptions_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
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
    final appState = ref.watch(appStateProvider);
    final activeProgramAsync = ref.watch(activeTrainingProgramProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SendTrainLogo(),
          const SizedBox(height: 32),
          if (appState.isGeneratingPlan)
            _buildGeneratingPlanCard(context)
          else
            activeProgramAsync.when(
              data: (activeProgram) {
                if (activeProgram != null) {
                  return Column(
                    children: [
                      NextSessionCard(program: activeProgram),
                      const SizedBox(height: 16),
                      WeeklyCalendar(program: activeProgram),
                      const SizedBox(height: 16),
                      _TrainingProgramCard(
                        program: activeProgram,
                        onViewPlan: onViewPlan,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  const Text('Error loading training plan.'),
            ),
          const SizedBox(height: 24),
          _buildCreatePlanCard(context, ref),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _handleCreatePlan(BuildContext context, WidgetRef ref) {
    final activeProgram = ref.watch(activeTrainingProgramProvider).value;

    if (activeProgram != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Replace Active Plan?'),
          content: const Text(
            'You already have an active training plan. Creating a new one will archive your current plan. Are you sure you want to continue?',
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

  Widget _buildCreatePlanCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final activeProgram = ref.watch(activeTrainingProgramProvider).value;

    return GestureDetector(
      onTap: () => _handleCreatePlan(context, ref),
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
                      activeProgram != null
                          ? 'Create New Plan'
                          : 'Create a Training Plan',
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

  Widget _buildGeneratingPlanCard(BuildContext context) {
    final theme = Theme.of(context);
    return _buildGlassmorphicCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            CircularProgressIndicator(color: theme.colorScheme.secondary),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Generating Your Personalized Plan...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
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
}

class _TrainingProgramCard extends ConsumerWidget {
  final TrainingProgram program;
  final VoidCallback onViewPlan;

  const _TrainingProgramCard({required this.program, required this.onViewPlan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPremium = ref.watch(appStateProvider).user?.isPremium ?? false;

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
                if (isPremium) {
                  onViewPlan();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) => AlertDialog(
                      title: const Text('Subscription Required'),
                      content: const Text(
                        'You must have an active subscription to view your training plans.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Subscribe'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            ref
                                .read(subscriptionsServiceProvider)
                                .showPaywall();
                          },
                        ),
                      ],
                    ),
                  );
                }
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
