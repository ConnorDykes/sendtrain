import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_form_model.freezed.dart';
part 'training_form_model.g.dart';

@freezed
abstract class TrainingFormModel with _$TrainingFormModel {
  const factory TrainingFormModel({
    required String uid,
    @TimestampConverter() required DateTime createdAt,
    int? age,
    String? gender,
    String? climbingYears,
    String? climbingDaysPerWeek,
    String? boulderOnsight,
    String? boulderRedpoint,
    String? sportOnsight,
    String? sportRedpoint,
    String? goalDescription,
    String? restrictions,
    String? anythingElse,
    int? planDurationWeeks,
    String? injuries,
  }) = _TrainingFormModel;

  factory TrainingFormModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingFormModelFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
