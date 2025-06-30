import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/providers/app_state_provider.dart';

class ProfilePage extends ConsumerWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 50),
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          _buildStatsCard(context),
          const SizedBox(height: 24),
          _buildOptionsList(context, ref),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: user.photoUrl != null
              ? NetworkImage(user.photoUrl!)
              : null,
          child: user.photoUrl == null
              ? Icon(
                  Icons.person,
                  size: 50,
                  color: theme.scaffoldBackgroundColor,
                )
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          '${user.firstName ?? ''} ${user.lastName ?? ''}',
          style: theme.textTheme.displayMedium?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          user.email ?? 'No email',
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(count: '12k', label: 'Followers'),
                _StatItem(count: '1.2k', label: 'Following'),
                _StatItem(count: '32', label: 'Projects'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          _buildOptionTile(context, icon: Icons.payment, title: 'Subscripton'),
          _buildOptionTile(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy & Security',
          ),
          _buildOptionTile(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _logout(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: theme.textTheme.bodyLarge),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear app state
      ref.read(appStateProvider.notifier).setUser(null);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${error.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.displaySmall?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
