// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingProgramImpl _$$TrainingProgramImplFromJson(
  Map<String, dynamic> json,
) => _$TrainingProgramImpl(
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
  generatedAt: const TimestampConverter().fromJson(json['generatedAt']),
);

Map<String, dynamic> _$$TrainingProgramImplToJson(
  _$TrainingProgramImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'programTitle': instance.programTitle,
  'programFocus': instance.programFocus,
  'durationWeeks': instance.durationWeeks,
  'programDescripton': instance.programDescripton,
  'programNotes': instance.programNotes,
  'weeklySchedule': instance.weeklySchedule,
  'glossary': instance.glossary,
  'startedAt': const TimestampConverter().toJson(instance.startedAt),
  'generatedAt': const TimestampConverter().toJson(instance.generatedAt),
};

_$ProgramNotesImpl _$$ProgramNotesImplFromJson(Map<String, dynamic> json) =>
    _$ProgramNotesImpl(
      safetyDisclaimer: json['safetyDisclaimer'] as String?,
      injuryModifications: json['injuryModifications'] as String?,
      assumptionsMade: json['assumptionsMade'] as String?,
    );

Map<String, dynamic> _$$ProgramNotesImplToJson(_$ProgramNotesImpl instance) =>
    <String, dynamic>{
      'safetyDisclaimer': instance.safetyDisclaimer,
      'injuryModifications': instance.injuryModifications,
      'assumptionsMade': instance.assumptionsMade,
    };

_$WeeklySessionImpl _$$WeeklySessionImplFromJson(Map<String, dynamic> json) =>
    _$WeeklySessionImpl(
      week: (json['week'] as num?)?.toInt(),
      phase: json['phase'] as String?,
      weeklyFocus: json['weeklyFocus'] as String?,
      dailySessions: (json['dailySessions'] as List<dynamic>?)
          ?.map((e) => DailySession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WeeklySessionImplToJson(_$WeeklySessionImpl instance) =>
    <String, dynamic>{
      'week': instance.week,
      'phase': instance.phase,
      'weeklyFocus': instance.weeklyFocus,
      'dailySessions': instance.dailySessions,
    };

_$DailySessionImpl _$$DailySessionImplFromJson(Map<String, dynamic> json) =>
    _$DailySessionImpl(
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
    );

Map<String, dynamic> _$$DailySessionImplToJson(_$DailySessionImpl instance) =>
    <String, dynamic>{
      'sessionNumber': instance.sessionNumber,
      'dayOfTheWeek': instance.dayOfTheWeek,
      'sessionType': instance.sessionType,
      'sessionFocus': instance.sessionFocus,
      'warmUp': instance.warmUp,
      'mainSession': instance.mainSession,
      'coolDown': instance.coolDown,
    };

_$SessionPhaseImpl _$$SessionPhaseImplFromJson(Map<String, dynamic> json) =>
    _$SessionPhaseImpl(
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SessionPhaseImplToJson(_$SessionPhaseImpl instance) =>
    <String, dynamic>{
      'durationMinutes': instance.durationMinutes,
      'exercises': instance.exercises?.map((e) => e.toJson()).toList(),
      'activities': instance.activities?.map((e) => e.toJson()).toList(),
    };

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
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

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
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

_$GlossaryItemImpl _$$GlossaryItemImplFromJson(Map<String, dynamic> json) =>
    _$GlossaryItemImpl(
      term: json['term'] as String?,
      definition: json['definition'] as String?,
    );

Map<String, dynamic> _$$GlossaryItemImplToJson(_$GlossaryItemImpl instance) =>
    <String, dynamic>{'term': instance.term, 'definition': instance.definition};
