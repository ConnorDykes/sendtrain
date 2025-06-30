// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 UserModel? get user; List<TrainingProgram>? get trainingPrograms; bool get isGeneratingPlan;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.trainingPrograms, trainingPrograms)&&(identical(other.isGeneratingPlan, isGeneratingPlan) || other.isGeneratingPlan == isGeneratingPlan));
}


@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(trainingPrograms),isGeneratingPlan);

@override
String toString() {
  return 'AppState(user: $user, trainingPrograms: $trainingPrograms, isGeneratingPlan: $isGeneratingPlan)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 UserModel? user, List<TrainingProgram>? trainingPrograms, bool isGeneratingPlan
});


$UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? trainingPrograms = freezed,Object? isGeneratingPlan = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,trainingPrograms: freezed == trainingPrograms ? _self.trainingPrograms : trainingPrograms // ignore: cast_nullable_to_non_nullable
as List<TrainingProgram>?,isGeneratingPlan: null == isGeneratingPlan ? _self.isGeneratingPlan : isGeneratingPlan // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc


class _AppState implements AppState {
  const _AppState({this.user, final  List<TrainingProgram>? trainingPrograms, this.isGeneratingPlan = false}): _trainingPrograms = trainingPrograms;
  

@override final  UserModel? user;
 final  List<TrainingProgram>? _trainingPrograms;
@override List<TrainingProgram>? get trainingPrograms {
  final value = _trainingPrograms;
  if (value == null) return null;
  if (_trainingPrograms is EqualUnmodifiableListView) return _trainingPrograms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isGeneratingPlan;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._trainingPrograms, _trainingPrograms)&&(identical(other.isGeneratingPlan, isGeneratingPlan) || other.isGeneratingPlan == isGeneratingPlan));
}


@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_trainingPrograms),isGeneratingPlan);

@override
String toString() {
  return 'AppState(user: $user, trainingPrograms: $trainingPrograms, isGeneratingPlan: $isGeneratingPlan)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 UserModel? user, List<TrainingProgram>? trainingPrograms, bool isGeneratingPlan
});


@override $UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? trainingPrograms = freezed,Object? isGeneratingPlan = null,}) {
  return _then(_AppState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,trainingPrograms: freezed == trainingPrograms ? _self._trainingPrograms : trainingPrograms // ignore: cast_nullable_to_non_nullable
as List<TrainingProgram>?,isGeneratingPlan: null == isGeneratingPlan ? _self.isGeneratingPlan : isGeneratingPlan // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
