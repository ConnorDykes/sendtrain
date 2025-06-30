import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sendtrain/firebase_options.dart';
import 'package:sendtrain/home_page.dart';
import 'package:sendtrain/login_page.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/providers/auth_state_listener.dart';
import 'package:sendtrain/services/notification_service.dart';
import 'package:sendtrain/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notification service
  final container = ProviderContainer();
  await container.read(notificationServiceProvider).init();

  runApp(
    UncontrolledProviderScope(container: container, child: const MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateListenerProvider);
    final appState = ref.watch(appStateProvider);
    final user = appState.user;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: user != null ? const HomePage() : const LoginPage(),
    );
  }
}
