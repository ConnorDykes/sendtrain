import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/subscriptions_service.dart';

class SubscriptionSettingPage extends ConsumerStatefulWidget {
  const SubscriptionSettingPage({super.key});

  @override
  ConsumerState<SubscriptionSettingPage> createState() =>
      _SubscriptionSettingPageState();
}

class _SubscriptionSettingPageState
    extends ConsumerState<SubscriptionSettingPage> {
  CustomerInfo? customerInfo;
  @override
  void initState() {
    super.initState();
    ref.read(subscriptionsServiceProvider).checkAndSyncSubscriptionStatus();
    bool isPremium = ref.read(appStateProvider).user?.isPremium ?? false;
    if (!isPremium) {
      ref.read(subscriptionsServiceProvider).showPaywallIfNeeded();
    } else {
      getCustomerInfo();
    }
  }

  getCustomerInfo() async {
    final info = await ref.read(subscriptionsServiceProvider).getCustomerInfo();

    setState(() {
      customerInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(appStateProvider).user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Subscription')),
        body: const Center(child: Text('Not logged in')),
      );
    }

    bool isPremium = user.isPremium;

    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: isPremium
          ? _buildPremiumContent(context, user)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You are not a premium user',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(subscriptionsServiceProvider).showPaywall();
                  },
                  child: const Text('Join Premium'),
                ),
              ],
            ),
    );
  }

  Widget _buildPremiumContent(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, size: 100, color: theme.colorScheme.primary),
          const SizedBox(height: 24),
          Text('You are a Premium User!', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Thank you for your support. You can mange your subscription in the app store settings',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
