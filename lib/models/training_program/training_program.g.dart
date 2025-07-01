// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingProgram _$TrainingProgramFromJson(Map<String, dynamic> json) =>
    _TrainingProgram(
      id: json['id'] as String?,
      programTitle: json['programTitle'] as String?,
      programFocus: json['programFocus'] as String?,
      durationWeeks: (json['durationWeeks'] as num?)?.toInt(),
      programDescripton: json['programDescripton'] as String?,
      programNotes: json['programNotes'] == null
          ? null
          : ProgramNotes.fromJson(json['programNotes'] as Map<String, dynamic>),
      weeklySchedule: (json['weeklySchedule'] as List<dynamic>?)
          ?.map((e) => WeeklySession.fromJson(e as Map<String, dynamic>))
          .toList(),
      glossary: (json['glossary'] as List<dynamic>?)
          ?.map((e) => GlossaryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      startedAt: const TimestampConverter().fromJson(json['startedAt']),
    );

Map<String, dynamic> _$TrainingProgramToJson(_TrainingProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'programTitle': instance.programTitle,
      'programFocus': instance.programFocus,
      'durationWeeks': instance.durationWeeks,
      'programDescripton': instance.programDescripton,
      'programNotes': instance.programNotes,
      'weeklySchedule': instance.weeklySchedule,
      'glossary': instance.glossary,
      'startedAt': const TimestampConverter().toJson(instance.startedAt),
    };

_ProgramNotes _$ProgramNotesFromJson(Map<String, dynamic> json) =>
    _ProgramNotes(
      safetyDisclaimer: json['safetyDisclaimer'] as String?,
      injuryModifications: json['injuryModifications'] as String?,
      assumptionsMade: json['assumptionsMade'] as String?,
    );

Map<String, dynamic> _$ProgramNotesToJson(_ProgramNotes instance) =>
    <String, dynamic>{
      'safetyDisclaimer': instance.safetyDisclaimer,
      'injuryModifications': instance.injuryModifications,
      'assumptionsMade': instance.assumptionsMade,
    };

_WeeklySession _$WeeklySessionFromJson(Map<String, dynamic> json) =>
    _WeeklySession(
      week: (json['week'] as num?)?.toInt(),
      phase: json['phase'] as String?,
      weeklyFocus: json['weeklyFocus'] as String?,
      dailySessions: (json['dailySessions'] as List<dynamic>?)
          ?.map((e) => DailySession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeeklySessionToJson(_WeeklySession instance) =>
    <String, dynamic>{
      'week': instance.week,
      'phase': instance.phase,
      'weeklyFocus': instance.weeklyFocus,
      'dailySessions': instance.dailySessions,
    };

_DailySession _$DailySessionFromJson(Map<String, dynamic> json) =>
    _DailySession(
      sessionNumber: (json['sessionNumber'] as num?)?.toInt(),
      dayOfTheWeek: json['dayOfTheWeek'] as String?,
      sessionType: json['sessionType'] as String?,
      sessionFocus: json['sessionFocus'] as String?,
      warmUp: json['warmUp'] == null
          ? null
          : SessionPhase.fromJson(json['warmUp'] as Map<String, dynamic>),
      mainSession: json['mainSession'] == null
          ? null
          : SessionPhase.fromJson(json['mainSession'] as Map<String, dynamic>),
      coolDown: json['coolDown'] == null
          ? null
          : SessionPhase.fromJson(json['coolDown'] as Map<String, dynamic>),
      completeAt: const TimestampConverter().fromJson(json['completeAt']),
    );

Map<String, dynamic> _$DailySessionToJson(_DailySession instance) =>
    <String, dynamic>{
      'sessionNumber': instance.sessionNumber,
      'dayOfTheWeek': instance.dayOfTheWeek,
      'sessionType': instance.sessionType,
      'sessionFocus': instance.sessionFocus,
      'warmUp': instance.warmUp,
      'mainSession': instance.mainSession,
      'coolDown': instance.coolDown,
      'completeAt': const TimestampConverter().toJson(instance.completeAt),
    };

_SessionPhase _$SessionPhaseFromJson(Map<String, dynamic> json) =>
    _SessionPhase(
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionPhaseToJson(_SessionPhase instance) =>
    <String, dynamic>{
      'durationMinutes': instance.durationMinutes,
      'exercises': instance.exercises?.map((e) => e.toJson()).toList(),
      'activities': instance.activities?.map((e) => e.toJson()).toList(),
    };

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  exerciseName: json['exerciseName'] as String?,
  details: json['details'] as String?,
  requiredEquipment: json['requiredEquipment'] as String?,
  sets: json['sets'] as String?,
  reps: json['reps'] as String?,
  rest: json['rest'] as String?,
  intensity: json['intensity'] as String?,
  estimatedCompletionTime: json['estimatedCompletionTime'] as String?,
  howToAdjust: json['howToAdjust'] as String?,
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'exerciseName': instance.exerciseName,
  'details': instance.details,
  'requiredEquipment': instance.requiredEquipment,
  'sets': instance.sets,
  'reps': instance.reps,
  'rest': instance.rest,
  'intensity': instance.intensity,
  'estimatedCompletionTime': instance.estimatedCompletionTime,
  'howToAdjust': instance.howToAdjust,
};

_GlossaryItem _$GlossaryItemFromJson(Map<String, dynamic> json) =>
    _GlossaryItem(
      term: json['term'] as String?,
      definition: json['definition'] as String?,
    );

Map<String, dynamic> _$GlossaryItemToJson(_GlossaryItem instance) =>
    <String, dynamic>{'term': instance.term, 'definition': instance.definition};
