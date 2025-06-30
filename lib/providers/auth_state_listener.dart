import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/firebase_auth_service.dart';
import 'package:sendtrain/services/firestore_service.dart';

final authStateListenerProvider = Provider<AuthStateListener>((ref) {
  final listener = AuthStateListener(ref);
  ref.onDispose(listener.dispose);
  return listener;
});

class AuthStateListener {
  final Ref _ref;
  StreamSubscription? _userStreamSubscription;

  AuthStateListener(this._ref) {
    print('🎧 AuthStateListener initialized');
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _ref.listen<AsyncValue<User?>>(authStateChangesProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            print('🔄 Auth state changed - User signed in: ${user.uid}');

            // Fetch user from Firestore with retry logic
            _fetchUserWithRetry(user.uid);
          } else {
            print('🔄 Auth state changed - User signed out');
            _ref.read(appStateProvider.notifier).setUser(null);
          }
        },
        loading: () {
          print('🔄 Auth state loading...');
        },
        error: (error, stackTrace) {
          print('❌ Auth state error: $error');
          _ref.read(appStateProvider.notifier).setUser(null);
        },
      );
    });
  }

  Future<void> _fetchUserWithRetry(String uid, {int retryCount = 0}) async {
    try {
      final appUser = await _ref.read(firestoreServiceProvider).fetchUser(uid);

      if (appUser != null) {
        print(
          '✅ User found in Firestore: ${appUser.firstName} ${appUser.lastName}',
        );
        _ref.read(appStateProvider.notifier).setUser(appUser);
      } else if (retryCount < 3) {
        // Retry after a short delay (for Apple Sign-In timing issues)
        print(
          '⏳ User not found in Firestore, retrying... (${retryCount + 1}/3)',
        );
        await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));
        await _fetchUserWithRetry(uid, retryCount: retryCount + 1);
      } else {
        print('❌ User not found in Firestore after 3 retries');
        // User authenticated but no Firestore document - this shouldn't happen
        // but we should handle it gracefully
      }
    } catch (error) {
      print('❌ Error fetching user from Firestore: $error');
      if (retryCount < 2) {
        await Future.delayed(Duration(milliseconds: 1000 * (retryCount + 1)));
        await _fetchUserWithRetry(uid, retryCount: retryCount + 1);
      }
    }
  }

  void dispose() {
    // The stream subscriptions are now managed within their respective notifiers,
    // so we may not need to cancel them explicitly here anymore if the
    // notifiers handle their own lifecycle.
  }
}
