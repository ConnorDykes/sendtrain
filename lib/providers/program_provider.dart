import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:cloud_functions/cloud_functions.dart';

final trainingProgramProvider =
    StateNotifierProvider<
      TrainingProgramNotifier,
      AsyncValue<TrainingProgram?>
    >((ref) {
      return TrainingProgramNotifier();
    });

class TrainingProgramNotifier
    extends StateNotifier<AsyncValue<TrainingProgram?>> {
  TrainingProgramNotifier() : super(const AsyncValue.data(null));

  Future<void> generateProgram(Map<String, dynamic> userData) async {
    state = const AsyncValue.loading();
    try {
      final functions = FirebaseFunctions.instance;
      final callable = functions.httpsCallable('generateClimbingProgram');

      final response = await callable.call(userData);

      final programData = response.data['program'];
      if (programData != null) {
        final program = TrainingProgram.fromJson(
          Map<String, dynamic>.from(programData),
        );
        state = AsyncValue.data(program);
      } else {
        state = AsyncValue.error(
          'Failed to generate program: program data is null',
          StackTrace.current,
        );
      }
    } on FirebaseFunctionsException catch (e, s) {
      state = AsyncValue.error(
        'Firebase Functions Exception: ${e.code} - ${e.message}',
        s,
      );
    } catch (e, s) {
      state = AsyncValue.error('An error occurred: $e', s);
    }
  }
}
