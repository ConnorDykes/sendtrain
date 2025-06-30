import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_program.freezed.dart';
part 'training_program.g.dart';

@freezed
abstract class TrainingProgram with _$TrainingProgram {
  const TrainingProgram._();

  const factory TrainingProgram({
    String? id,
    String? programTitle,
    String? programFocus,
    int? durationWeeks,
    String? programDescripton,
    ProgramNotes? programNotes,
    List<WeeklySession>? weeklySchedule,
    List<GlossaryItem>? glossary,
    DateTime? startedAt,
  }) = _TrainingProgram;

  factory TrainingProgram.fromJson(Map<String, dynamic> json) =>
      _$TrainingProgramFromJson(json);

  /// Finds the relevant weekly session for a given week number.
  ///
  /// If an exact match for the [targetWeek] is not found, it returns the
  /// session for the most recent week prior to the [targetWeek].
  /// For example, if sessions for week 1 and 5 exist, asking for week 3
  /// will return the session for week 1.
  /// Returns `null` if no suitable session can be found (e.g., if the
  /// schedule is empty or the [targetWeek] is before the first scheduled week).
  WeeklySession? getWeeklySessionForWeek(int targetWeek) {
    if (weeklySchedule?.isEmpty ?? true) {
      return null;
    }

    // Sort the schedule by week to ensure correct logic.
    final sortedSchedule = [...weeklySchedule ?? []]
      ..sort((a, b) => (a.week ?? 0).compareTo(b.week ?? 0));

    // Find all sessions that occur on or before the target week.
    final applicableSessions = sortedSchedule
        .where((s) => (s.week ?? 0) <= targetWeek)
        .toList();

    // If there are any such sessions, return the last one (the most recent one).
    if (applicableSessions.isNotEmpty) {
      return applicableSessions.last;
    }

    // If no session is found (e.g., targetWeek is before the first week), return null.
    return null;
  }
}

@freezed
abstract class ProgramNotes with _$ProgramNotes {
  const factory ProgramNotes({
    String? safetyDisclaimer,
    String? injuryModifications,
    String? assumptionsMade,
  }) = _ProgramNotes;

  factory ProgramNotes.fromJson(Map<String, dynamic> json) =>
      _$ProgramNotesFromJson(json);
}

@freezed
abstract class WeeklySession with _$WeeklySession {
  const factory WeeklySession({
    int? week,
    String? phase,
    String? weeklyFocus,
    List<DailySession>? dailySessions,
  }) = _WeeklySession;

  factory WeeklySession.fromJson(Map<String, dynamic> json) =>
      _$WeeklySessionFromJson(json);
}

@freezed
abstract class DailySession with _$DailySession {
  const factory DailySession({
    int? sessionNumber,
    String? dayOfTheWeek,
    String? sessionType,
    String? sessionFocus,
    SessionPhase? warmUp,
    SessionPhase? mainSession,
    SessionPhase? coolDown,
  }) = _DailySession;

  factory DailySession.fromJson(Map<String, dynamic> json) =>
      _$DailySessionFromJson(json);
}

@freezed
abstract class SessionPhase with _$SessionPhase {
  @JsonSerializable(explicitToJson: true)
  const factory SessionPhase({
    int? durationMinutes,
    List<Exercise>? exercises,
    List<Exercise>? activities,
  }) = _SessionPhase;

  factory SessionPhase.fromJson(Map<String, dynamic> json) =>
      _$SessionPhaseFromJson(json);
}

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    String? exerciseName,
    String? details,
    String? requiredEquipment,
    String? sets,
    String? reps,
    String? rest,
    String? intensity,
    String? estimatedCompletionTime,
    String? howToAdjust,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}

@freezed
abstract class GlossaryItem with _$GlossaryItem {
  const factory GlossaryItem({String? term, String? definition}) =
      _GlossaryItem;

  factory GlossaryItem.fromJson(Map<String, dynamic> json) =>
      _$GlossaryItemFromJson(json);
}
