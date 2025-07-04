import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sendtrain/firebase_options.dart';
import 'package:sendtrain/home_page.dart';
import 'package:sendtrain/login_page.dart';
import 'package:sendtrain/models/state/app_state.dart';
import 'package:sendtrain/providers/app_lifecycle_provider.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/providers/auth_state_listener.dart';
import 'package:sendtrain/services/firebase_auth_service.dart';
import 'package:sendtrain/services/notification_service.dart';
import 'package:sendtrain/services/subscriptions_service.dart';
import 'package:sendtrain/theme.dart';
import 'package:sendtrain/widgets/shared/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notification service
  final container = ProviderContainer();
  await container.read(notificationServiceProvider).init();
  await container.read(subscriptionsServiceProvider).init();

  runApp(
    UncontrolledProviderScope(container: container, child: const MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLifecycleObserverProvider);
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: authState.when(
        data: (user) => user != null ? const HomePage() : const LoginPage(),
        loading: () => const SplashScreen(),
        error: (error, stackTrace) => const LoginPage(), // Or an error screen
      ),
    );
  }
}
