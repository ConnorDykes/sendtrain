import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/services/subscriptions_service.dart';

final appLifecycleObserverProvider = Provider<AppLifecycleObserver>((ref) {
  final observer = AppLifecycleObserver(ref);
  WidgetsBinding.instance.addObserver(observer);
  ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));
  return observer;
});

class AppLifecycleObserver extends WidgetsBindingObserver {
  final Ref _ref;

  AppLifecycleObserver(this._ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _ref.read(subscriptionsServiceProvider).checkAndSyncSubscriptionStatus();
    }
    super.didChangeAppLifecycleState(state);
  }
}
