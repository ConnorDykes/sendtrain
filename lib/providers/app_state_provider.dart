import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/models/state/app_state.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sendtrain/services/notification_service.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final Ref _ref;
  StreamSubscription? _trainingPlansSubscription;

  AppStateNotifier(this._ref) : super(const AppState());

  void setUser(UserModel? user) {
    print(
      '🔄 AppStateNotifier: Setting user - ${user?.firstName} ${user?.lastName}',
    );
    state = state.copyWith(user: user, isInitializing: false);
    if (user != null) {
      _listenToTrainingPlans(user.uid);
    } else {
      _cancelTrainingPlansSubscription();
      state = state.copyWith(trainingPrograms: null);
    }
  }

  void setIsInitializing(bool isInitializing) {
    state = state.copyWith(isInitializing: isInitializing);
  }

  void _listenToTrainingPlans(String uid) {
    _cancelTrainingPlansSubscription();
    final plansStream = _ref
        .read(firestoreServiceProvider)
        .streamTrainingPlans(uid);
    _trainingPlansSubscription = plansStream.listen((plans) {
      bool shouldStopGenerating = false;

      if (state.isGeneratingPlan &&
          plans.length > (state.trainingPrograms?.length ?? 0)) {
        _ref
            .read(notificationServiceProvider)
            .showNotification(
              'Your Plan is Ready!',
              'Your new personalized training system is ready when you are.',
            );
        shouldStopGenerating = true;
      }

      // Only update state if something has actually changed
      final newIsGenerating = shouldStopGenerating
          ? false
          : state.isGeneratingPlan;
      if (state.trainingPrograms != plans ||
          state.isGeneratingPlan != newIsGenerating) {
        state = state.copyWith(
          trainingPrograms: plans,
          isGeneratingPlan: newIsGenerating,
        );
      }
    });
  }

  void setIsGeneratingPlan(bool isGenerating) {
    state = state.copyWith(isGeneratingPlan: isGenerating);
  }

  void _cancelTrainingPlansSubscription() {
    _trainingPlansSubscription?.cancel();
  }

  void doneGeneratingPlan() {
    state = state.copyWith(isGeneratingPlan: false);
  }

  void setSelectedTrainingProgram(TrainingProgram? program) {
    state = state.copyWith(selectedTrainingProgram: program);
  }

  @override
  void dispose() {
    _cancelTrainingPlansSubscription();
    super.dispose();
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((
  ref,
) {
  return AppStateNotifier(ref);
});
