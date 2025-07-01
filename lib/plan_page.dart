import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sendtrain/home_page.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/plan_page_2.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/training_form.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';

class PlanPage extends ConsumerWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final TrainingProgram? selectedProgram = appState.selectedTrainingProgram;
    final List<TrainingProgram> allPrograms = appState.trainingPrograms ?? [];

    final TrainingProgram? programToDisplay =
        selectedProgram ?? (allPrograms.isNotEmpty ? allPrograms.first : null);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: programToDisplay != null
          ? PlanPage2(program: programToDisplay)
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CreatePlanCard(),
              ),
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
