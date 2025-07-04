// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingFormModel _$TrainingFormModelFromJson(Map<String, dynamic> json) {
  return _TrainingFormModel.fromJson(json);
}

/// @nodoc
mixin _$TrainingFormModel {
  String get uid => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get climbingYears => throw _privateConstructorUsedError;
  String? get climbingDaysPerWeek => throw _privateConstructorUsedError;
  String? get boulderOnsight => throw _privateConstructorUsedError;
  String? get boulderRedpoint => throw _privateConstructorUsedError;
  String? get sportOnsight => throw _privateConstructorUsedError;
  String? get sportRedpoint => throw _privateConstructorUsedError;
  String? get goalDescription => throw _privateConstructorUsedError;
  String? get restrictions => throw _privateConstructorUsedError;
  String? get anythingElse => throw _privateConstructorUsedError;
  int? get planDurationWeeks => throw _privateConstructorUsedError;
  String? get injuries => throw _privateConstructorUsedError;

  /// Serializes this TrainingFormModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingFormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingFormModelCopyWith<TrainingFormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingFormModelCopyWith<$Res> {
  factory $TrainingFormModelCopyWith(
    TrainingFormModel value,
    $Res Function(TrainingFormModel) then,
  ) = _$TrainingFormModelCopyWithImpl<$Res, TrainingFormModel>;
  @useResult
  $Res call({
    String uid,
    @TimestampConverter() DateTime createdAt,
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
  });
}

/// @nodoc
class _$TrainingFormModelCopyWithImpl<$Res, $Val extends TrainingFormModel>
    implements $TrainingFormModelCopyWith<$Res> {
  _$TrainingFormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingFormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? climbingYears = freezed,
    Object? climbingDaysPerWeek = freezed,
    Object? boulderOnsight = freezed,
    Object? boulderRedpoint = freezed,
    Object? sportOnsight = freezed,
    Object? sportRedpoint = freezed,
    Object? goalDescription = freezed,
    Object? restrictions = freezed,
    Object? anythingElse = freezed,
    Object? planDurationWeeks = freezed,
    Object? injuries = freezed,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            age: freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            climbingYears: freezed == climbingYears
                ? _value.climbingYears
                : climbingYears // ignore: cast_nullable_to_non_nullable
                      as String?,
            climbingDaysPerWeek: freezed == climbingDaysPerWeek
                ? _value.climbingDaysPerWeek
                : climbingDaysPerWeek // ignore: cast_nullable_to_non_nullable
                      as String?,
            boulderOnsight: freezed == boulderOnsight
                ? _value.boulderOnsight
                : boulderOnsight // ignore: cast_nullable_to_non_nullable
                      as String?,
            boulderRedpoint: freezed == boulderRedpoint
                ? _value.boulderRedpoint
                : boulderRedpoint // ignore: cast_nullable_to_non_nullable
                      as String?,
            sportOnsight: freezed == sportOnsight
                ? _value.sportOnsight
                : sportOnsight // ignore: cast_nullable_to_non_nullable
                      as String?,
            sportRedpoint: freezed == sportRedpoint
                ? _value.sportRedpoint
                : sportRedpoint // ignore: cast_nullable_to_non_nullable
                      as String?,
            goalDescription: freezed == goalDescription
                ? _value.goalDescription
                : goalDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            restrictions: freezed == restrictions
                ? _value.restrictions
                : restrictions // ignore: cast_nullable_to_non_nullable
                      as String?,
            anythingElse: freezed == anythingElse
                ? _value.anythingElse
                : anythingElse // ignore: cast_nullable_to_non_nullable
                      as String?,
            planDurationWeeks: freezed == planDurationWeeks
                ? _value.planDurationWeeks
                : planDurationWeeks // ignore: cast_nullable_to_non_nullable
                      as int?,
            injuries: freezed == injuries
                ? _value.injuries
                : injuries // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingFormModelImplCopyWith<$Res>
    implements $TrainingFormModelCopyWith<$Res> {
  factory _$$TrainingFormModelImplCopyWith(
    _$TrainingFormModelImpl value,
    $Res Function(_$TrainingFormModelImpl) then,
  ) = __$$TrainingFormModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    @TimestampConverter() DateTime createdAt,
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
  });
}

/// @nodoc
class __$$TrainingFormModelImplCopyWithImpl<$Res>
    extends _$TrainingFormModelCopyWithImpl<$Res, _$TrainingFormModelImpl>
    implements _$$TrainingFormModelImplCopyWith<$Res> {
  __$$TrainingFormModelImplCopyWithImpl(
    _$TrainingFormModelImpl _value,
    $Res Function(_$TrainingFormModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingFormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? climbingYears = freezed,
    Object? climbingDaysPerWeek = freezed,
    Object? boulderOnsight = freezed,
    Object? boulderRedpoint = freezed,
    Object? sportOnsight = freezed,
    Object? sportRedpoint = freezed,
    Object? goalDescription = freezed,
    Object? restrictions = freezed,
    Object? anythingElse = freezed,
    Object? planDurationWeeks = freezed,
    Object? injuries = freezed,
  }) {
    return _then(
      _$TrainingFormModelImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        age: freezed == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        climbingYears: freezed == climbingYears
            ? _value.climbingYears
            : climbingYears // ignore: cast_nullable_to_non_nullable
                  as String?,
        climbingDaysPerWeek: freezed == climbingDaysPerWeek
            ? _value.climbingDaysPerWeek
            : climbingDaysPerWeek // ignore: cast_nullable_to_non_nullable
                  as String?,
        boulderOnsight: freezed == boulderOnsight
            ? _value.boulderOnsight
            : boulderOnsight // ignore: cast_nullable_to_non_nullable
                  as String?,
        boulderRedpoint: freezed == boulderRedpoint
            ? _value.boulderRedpoint
            : boulderRedpoint // ignore: cast_nullable_to_non_nullable
                  as String?,
        sportOnsight: freezed == sportOnsight
            ? _value.sportOnsight
            : sportOnsight // ignore: cast_nullable_to_non_nullable
                  as String?,
        sportRedpoint: freezed == sportRedpoint
            ? _value.sportRedpoint
            : sportRedpoint // ignore: cast_nullable_to_non_nullable
                  as String?,
        goalDescription: freezed == goalDescription
            ? _value.goalDescription
            : goalDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        restrictions: freezed == restrictions
            ? _value.restrictions
            : restrictions // ignore: cast_nullable_to_non_nullable
                  as String?,
        anythingElse: freezed == anythingElse
            ? _value.anythingElse
            : anythingElse // ignore: cast_nullable_to_non_nullable
                  as String?,
        planDurationWeeks: freezed == planDurationWeeks
            ? _value.planDurationWeeks
            : planDurationWeeks // ignore: cast_nullable_to_non_nullable
                  as int?,
        injuries: freezed == injuries
            ? _value.injuries
            : injuries // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingFormModelImpl implements _TrainingFormModel {
  const _$TrainingFormModelImpl({
    required this.uid,
    @TimestampConverter() required this.createdAt,
    this.age,
    this.gender,
    this.climbingYears,
    this.climbingDaysPerWeek,
    this.boulderOnsight,
    this.boulderRedpoint,
    this.sportOnsight,
    this.sportRedpoint,
    this.goalDescription,
    this.restrictions,
    this.anythingElse,
    this.planDurationWeeks,
    this.injuries,
  });

  factory _$TrainingFormModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingFormModelImplFromJson(json);

  @override
  final String uid;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final int? age;
  @override
  final String? gender;
  @override
  final String? climbingYears;
  @override
  final String? climbingDaysPerWeek;
  @override
  final String? boulderOnsight;
  @override
  final String? boulderRedpoint;
  @override
  final String? sportOnsight;
  @override
  final String? sportRedpoint;
  @override
  final String? goalDescription;
  @override
  final String? restrictions;
  @override
  final String? anythingElse;
  @override
  final int? planDurationWeeks;
  @override
  final String? injuries;

  @override
  String toString() {
    return 'TrainingFormModel(uid: $uid, createdAt: $createdAt, age: $age, gender: $gender, climbingYears: $climbingYears, climbingDaysPerWeek: $climbingDaysPerWeek, boulderOnsight: $boulderOnsight, boulderRedpoint: $boulderRedpoint, sportOnsight: $sportOnsight, sportRedpoint: $sportRedpoint, goalDescription: $goalDescription, restrictions: $restrictions, anythingElse: $anythingElse, planDurationWeeks: $planDurationWeeks, injuries: $injuries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingFormModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.climbingYears, climbingYears) ||
                other.climbingYears == climbingYears) &&
            (identical(other.climbingDaysPerWeek, climbingDaysPerWeek) ||
                other.climbingDaysPerWeek == climbingDaysPerWeek) &&
            (identical(other.boulderOnsight, boulderOnsight) ||
                other.boulderOnsight == boulderOnsight) &&
            (identical(other.boulderRedpoint, boulderRedpoint) ||
                other.boulderRedpoint == boulderRedpoint) &&
            (identical(other.sportOnsight, sportOnsight) ||
                other.sportOnsight == sportOnsight) &&
            (identical(other.sportRedpoint, sportRedpoint) ||
                other.sportRedpoint == sportRedpoint) &&
            (identical(other.goalDescription, goalDescription) ||
                other.goalDescription == goalDescription) &&
            (identical(other.restrictions, restrictions) ||
                other.restrictions == restrictions) &&
            (identical(other.anythingElse, anythingElse) ||
                other.anythingElse == anythingElse) &&
            (identical(other.planDurationWeeks, planDurationWeeks) ||
                other.planDurationWeeks == planDurationWeeks) &&
            (identical(other.injuries, injuries) ||
                other.injuries == injuries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    createdAt,
    age,
    gender,
    climbingYears,
    climbingDaysPerWeek,
    boulderOnsight,
    boulderRedpoint,
    sportOnsight,
    sportRedpoint,
    goalDescription,
    restrictions,
    anythingElse,
    planDurationWeeks,
    injuries,
  );

  /// Create a copy of TrainingFormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingFormModelImplCopyWith<_$TrainingFormModelImpl> get copyWith =>
      __$$TrainingFormModelImplCopyWithImpl<_$TrainingFormModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingFormModelImplToJson(this);
  }
}

abstract class _TrainingFormModel implements TrainingFormModel {
  const factory _TrainingFormModel({
    required final String uid,
    @TimestampConverter() required final DateTime createdAt,
    final int? age,
    final String? gender,
    final String? climbingYears,
    final String? climbingDaysPerWeek,
    final String? boulderOnsight,
    final String? boulderRedpoint,
    final String? sportOnsight,
    final String? sportRedpoint,
    final String? goalDescription,
    final String? restrictions,
    final String? anythingElse,
    final int? planDurationWeeks,
    final String? injuries,
  }) = _$TrainingFormModelImpl;

  factory _TrainingFormModel.fromJson(Map<String, dynamic> json) =
      _$TrainingFormModelImpl.fromJson;

  @override
  String get uid;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  int? get age;
  @override
  String? get gender;
  @override
  String? get climbingYears;
  @override
  String? get climbingDaysPerWeek;
  @override
  String? get boulderOnsight;
  @override
  String? get boulderRedpoint;
  @override
  String? get sportOnsight;
  @override
  String? get sportRedpoint;
  @override
  String? get goalDescription;
  @override
  String? get restrictions;
  @override
  String? get anythingElse;
  @override
  int? get planDurationWeeks;
  @override
  String? get injuries;

  /// Create a copy of TrainingFormModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingFormModelImplCopyWith<_$TrainingFormModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
