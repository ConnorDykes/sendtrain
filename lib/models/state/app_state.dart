import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/models/training_program/training_program.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    UserModel? user,
    List<TrainingProgram>? trainingPrograms,
    TrainingProgram? selectedTrainingProgram,
    @Default(false) bool isGeneratingPlan,
    @Default(true) bool isInitializing,
  }) = _AppState;

  factory AppState.initial() => const AppState();
}
