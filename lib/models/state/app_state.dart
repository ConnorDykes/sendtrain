import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sendtrain/models/user/user_model.dart';
import 'package:sendtrain/models/training_program/training_program.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    UserModel? user,
    List<TrainingProgram>? trainingPrograms,
    @Default(false) bool isGeneratingPlan,
  }) = _AppState;
}
