import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/models/state/app_state.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sendtrain/services/notification_service.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void setUser(UserModel? user) {
    print(
      '🔄 AppStateNotifier: Setting user - ${user?.firstName} ${user?.lastName}',
    );
    state = state.copyWith(user: user);
  }

  void setIsGeneratingPlan(bool isGenerating) {
    state = state.copyWith(isGeneratingPlan: isGenerating);
  }

  void doneGeneratingPlan() {
    state = state.copyWith(isGeneratingPlan: false);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((
  ref,
) {
  return AppStateNotifier();
});

final activeTrainingProgramProvider = StreamProvider<TrainingProgram?>((ref) {
  final appState = ref.watch(appStateProvider);
  final user = appState.user;

  if (user == null ||
      user.activeProgramId == null ||
      user.activeProgramId!.isEmpty) {
    return Stream.value(null);
  }

  final firestoreService = ref.watch(firestoreServiceProvider);
  final stream = firestoreService.streamActiveTrainingPlan(
    user.uid,
    user.activeProgramId!,
  );

  return stream.map((programs) => programs.isNotEmpty ? programs.first : null);
});
