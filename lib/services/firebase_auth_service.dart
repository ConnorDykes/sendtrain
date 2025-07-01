import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      print('🔐 Starting signup process for: $email');

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        print('✅ Firebase Auth user created: ${user.uid}');

        // Update the user's profile with their name
        await user.updateDisplayName('$firstName $lastName');
        await user.reload();
        print('✅ User display name updated');

        // Create user in firestore
        final newUser = UserModel(
          uid: user.uid,
          email: user.email,
          firstName: firstName,
          lastName: lastName,
        );

        print('📄 Creating Firestore user document...');
        await _firestoreService.createUser(newUser);
        print('✅ Firestore user document created successfully');

        // Give a moment for the auth state to propagate
        await Future.delayed(const Duration(milliseconds: 300));
        print('✅ Signup process completed for: $email');
      }

      return null; // Sign up successful
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth error during signup: ${e.code} - ${e.message}');
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
      print('❌ Unexpected error during signup: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      print('🔵 Starting Google Sign-In...');

      // Get the GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize if needed (you can also do this in main.dart)
      await googleSignIn.initialize();

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      print('🔵 Google credential received:');
      print('  - Email: ${googleUser.email}');
      print('  - Display Name: ${googleUser.displayName}');

      // Get authorization headers which contain the access token
      final Map<String, String>? authHeaders = await googleUser
          .authorizationClient
          .authorizationHeaders([]);

      if (authHeaders == null) {
        print('❌ Failed to get authorization headers');
        return 'Failed to get Google authorization.';
      }

      // Extract the access token from headers
      final String? accessToken = authHeaders['Authorization']?.replaceFirst(
        'Bearer ',
        '',
      );

      if (accessToken == null) {
        print('❌ No access token found in authorization headers');
        return 'Failed to get Google access token.';
      }

      // Create a new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: null, // idToken might not be available in the new API
      );

      // Sign in to Firebase with Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
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

          // First try Google displayName
          if (googleUser.displayName != null &&
              googleUser.displayName!.isNotEmpty) {
            final nameParts = googleUser.displayName!.split(' ');
            if (nameParts.isNotEmpty) {
              firstName = nameParts.first;
              if (nameParts.length > 1) {
                lastName = nameParts.skip(1).join(' ');
              }
            }
          }

          // Fallback to Firebase displayName if Google name is empty
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
            final email = user.email ?? googleUser.email;
            if (email.isNotEmpty) {
              firstName = email.split('@').first;
            }
          }

          print('📝 User data for Firestore:');
          print('  - First Name: "$firstName"');
          print('  - Last Name: "$lastName"');
          print('  - Email: ${user.email ?? googleUser.email}');

          final newUser = UserModel(
            uid: user.uid,
            email: user.email ?? googleUser.email,
            firstName: firstName.isNotEmpty ? firstName : null,
            lastName: lastName.isNotEmpty ? lastName : null,
            photoUrl: user.photoURL ?? googleUser.photoUrl,
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

      print('🔵 Google Sign-In completed successfully');
      return null; // Sign in successful
    } catch (e) {
      print('❌ Google Sign-In Error: $e');

      if (e is FirebaseAuthException) {
        print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
        if (e.code == 'account-exists-with-different-credential') {
          return 'An account already exists with a different sign-in method.';
        } else if (e.code == 'invalid-credential') {
          return 'The Google Sign-In credential is invalid.';
        }
        return 'Authentication failed. Please try again.';
      }

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
