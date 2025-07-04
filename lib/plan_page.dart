import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sendtrain/home_page.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/plan_page_2.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/subscriptions_service.dart';
import 'package:sendtrain/training_form.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';

class PlanPage extends ConsumerWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final isPremium = appState.user?.isPremium ?? false;
    final activeProgramAsync = ref.watch(activeTrainingProgramProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: activeProgramAsync.when(
        data: (programToDisplay) {
          if (programToDisplay != null) {
            return isPremium
                ? PlanDetailView(program: programToDisplay)
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: PremiumBlocker(),
                    ),
                  );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CreatePlanCard(),
              ),
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text('Error loading plan.')),
      ),
    );
  }
}

class PremiumBlocker extends ConsumerWidget {
  const PremiumBlocker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You must have a premium subscription to access your plan',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(subscriptionsServiceProvider).showPaywall();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }
}

class CreatePlanCard extends StatelessWidget {
  const CreatePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrainingForm()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
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
                mainAxisSize: MainAxisSize.min,
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
                    'Let our custom fine-tuned AI craft a unique training system tailored to your goals.',
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
