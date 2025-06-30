import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(
    FirebaseAuth.instance,
    ref.read(firestoreServiceProvider),
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthServiceProvider)._auth.authStateChanges();
});

class FirebaseAuthService {
  final FirebaseAuth _auth;
  final FirestoreService _firestoreService;

  FirebaseAuthService(this._auth, this._firestoreService);

  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        // Update the user's profile with their name
        await user.updateDisplayName('$firstName $lastName');
        await user.reload();

        // Create user in firestore
        final newUser = UserModel(
          uid: user.uid,
          email: user.email,
          firstName: firstName,
          lastName: lastName,
        );
        await _firestoreService.createUser(newUser);
      }

      return null; // Sign up successful
    } on FirebaseAuthException catch (e) {
      // Return a user-friendly error message
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      }
      return 'An unexpected error occurred. Please try again.';
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String?> signInWithApple() async {
    try {
      print('🍎 Starting Apple Sign-In...');

      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print('🍎 Apple credential received:');
      print('  - Email: ${appleCredential.email}');
      print('  - Given Name: ${appleCredential.givenName}');
      print('  - Family Name: ${appleCredential.familyName}');

      // Create OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with Apple credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        oauthCredential,
      );

      final user = userCredential.user;
      if (user != null) {
        print('🔥 Firebase user created/signed in:');
        print('  - UID: ${user.uid}');
        print('  - Email: ${user.email}');
        print('  - Display Name: ${user.displayName}');

        // Check if user exists in Firestore
        final existingUser = await _firestoreService.fetchUser(user.uid);

        if (existingUser == null) {
          print('📄 Creating new Firestore user document...');

          // Extract names with better fallback logic
          String firstName = '';
          String lastName = '';

          // First try Apple credential (only available on first sign-in)
          if (appleCredential.givenName != null &&
              appleCredential.givenName!.isNotEmpty) {
            firstName = appleCredential.givenName!;
          }
          if (appleCredential.familyName != null &&
              appleCredential.familyName!.isNotEmpty) {
            lastName = appleCredential.familyName!;
          }

          // Fallback to Firebase displayName if Apple names are empty
          if (firstName.isEmpty &&
              lastName.isEmpty &&
              user.displayName != null) {
            final nameParts = user.displayName!.split(' ');
            if (nameParts.isNotEmpty) {
              firstName = nameParts.first;
              if (nameParts.length > 1) {
                lastName = nameParts.skip(1).join(' ');
              }
            }
          }

          // Final fallback - use email prefix if no name available
          if (firstName.isEmpty) {
            final email = user.email ?? appleCredential.email ?? '';
            if (email.isNotEmpty) {
              firstName = email.split('@').first;
            }
          }

          print('📝 User data for Firestore:');
          print('  - First Name: "$firstName"');
          print('  - Last Name: "$lastName"');
          print('  - Email: ${user.email ?? appleCredential.email}');

          final newUser = UserModel(
            uid: user.uid,
            email: user.email ?? appleCredential.email,
            firstName: firstName.isNotEmpty ? firstName : null,
            lastName: lastName.isNotEmpty ? lastName : null,
            photoUrl: user.photoURL,
          );

          await _firestoreService.createUser(newUser);
          print('✅ Firestore user document created successfully');
        } else {
          print('📄 User already exists in Firestore');
        }

        // Wait a moment for Firestore to propagate
        await Future.delayed(const Duration(milliseconds: 500));

        // Double-check that user is actually signed in
        final currentUser = _auth.currentUser;
        print(
          '🔍 Current Firebase Auth user after sign-in: ${currentUser?.uid}',
        );
      }

      print('🍎 Apple Sign-In completed successfully');
      return null; // Sign in successful
    } on SignInWithAppleAuthorizationException catch (e) {
      print('❌ Apple Sign-In Authorization Error: ${e.code}');
      if (e.code == AuthorizationErrorCode.failed) {
        return 'Apple Sign-In failed. Please try again.';
      }
      return 'An error occurred with Apple Sign-In.';
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      if (e.code == 'account-exists-with-different-credential') {
        return 'An account already exists with a different sign-in method.';
      } else if (e.code == 'invalid-credential') {
        return 'The Apple Sign-In credential is invalid.';
      }
      return 'Authentication failed. Please try again.';
    } catch (e) {
      print('❌ Unexpected Apple Sign-In Error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
