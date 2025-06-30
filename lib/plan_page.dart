import 'package:flutter/material.dart';
import 'package:sendtrain/agent_mockups/plan_display_1.dart';
import 'package:sendtrain/agent_mockups/plan_display_2.dart';
import 'package:sendtrain/agent_mockups/plan_display_3.dart';
import 'package:sendtrain/agent_mockups/plan_display_4.dart';
import 'package:sendtrain/agent_mockups/plan_display_5.dart';
import 'package:sendtrain/home_page.dart';
import 'package:sendtrain/plan_page_2.dart';
import 'package:sendtrain/training_form.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: PlanPage2(),
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
