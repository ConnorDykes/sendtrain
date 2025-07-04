import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/firebase_auth_service.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sendtrain/services/subscriptions_service.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
      return AuthStateNotifier(ref);
    });

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final Ref _ref;
  late final StreamSubscription _authStateSubscription;
  StreamSubscription? _userDocumentSubscription;

  AuthStateNotifier(this._ref) : super(const AsyncValue.loading()) {
    _authStateSubscription = _ref
        .read(firebaseAuthServiceProvider)
        .auth
        .authStateChanges()
        .listen(
          _onAuthStateChanged,
          onError: (error) =>
              state = AsyncValue.error(error, StackTrace.current),
        );
  }

  Future<void> _onAuthStateChanged(User? user) async {
    print('AuthStateNotifier: Auth state changed. User: ${user?.uid}');
    if (user == null) {
      state = const AsyncValue.data(null);
      await _userDocumentSubscription?.cancel();
      _ref.read(appStateProvider.notifier).setUser(null);
      print('AuthStateNotifier: User is null. Canceled user document stream.');
    } else {
      state = AsyncValue.data(user);
      await _userDocumentSubscription?.cancel();
      print(
        'AuthStateNotifier: Setting up new user document stream for ${user.uid}.',
      );
      _userDocumentSubscription = _ref
          .read(firestoreServiceProvider)
          .streamUser(user.uid)
          .listen(
            (appUser) {
              if (appUser != null) {
                print(
                  'AuthStateNotifier: Received user document update. appUser: ${appUser.firstName} ${appUser.lastName} isPremium: ${appUser.isPremium}',
                );
                _ref.read(appStateProvider.notifier).setUser(appUser);
                _ref
                    .read(subscriptionsServiceProvider)
                    .checkAndSyncSubscriptionStatus();
              }
            },
            onError: (error) {
              print('AuthStateNotifier: Error in user document stream: $error');
              state = AsyncValue.error(error, StackTrace.current);
            },
          );
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    _userDocumentSubscription?.cancel();
    super.dispose();
  }
}
