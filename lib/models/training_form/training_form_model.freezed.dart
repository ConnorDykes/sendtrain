// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingFormModel {

 String get uid;@TimestampConverter() DateTime get createdAt; int? get age; String? get gender; String? get climbingYears; String? get climbingDaysPerWeek; String? get boulderOnsight; String? get boulderRedpoint; String? get sportOnsight; String? get sportRedpoint; String? get goalDescription; String? get restrictions; String? get anythingElse; int? get planDurationWeeks; String? get injuries;
/// Create a copy of TrainingFormModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingFormModelCopyWith<TrainingFormModel> get copyWith => _$TrainingFormModelCopyWithImpl<TrainingFormModel>(this as TrainingFormModel, _$identity);

  /// Serializes this TrainingFormModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingFormModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.climbingYears, climbingYears) || other.climbingYears == climbingYears)&&(identical(other.climbingDaysPerWeek, climbingDaysPerWeek) || other.climbingDaysPerWeek == climbingDaysPerWeek)&&(identical(other.boulderOnsight, boulderOnsight) || other.boulderOnsight == boulderOnsight)&&(identical(other.boulderRedpoint, boulderRedpoint) || other.boulderRedpoint == boulderRedpoint)&&(identical(other.sportOnsight, sportOnsight) || other.sportOnsight == sportOnsight)&&(identical(other.sportRedpoint, sportRedpoint) || other.sportRedpoint == sportRedpoint)&&(identical(other.goalDescription, goalDescription) || other.goalDescription == goalDescription)&&(identical(other.restrictions, restrictions) || other.restrictions == restrictions)&&(identical(other.anythingElse, anythingElse) || other.anythingElse == anythingElse)&&(identical(other.planDurationWeeks, planDurationWeeks) || other.planDurationWeeks == planDurationWeeks)&&(identical(other.injuries, injuries) || other.injuries == injuries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,createdAt,age,gender,climbingYears,climbingDaysPerWeek,boulderOnsight,boulderRedpoint,sportOnsight,sportRedpoint,goalDescription,restrictions,anythingElse,planDurationWeeks,injuries);

@override
String toString() {
  return 'TrainingFormModel(uid: $uid, createdAt: $createdAt, age: $age, gender: $gender, climbingYears: $climbingYears, climbingDaysPerWeek: $climbingDaysPerWeek, boulderOnsight: $boulderOnsight, boulderRedpoint: $boulderRedpoint, sportOnsight: $sportOnsight, sportRedpoint: $sportRedpoint, goalDescription: $goalDescription, restrictions: $restrictions, anythingElse: $anythingElse, planDurationWeeks: $planDurationWeeks, injuries: $injuries)';
}


}

/// @nodoc
abstract mixin class $TrainingFormModelCopyWith<$Res>  {
  factory $TrainingFormModelCopyWith(TrainingFormModel value, $Res Function(TrainingFormModel) _then) = _$TrainingFormModelCopyWithImpl;
@useResult
$Res call({
 String uid,@TimestampConverter() DateTime createdAt, int? age, String? gender, String? climbingYears, String? climbingDaysPerWeek, String? boulderOnsight, String? boulderRedpoint, String? sportOnsight, String? sportRedpoint, String? goalDescription, String? restrictions, String? anythingElse, int? planDurationWeeks, String? injuries
});




}
/// @nodoc
class _$TrainingFormModelCopyWithImpl<$Res>
    implements $TrainingFormModelCopyWith<$Res> {
  _$TrainingFormModelCopyWithImpl(this._self, this._then);

  final TrainingFormModel _self;
  final $Res Function(TrainingFormModel) _then;

/// Create a copy of TrainingFormModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? createdAt = null,Object? age = freezed,Object? gender = freezed,Object? climbingYears = freezed,Object? climbingDaysPerWeek = freezed,Object? boulderOnsight = freezed,Object? boulderRedpoint = freezed,Object? sportOnsight = freezed,Object? sportRedpoint = freezed,Object? goalDescription = freezed,Object? restrictions = freezed,Object? anythingElse = freezed,Object? planDurationWeeks = freezed,Object? injuries = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,climbingYears: freezed == climbingYears ? _self.climbingYears : climbingYears // ignore: cast_nullable_to_non_nullable
as String?,climbingDaysPerWeek: freezed == climbingDaysPerWeek ? _self.climbingDaysPerWeek : climbingDaysPerWeek // ignore: cast_nullable_to_non_nullable
as String?,boulderOnsight: freezed == boulderOnsight ? _self.boulderOnsight : boulderOnsight // ignore: cast_nullable_to_non_nullable
as String?,boulderRedpoint: freezed == boulderRedpoint ? _self.boulderRedpoint : boulderRedpoint // ignore: cast_nullable_to_non_nullable
as String?,sportOnsight: freezed == sportOnsight ? _self.sportOnsight : sportOnsight // ignore: cast_nullable_to_non_nullable
as String?,sportRedpoint: freezed == sportRedpoint ? _self.sportRedpoint : sportRedpoint // ignore: cast_nullable_to_non_nullable
as String?,goalDescription: freezed == goalDescription ? _self.goalDescription : goalDescription // ignore: cast_nullable_to_non_nullable
as String?,restrictions: freezed == restrictions ? _self.restrictions : restrictions // ignore: cast_nullable_to_non_nullable
as String?,anythingElse: freezed == anythingElse ? _self.anythingElse : anythingElse // ignore: cast_nullable_to_non_nullable
as String?,planDurationWeeks: freezed == planDurationWeeks ? _self.planDurationWeeks : planDurationWeeks // ignore: cast_nullable_to_non_nullable
as int?,injuries: freezed == injuries ? _self.injuries : injuries // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TrainingFormModel implements TrainingFormModel {
  const _TrainingFormModel({required this.uid, @TimestampConverter() required this.createdAt, this.age, this.gender, this.climbingYears, this.climbingDaysPerWeek, this.boulderOnsight, this.boulderRedpoint, this.sportOnsight, this.sportRedpoint, this.goalDescription, this.restrictions, this.anythingElse, this.planDurationWeeks, this.injuries});
  factory _TrainingFormModel.fromJson(Map<String, dynamic> json) => _$TrainingFormModelFromJson(json);

@override final  String uid;
@override@TimestampConverter() final  DateTime createdAt;
@override final  int? age;
@override final  String? gender;
@override final  String? climbingYears;
@override final  String? climbingDaysPerWeek;
@override final  String? boulderOnsight;
@override final  String? boulderRedpoint;
@override final  String? sportOnsight;
@override final  String? sportRedpoint;
@override final  String? goalDescription;
@override final  String? restrictions;
@override final  String? anythingElse;
@override final  int? planDurationWeeks;
@override final  String? injuries;

/// Create a copy of TrainingFormModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingFormModelCopyWith<_TrainingFormModel> get copyWith => __$TrainingFormModelCopyWithImpl<_TrainingFormModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingFormModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingFormModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.climbingYears, climbingYears) || other.climbingYears == climbingYears)&&(identical(other.climbingDaysPerWeek, climbingDaysPerWeek) || other.climbingDaysPerWeek == climbingDaysPerWeek)&&(identical(other.boulderOnsight, boulderOnsight) || other.boulderOnsight == boulderOnsight)&&(identical(other.boulderRedpoint, boulderRedpoint) || other.boulderRedpoint == boulderRedpoint)&&(identical(other.sportOnsight, sportOnsight) || other.sportOnsight == sportOnsight)&&(identical(other.sportRedpoint, sportRedpoint) || other.sportRedpoint == sportRedpoint)&&(identical(other.goalDescription, goalDescription) || other.goalDescription == goalDescription)&&(identical(other.restrictions, restrictions) || other.restrictions == restrictions)&&(identical(other.anythingElse, anythingElse) || other.anythingElse == anythingElse)&&(identical(other.planDurationWeeks, planDurationWeeks) || other.planDurationWeeks == planDurationWeeks)&&(identical(other.injuries, injuries) || other.injuries == injuries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,createdAt,age,gender,climbingYears,climbingDaysPerWeek,boulderOnsight,boulderRedpoint,sportOnsight,sportRedpoint,goalDescription,restrictions,anythingElse,planDurationWeeks,injuries);

@override
String toString() {
  return 'TrainingFormModel(uid: $uid, createdAt: $createdAt, age: $age, gender: $gender, climbingYears: $climbingYears, climbingDaysPerWeek: $climbingDaysPerWeek, boulderOnsight: $boulderOnsight, boulderRedpoint: $boulderRedpoint, sportOnsight: $sportOnsight, sportRedpoint: $sportRedpoint, goalDescription: $goalDescription, restrictions: $restrictions, anythingElse: $anythingElse, planDurationWeeks: $planDurationWeeks, injuries: $injuries)';
}


}

/// @nodoc
abstract mixin class _$TrainingFormModelCopyWith<$Res> implements $TrainingFormModelCopyWith<$Res> {
  factory _$TrainingFormModelCopyWith(_TrainingFormModel value, $Res Function(_TrainingFormModel) _then) = __$TrainingFormModelCopyWithImpl;
@override @useResult
$Res call({
 String uid,@TimestampConverter() DateTime createdAt, int? age, String? gender, String? climbingYears, String? climbingDaysPerWeek, String? boulderOnsight, String? boulderRedpoint, String? sportOnsight, String? sportRedpoint, String? goalDescription, String? restrictions, String? anythingElse, int? planDurationWeeks, String? injuries
});




}
/// @nodoc
class __$TrainingFormModelCopyWithImpl<$Res>
    implements _$TrainingFormModelCopyWith<$Res> {
  __$TrainingFormModelCopyWithImpl(this._self, this._then);

  final _TrainingFormModel _self;
  final $Res Function(_TrainingFormModel) _then;

/// Create a copy of TrainingFormModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? createdAt = null,Object? age = freezed,Object? gender = freezed,Object? climbingYears = freezed,Object? climbingDaysPerWeek = freezed,Object? boulderOnsight = freezed,Object? boulderRedpoint = freezed,Object? sportOnsight = freezed,Object? sportRedpoint = freezed,Object? goalDescription = freezed,Object? restrictions = freezed,Object? anythingElse = freezed,Object? planDurationWeeks = freezed,Object? injuries = freezed,}) {
  return _then(_TrainingFormModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,climbingYears: freezed == climbingYears ? _self.climbingYears : climbingYears // ignore: cast_nullable_to_non_nullable
as String?,climbingDaysPerWeek: freezed == climbingDaysPerWeek ? _self.climbingDaysPerWeek : climbingDaysPerWeek // ignore: cast_nullable_to_non_nullable
as String?,boulderOnsight: freezed == boulderOnsight ? _self.boulderOnsight : boulderOnsight // ignore: cast_nullable_to_non_nullable
as String?,boulderRedpoint: freezed == boulderRedpoint ? _self.boulderRedpoint : boulderRedpoint // ignore: cast_nullable_to_non_nullable
as String?,sportOnsight: freezed == sportOnsight ? _self.sportOnsight : sportOnsight // ignore: cast_nullable_to_non_nullable
as String?,sportRedpoint: freezed == sportRedpoint ? _self.sportRedpoint : sportRedpoint // ignore: cast_nullable_to_non_nullable
as String?,goalDescription: freezed == goalDescription ? _self.goalDescription : goalDescription // ignore: cast_nullable_to_non_nullable
as String?,restrictions: freezed == restrictions ? _self.restrictions : restrictions // ignore: cast_nullable_to_non_nullable
as String?,anythingElse: freezed == anythingElse ? _self.anythingElse : anythingElse // ignore: cast_nullable_to_non_nullable
as String?,planDurationWeeks: freezed == planDurationWeeks ? _self.planDurationWeeks : planDurationWeeks // ignore: cast_nullable_to_non_nullable
as int?,injuries: freezed == injuries ? _self.injuries : injuries // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
