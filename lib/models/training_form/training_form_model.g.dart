// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingFormModel _$TrainingFormModelFromJson(Map<String, dynamic> json) =>
    _TrainingFormModel(
      uid: json['uid'] as String,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      climbingYears: json['climbingYears'] as String?,
      climbingDaysPerWeek: json['climbingDaysPerWeek'] as String?,
      boulderOnsight: json['boulderOnsight'] as String?,
      boulderRedpoint: json['boulderRedpoint'] as String?,
      sportOnsight: json['sportOnsight'] as String?,
      sportRedpoint: json['sportRedpoint'] as String?,
      goalDescription: json['goalDescription'] as String?,
      restrictions: json['restrictions'] as String?,
      anythingElse: json['anythingElse'] as String?,
      planDurationWeeks: (json['planDurationWeeks'] as num?)?.toInt(),
      injuries: json['injuries'] as String?,
    );

Map<String, dynamic> _$TrainingFormModelToJson(_TrainingFormModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'age': instance.age,
      'gender': instance.gender,
      'climbingYears': instance.climbingYears,
      'climbingDaysPerWeek': instance.climbingDaysPerWeek,
      'boulderOnsight': instance.boulderOnsight,
      'boulderRedpoint': instance.boulderRedpoint,
      'sportOnsight': instance.sportOnsight,
      'sportRedpoint': instance.sportRedpoint,
      'goalDescription': instance.goalDescription,
      'restrictions': instance.restrictions,
      'anythingElse': instance.anythingElse,
      'planDurationWeeks': instance.planDurationWeeks,
      'injuries': instance.injuries,
    };
