import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/firestore_service.dart';

part 'subscriptions_service.g.dart';

// This should be placed in a secure location, not hardcoded.
// For example, use environment variables.
// NOTE: You are using an older version of purchases_flutter.
// It is recommended to update to the latest version for more features and security updates.
final _revenueCatApiKey = dotenv.env['REVENUECAT_API_KEY'];

@riverpod
SubscriptionsService subscriptionsService(ref) {
  return SubscriptionsService(ref);
}

class SubscriptionsService {
  final Ref _ref;
  SubscriptionsService(this._ref);

  Future<void> init() async {
    if (_revenueCatApiKey != null) {
      await Purchases.setLogLevel(LogLevel.debug);
      // TODO this is just iOS
      final configuration = PurchasesConfiguration(_revenueCatApiKey!);
      await Purchases.configure(configuration);
      listenForSubscriptionStatus();
    }
  }

  void listenForSubscriptionStatus() {
    Purchases.addCustomerInfoUpdateListener((info) {
      checkAndSyncSubscriptionStatus();
    });
  }

  Future<void> checkAndSyncSubscriptionStatus() async {
    print('checkAndSyncSubscriptionStatus');
    final user = _ref.read(appStateProvider).user;
    if (user == null ||
        user.email == "test@email.com" ||
        user.email == "connormdykes@gmail.com")
      return;

    final firestoreService = _ref.read(firestoreServiceProvider);

    try {
      final customerInfo = await getCustomerInfo();
      final isPremiumFromRevenueCat = customerInfo.entitlements.active
          .containsKey('premium');
      print('isPremiumFromRevenueCat: $isPremiumFromRevenueCat');

      if (isPremiumFromRevenueCat != user.isPremium) {
        await firestoreService.updateUserPremiumStatus(
          user.uid,
          isPremiumFromRevenueCat,
        );
        // // Update local state immediately
        // final updatedUser = user.copyWith(isPremium: isPremiumFromRevenueCat);
        // _ref.read(appStateProvider.notifier).setUser(updatedUser);
      }
    } catch (e) {
      print('Error syncing subscription status: $e');
    }
  }

  Future<CustomerInfo> getCustomerInfo() async {
    return await Purchases.getCustomerInfo();
  }

  Future<void> showPaywall() async {
    try {
      await RevenueCatUI.presentPaywall();
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> showPaywallIfNeeded() async {
    try {
      if (await Purchases.isConfigured) {
        await RevenueCatUI.presentPaywallIfNeeded("premium");
      } else {
        print("Purchases is not configured");
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<List<Package>> getOfferings() async {
    try {
      final Offerings offerings = await Purchases.getOfferings();
      final Offering? defaultOffering = offerings.all['default'];

      if (defaultOffering != null) {
        return defaultOffering.availablePackages;
      }

      final current = offerings.current;
      return current == null ? [] : current.availablePackages;
    } on PlatformException catch (e) {
      // Handle error
      print(e);
      return [];
    }
  }

  Future<bool> makePurchase(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        // Handle error
        print(e);
      }
      return false;
    }
  }

  Future<bool> isSubscribed() async {
    try {
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      // Check if any entitlement is active
      return customerInfo.entitlements.active.isNotEmpty;
    } on PlatformException catch (e) {
      // Handle error
      print(e);
      return false;
    }
  }
}
