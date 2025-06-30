// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingProgram {

 String? get id; String? get programTitle; String? get programFocus; int? get durationWeeks; String? get programDescripton; ProgramNotes? get programNotes; List<WeeklySession>? get weeklySchedule; List<GlossaryItem>? get glossary; DateTime? get startedAt;
/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingProgramCopyWith<TrainingProgram> get copyWith => _$TrainingProgramCopyWithImpl<TrainingProgram>(this as TrainingProgram, _$identity);

  /// Serializes this TrainingProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.programTitle, programTitle) || other.programTitle == programTitle)&&(identical(other.programFocus, programFocus) || other.programFocus == programFocus)&&(identical(other.durationWeeks, durationWeeks) || other.durationWeeks == durationWeeks)&&(identical(other.programDescripton, programDescripton) || other.programDescripton == programDescripton)&&(identical(other.programNotes, programNotes) || other.programNotes == programNotes)&&const DeepCollectionEquality().equals(other.weeklySchedule, weeklySchedule)&&const DeepCollectionEquality().equals(other.glossary, glossary)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,programTitle,programFocus,durationWeeks,programDescripton,programNotes,const DeepCollectionEquality().hash(weeklySchedule),const DeepCollectionEquality().hash(glossary),startedAt);

@override
String toString() {
  return 'TrainingProgram(id: $id, programTitle: $programTitle, programFocus: $programFocus, durationWeeks: $durationWeeks, programDescripton: $programDescripton, programNotes: $programNotes, weeklySchedule: $weeklySchedule, glossary: $glossary, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $TrainingProgramCopyWith<$Res>  {
  factory $TrainingProgramCopyWith(TrainingProgram value, $Res Function(TrainingProgram) _then) = _$TrainingProgramCopyWithImpl;
@useResult
$Res call({
 String? id, String? programTitle, String? programFocus, int? durationWeeks, String? programDescripton, ProgramNotes? programNotes, List<WeeklySession>? weeklySchedule, List<GlossaryItem>? glossary, DateTime? startedAt
});


$ProgramNotesCopyWith<$Res>? get programNotes;

}
/// @nodoc
class _$TrainingProgramCopyWithImpl<$Res>
    implements $TrainingProgramCopyWith<$Res> {
  _$TrainingProgramCopyWithImpl(this._self, this._then);

  final TrainingProgram _self;
  final $Res Function(TrainingProgram) _then;

/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? programTitle = freezed,Object? programFocus = freezed,Object? durationWeeks = freezed,Object? programDescripton = freezed,Object? programNotes = freezed,Object? weeklySchedule = freezed,Object? glossary = freezed,Object? startedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,programTitle: freezed == programTitle ? _self.programTitle : programTitle // ignore: cast_nullable_to_non_nullable
as String?,programFocus: freezed == programFocus ? _self.programFocus : programFocus // ignore: cast_nullable_to_non_nullable
as String?,durationWeeks: freezed == durationWeeks ? _self.durationWeeks : durationWeeks // ignore: cast_nullable_to_non_nullable
as int?,programDescripton: freezed == programDescripton ? _self.programDescripton : programDescripton // ignore: cast_nullable_to_non_nullable
as String?,programNotes: freezed == programNotes ? _self.programNotes : programNotes // ignore: cast_nullable_to_non_nullable
as ProgramNotes?,weeklySchedule: freezed == weeklySchedule ? _self.weeklySchedule : weeklySchedule // ignore: cast_nullable_to_non_nullable
as List<WeeklySession>?,glossary: freezed == glossary ? _self.glossary : glossary // ignore: cast_nullable_to_non_nullable
as List<GlossaryItem>?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgramNotesCopyWith<$Res>? get programNotes {
    if (_self.programNotes == null) {
    return null;
  }

  return $ProgramNotesCopyWith<$Res>(_self.programNotes!, (value) {
    return _then(_self.copyWith(programNotes: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _TrainingProgram extends TrainingProgram {
  const _TrainingProgram({this.id, this.programTitle, this.programFocus, this.durationWeeks, this.programDescripton, this.programNotes, final  List<WeeklySession>? weeklySchedule, final  List<GlossaryItem>? glossary, this.startedAt}): _weeklySchedule = weeklySchedule,_glossary = glossary,super._();
  factory _TrainingProgram.fromJson(Map<String, dynamic> json) => _$TrainingProgramFromJson(json);

@override final  String? id;
@override final  String? programTitle;
@override final  String? programFocus;
@override final  int? durationWeeks;
@override final  String? programDescripton;
@override final  ProgramNotes? programNotes;
 final  List<WeeklySession>? _weeklySchedule;
@override List<WeeklySession>? get weeklySchedule {
  final value = _weeklySchedule;
  if (value == null) return null;
  if (_weeklySchedule is EqualUnmodifiableListView) return _weeklySchedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<GlossaryItem>? _glossary;
@override List<GlossaryItem>? get glossary {
  final value = _glossary;
  if (value == null) return null;
  if (_glossary is EqualUnmodifiableListView) return _glossary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? startedAt;

/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingProgramCopyWith<_TrainingProgram> get copyWith => __$TrainingProgramCopyWithImpl<_TrainingProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.programTitle, programTitle) || other.programTitle == programTitle)&&(identical(other.programFocus, programFocus) || other.programFocus == programFocus)&&(identical(other.durationWeeks, durationWeeks) || other.durationWeeks == durationWeeks)&&(identical(other.programDescripton, programDescripton) || other.programDescripton == programDescripton)&&(identical(other.programNotes, programNotes) || other.programNotes == programNotes)&&const DeepCollectionEquality().equals(other._weeklySchedule, _weeklySchedule)&&const DeepCollectionEquality().equals(other._glossary, _glossary)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,programTitle,programFocus,durationWeeks,programDescripton,programNotes,const DeepCollectionEquality().hash(_weeklySchedule),const DeepCollectionEquality().hash(_glossary),startedAt);

@override
String toString() {
  return 'TrainingProgram(id: $id, programTitle: $programTitle, programFocus: $programFocus, durationWeeks: $durationWeeks, programDescripton: $programDescripton, programNotes: $programNotes, weeklySchedule: $weeklySchedule, glossary: $glossary, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingProgramCopyWith<$Res> implements $TrainingProgramCopyWith<$Res> {
  factory _$TrainingProgramCopyWith(_TrainingProgram value, $Res Function(_TrainingProgram) _then) = __$TrainingProgramCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? programTitle, String? programFocus, int? durationWeeks, String? programDescripton, ProgramNotes? programNotes, List<WeeklySession>? weeklySchedule, List<GlossaryItem>? glossary, DateTime? startedAt
});


@override $ProgramNotesCopyWith<$Res>? get programNotes;

}
/// @nodoc
class __$TrainingProgramCopyWithImpl<$Res>
    implements _$TrainingProgramCopyWith<$Res> {
  __$TrainingProgramCopyWithImpl(this._self, this._then);

  final _TrainingProgram _self;
  final $Res Function(_TrainingProgram) _then;

/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? programTitle = freezed,Object? programFocus = freezed,Object? durationWeeks = freezed,Object? programDescripton = freezed,Object? programNotes = freezed,Object? weeklySchedule = freezed,Object? glossary = freezed,Object? startedAt = freezed,}) {
  return _then(_TrainingProgram(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,programTitle: freezed == programTitle ? _self.programTitle : programTitle // ignore: cast_nullable_to_non_nullable
as String?,programFocus: freezed == programFocus ? _self.programFocus : programFocus // ignore: cast_nullable_to_non_nullable
as String?,durationWeeks: freezed == durationWeeks ? _self.durationWeeks : durationWeeks // ignore: cast_nullable_to_non_nullable
as int?,programDescripton: freezed == programDescripton ? _self.programDescripton : programDescripton // ignore: cast_nullable_to_non_nullable
as String?,programNotes: freezed == programNotes ? _self.programNotes : programNotes // ignore: cast_nullable_to_non_nullable
as ProgramNotes?,weeklySchedule: freezed == weeklySchedule ? _self._weeklySchedule : weeklySchedule // ignore: cast_nullable_to_non_nullable
as List<WeeklySession>?,glossary: freezed == glossary ? _self._glossary : glossary // ignore: cast_nullable_to_non_nullable
as List<GlossaryItem>?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TrainingProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgramNotesCopyWith<$Res>? get programNotes {
    if (_self.programNotes == null) {
    return null;
  }

  return $ProgramNotesCopyWith<$Res>(_self.programNotes!, (value) {
    return _then(_self.copyWith(programNotes: value));
  });
}
}


/// @nodoc
mixin _$ProgramNotes {

 String? get safetyDisclaimer; String? get injuryModifications; String? get assumptionsMade;
/// Create a copy of ProgramNotes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramNotesCopyWith<ProgramNotes> get copyWith => _$ProgramNotesCopyWithImpl<ProgramNotes>(this as ProgramNotes, _$identity);

  /// Serializes this ProgramNotes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgramNotes&&(identical(other.safetyDisclaimer, safetyDisclaimer) || other.safetyDisclaimer == safetyDisclaimer)&&(identical(other.injuryModifications, injuryModifications) || other.injuryModifications == injuryModifications)&&(identical(other.assumptionsMade, assumptionsMade) || other.assumptionsMade == assumptionsMade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,safetyDisclaimer,injuryModifications,assumptionsMade);

@override
String toString() {
  return 'ProgramNotes(safetyDisclaimer: $safetyDisclaimer, injuryModifications: $injuryModifications, assumptionsMade: $assumptionsMade)';
}


}

/// @nodoc
abstract mixin class $ProgramNotesCopyWith<$Res>  {
  factory $ProgramNotesCopyWith(ProgramNotes value, $Res Function(ProgramNotes) _then) = _$ProgramNotesCopyWithImpl;
@useResult
$Res call({
 String? safetyDisclaimer, String? injuryModifications, String? assumptionsMade
});




}
/// @nodoc
class _$ProgramNotesCopyWithImpl<$Res>
    implements $ProgramNotesCopyWith<$Res> {
  _$ProgramNotesCopyWithImpl(this._self, this._then);

  final ProgramNotes _self;
  final $Res Function(ProgramNotes) _then;

/// Create a copy of ProgramNotes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? safetyDisclaimer = freezed,Object? injuryModifications = freezed,Object? assumptionsMade = freezed,}) {
  return _then(_self.copyWith(
safetyDisclaimer: freezed == safetyDisclaimer ? _self.safetyDisclaimer : safetyDisclaimer // ignore: cast_nullable_to_non_nullable
as String?,injuryModifications: freezed == injuryModifications ? _self.injuryModifications : injuryModifications // ignore: cast_nullable_to_non_nullable
as String?,assumptionsMade: freezed == assumptionsMade ? _self.assumptionsMade : assumptionsMade // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProgramNotes implements ProgramNotes {
  const _ProgramNotes({this.safetyDisclaimer, this.injuryModifications, this.assumptionsMade});
  factory _ProgramNotes.fromJson(Map<String, dynamic> json) => _$ProgramNotesFromJson(json);

@override final  String? safetyDisclaimer;
@override final  String? injuryModifications;
@override final  String? assumptionsMade;

/// Create a copy of ProgramNotes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramNotesCopyWith<_ProgramNotes> get copyWith => __$ProgramNotesCopyWithImpl<_ProgramNotes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramNotesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgramNotes&&(identical(other.safetyDisclaimer, safetyDisclaimer) || other.safetyDisclaimer == safetyDisclaimer)&&(identical(other.injuryModifications, injuryModifications) || other.injuryModifications == injuryModifications)&&(identical(other.assumptionsMade, assumptionsMade) || other.assumptionsMade == assumptionsMade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,safetyDisclaimer,injuryModifications,assumptionsMade);

@override
String toString() {
  return 'ProgramNotes(safetyDisclaimer: $safetyDisclaimer, injuryModifications: $injuryModifications, assumptionsMade: $assumptionsMade)';
}


}

/// @nodoc
abstract mixin class _$ProgramNotesCopyWith<$Res> implements $ProgramNotesCopyWith<$Res> {
  factory _$ProgramNotesCopyWith(_ProgramNotes value, $Res Function(_ProgramNotes) _then) = __$ProgramNotesCopyWithImpl;
@override @useResult
$Res call({
 String? safetyDisclaimer, String? injuryModifications, String? assumptionsMade
});




}
/// @nodoc
class __$ProgramNotesCopyWithImpl<$Res>
    implements _$ProgramNotesCopyWith<$Res> {
  __$ProgramNotesCopyWithImpl(this._self, this._then);

  final _ProgramNotes _self;
  final $Res Function(_ProgramNotes) _then;

/// Create a copy of ProgramNotes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? safetyDisclaimer = freezed,Object? injuryModifications = freezed,Object? assumptionsMade = freezed,}) {
  return _then(_ProgramNotes(
safetyDisclaimer: freezed == safetyDisclaimer ? _self.safetyDisclaimer : safetyDisclaimer // ignore: cast_nullable_to_non_nullable
as String?,injuryModifications: freezed == injuryModifications ? _self.injuryModifications : injuryModifications // ignore: cast_nullable_to_non_nullable
as String?,assumptionsMade: freezed == assumptionsMade ? _self.assumptionsMade : assumptionsMade // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WeeklySession {

 int? get week; String? get phase; String? get weeklyFocus; List<DailySession>? get dailySessions;
/// Create a copy of WeeklySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklySessionCopyWith<WeeklySession> get copyWith => _$WeeklySessionCopyWithImpl<WeeklySession>(this as WeeklySession, _$identity);

  /// Serializes this WeeklySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklySession&&(identical(other.week, week) || other.week == week)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.weeklyFocus, weeklyFocus) || other.weeklyFocus == weeklyFocus)&&const DeepCollectionEquality().equals(other.dailySessions, dailySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,phase,weeklyFocus,const DeepCollectionEquality().hash(dailySessions));

@override
String toString() {
  return 'WeeklySession(week: $week, phase: $phase, weeklyFocus: $weeklyFocus, dailySessions: $dailySessions)';
}


}

/// @nodoc
abstract mixin class $WeeklySessionCopyWith<$Res>  {
  factory $WeeklySessionCopyWith(WeeklySession value, $Res Function(WeeklySession) _then) = _$WeeklySessionCopyWithImpl;
@useResult
$Res call({
 int? week, String? phase, String? weeklyFocus, List<DailySession>? dailySessions
});




}
/// @nodoc
class _$WeeklySessionCopyWithImpl<$Res>
    implements $WeeklySessionCopyWith<$Res> {
  _$WeeklySessionCopyWithImpl(this._self, this._then);

  final WeeklySession _self;
  final $Res Function(WeeklySession) _then;

/// Create a copy of WeeklySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = freezed,Object? phase = freezed,Object? weeklyFocus = freezed,Object? dailySessions = freezed,}) {
  return _then(_self.copyWith(
week: freezed == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int?,phase: freezed == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String?,weeklyFocus: freezed == weeklyFocus ? _self.weeklyFocus : weeklyFocus // ignore: cast_nullable_to_non_nullable
as String?,dailySessions: freezed == dailySessions ? _self.dailySessions : dailySessions // ignore: cast_nullable_to_non_nullable
as List<DailySession>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeeklySession implements WeeklySession {
  const _WeeklySession({this.week, this.phase, this.weeklyFocus, final  List<DailySession>? dailySessions}): _dailySessions = dailySessions;
  factory _WeeklySession.fromJson(Map<String, dynamic> json) => _$WeeklySessionFromJson(json);

@override final  int? week;
@override final  String? phase;
@override final  String? weeklyFocus;
 final  List<DailySession>? _dailySessions;
@override List<DailySession>? get dailySessions {
  final value = _dailySessions;
  if (value == null) return null;
  if (_dailySessions is EqualUnmodifiableListView) return _dailySessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of WeeklySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklySessionCopyWith<_WeeklySession> get copyWith => __$WeeklySessionCopyWithImpl<_WeeklySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklySessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklySession&&(identical(other.week, week) || other.week == week)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.weeklyFocus, weeklyFocus) || other.weeklyFocus == weeklyFocus)&&const DeepCollectionEquality().equals(other._dailySessions, _dailySessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,phase,weeklyFocus,const DeepCollectionEquality().hash(_dailySessions));

@override
String toString() {
  return 'WeeklySession(week: $week, phase: $phase, weeklyFocus: $weeklyFocus, dailySessions: $dailySessions)';
}


}

/// @nodoc
abstract mixin class _$WeeklySessionCopyWith<$Res> implements $WeeklySessionCopyWith<$Res> {
  factory _$WeeklySessionCopyWith(_WeeklySession value, $Res Function(_WeeklySession) _then) = __$WeeklySessionCopyWithImpl;
@override @useResult
$Res call({
 int? week, String? phase, String? weeklyFocus, List<DailySession>? dailySessions
});




}
/// @nodoc
class __$WeeklySessionCopyWithImpl<$Res>
    implements _$WeeklySessionCopyWith<$Res> {
  __$WeeklySessionCopyWithImpl(this._self, this._then);

  final _WeeklySession _self;
  final $Res Function(_WeeklySession) _then;

/// Create a copy of WeeklySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? week = freezed,Object? phase = freezed,Object? weeklyFocus = freezed,Object? dailySessions = freezed,}) {
  return _then(_WeeklySession(
week: freezed == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int?,phase: freezed == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String?,weeklyFocus: freezed == weeklyFocus ? _self.weeklyFocus : weeklyFocus // ignore: cast_nullable_to_non_nullable
as String?,dailySessions: freezed == dailySessions ? _self._dailySessions : dailySessions // ignore: cast_nullable_to_non_nullable
as List<DailySession>?,
  ));
}


}


/// @nodoc
mixin _$DailySession {

 int? get sessionNumber; String? get dayOfTheWeek; String? get sessionType; String? get sessionFocus; SessionPhase? get warmUp; SessionPhase? get mainSession; SessionPhase? get coolDown;
/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailySessionCopyWith<DailySession> get copyWith => _$DailySessionCopyWithImpl<DailySession>(this as DailySession, _$identity);

  /// Serializes this DailySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySession&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.dayOfTheWeek, dayOfTheWeek) || other.dayOfTheWeek == dayOfTheWeek)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.sessionFocus, sessionFocus) || other.sessionFocus == sessionFocus)&&(identical(other.warmUp, warmUp) || other.warmUp == warmUp)&&(identical(other.mainSession, mainSession) || other.mainSession == mainSession)&&(identical(other.coolDown, coolDown) || other.coolDown == coolDown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionNumber,dayOfTheWeek,sessionType,sessionFocus,warmUp,mainSession,coolDown);

@override
String toString() {
  return 'DailySession(sessionNumber: $sessionNumber, dayOfTheWeek: $dayOfTheWeek, sessionType: $sessionType, sessionFocus: $sessionFocus, warmUp: $warmUp, mainSession: $mainSession, coolDown: $coolDown)';
}


}

/// @nodoc
abstract mixin class $DailySessionCopyWith<$Res>  {
  factory $DailySessionCopyWith(DailySession value, $Res Function(DailySession) _then) = _$DailySessionCopyWithImpl;
@useResult
$Res call({
 int? sessionNumber, String? dayOfTheWeek, String? sessionType, String? sessionFocus, SessionPhase? warmUp, SessionPhase? mainSession, SessionPhase? coolDown
});


$SessionPhaseCopyWith<$Res>? get warmUp;$SessionPhaseCopyWith<$Res>? get mainSession;$SessionPhaseCopyWith<$Res>? get coolDown;

}
/// @nodoc
class _$DailySessionCopyWithImpl<$Res>
    implements $DailySessionCopyWith<$Res> {
  _$DailySessionCopyWithImpl(this._self, this._then);

  final DailySession _self;
  final $Res Function(DailySession) _then;

/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionNumber = freezed,Object? dayOfTheWeek = freezed,Object? sessionType = freezed,Object? sessionFocus = freezed,Object? warmUp = freezed,Object? mainSession = freezed,Object? coolDown = freezed,}) {
  return _then(_self.copyWith(
sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,dayOfTheWeek: freezed == dayOfTheWeek ? _self.dayOfTheWeek : dayOfTheWeek // ignore: cast_nullable_to_non_nullable
as String?,sessionType: freezed == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String?,sessionFocus: freezed == sessionFocus ? _self.sessionFocus : sessionFocus // ignore: cast_nullable_to_non_nullable
as String?,warmUp: freezed == warmUp ? _self.warmUp : warmUp // ignore: cast_nullable_to_non_nullable
as SessionPhase?,mainSession: freezed == mainSession ? _self.mainSession : mainSession // ignore: cast_nullable_to_non_nullable
as SessionPhase?,coolDown: freezed == coolDown ? _self.coolDown : coolDown // ignore: cast_nullable_to_non_nullable
as SessionPhase?,
  ));
}
/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get warmUp {
    if (_self.warmUp == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.warmUp!, (value) {
    return _then(_self.copyWith(warmUp: value));
  });
}/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get mainSession {
    if (_self.mainSession == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.mainSession!, (value) {
    return _then(_self.copyWith(mainSession: value));
  });
}/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get coolDown {
    if (_self.coolDown == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.coolDown!, (value) {
    return _then(_self.copyWith(coolDown: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DailySession implements DailySession {
  const _DailySession({this.sessionNumber, this.dayOfTheWeek, this.sessionType, this.sessionFocus, this.warmUp, this.mainSession, this.coolDown});
  factory _DailySession.fromJson(Map<String, dynamic> json) => _$DailySessionFromJson(json);

@override final  int? sessionNumber;
@override final  String? dayOfTheWeek;
@override final  String? sessionType;
@override final  String? sessionFocus;
@override final  SessionPhase? warmUp;
@override final  SessionPhase? mainSession;
@override final  SessionPhase? coolDown;

/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailySessionCopyWith<_DailySession> get copyWith => __$DailySessionCopyWithImpl<_DailySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailySessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySession&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.dayOfTheWeek, dayOfTheWeek) || other.dayOfTheWeek == dayOfTheWeek)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.sessionFocus, sessionFocus) || other.sessionFocus == sessionFocus)&&(identical(other.warmUp, warmUp) || other.warmUp == warmUp)&&(identical(other.mainSession, mainSession) || other.mainSession == mainSession)&&(identical(other.coolDown, coolDown) || other.coolDown == coolDown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionNumber,dayOfTheWeek,sessionType,sessionFocus,warmUp,mainSession,coolDown);

@override
String toString() {
  return 'DailySession(sessionNumber: $sessionNumber, dayOfTheWeek: $dayOfTheWeek, sessionType: $sessionType, sessionFocus: $sessionFocus, warmUp: $warmUp, mainSession: $mainSession, coolDown: $coolDown)';
}


}

/// @nodoc
abstract mixin class _$DailySessionCopyWith<$Res> implements $DailySessionCopyWith<$Res> {
  factory _$DailySessionCopyWith(_DailySession value, $Res Function(_DailySession) _then) = __$DailySessionCopyWithImpl;
@override @useResult
$Res call({
 int? sessionNumber, String? dayOfTheWeek, String? sessionType, String? sessionFocus, SessionPhase? warmUp, SessionPhase? mainSession, SessionPhase? coolDown
});


@override $SessionPhaseCopyWith<$Res>? get warmUp;@override $SessionPhaseCopyWith<$Res>? get mainSession;@override $SessionPhaseCopyWith<$Res>? get coolDown;

}
/// @nodoc
class __$DailySessionCopyWithImpl<$Res>
    implements _$DailySessionCopyWith<$Res> {
  __$DailySessionCopyWithImpl(this._self, this._then);

  final _DailySession _self;
  final $Res Function(_DailySession) _then;

/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionNumber = freezed,Object? dayOfTheWeek = freezed,Object? sessionType = freezed,Object? sessionFocus = freezed,Object? warmUp = freezed,Object? mainSession = freezed,Object? coolDown = freezed,}) {
  return _then(_DailySession(
sessionNumber: freezed == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int?,dayOfTheWeek: freezed == dayOfTheWeek ? _self.dayOfTheWeek : dayOfTheWeek // ignore: cast_nullable_to_non_nullable
as String?,sessionType: freezed == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String?,sessionFocus: freezed == sessionFocus ? _self.sessionFocus : sessionFocus // ignore: cast_nullable_to_non_nullable
as String?,warmUp: freezed == warmUp ? _self.warmUp : warmUp // ignore: cast_nullable_to_non_nullable
as SessionPhase?,mainSession: freezed == mainSession ? _self.mainSession : mainSession // ignore: cast_nullable_to_non_nullable
as SessionPhase?,coolDown: freezed == coolDown ? _self.coolDown : coolDown // ignore: cast_nullable_to_non_nullable
as SessionPhase?,
  ));
}

/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get warmUp {
    if (_self.warmUp == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.warmUp!, (value) {
    return _then(_self.copyWith(warmUp: value));
  });
}/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get mainSession {
    if (_self.mainSession == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.mainSession!, (value) {
    return _then(_self.copyWith(mainSession: value));
  });
}/// Create a copy of DailySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<$Res>? get coolDown {
    if (_self.coolDown == null) {
    return null;
  }

  return $SessionPhaseCopyWith<$Res>(_self.coolDown!, (value) {
    return _then(_self.copyWith(coolDown: value));
  });
}
}


/// @nodoc
mixin _$SessionPhase {

 int? get durationMinutes; List<Exercise>? get exercises; List<Exercise>? get activities;
/// Create a copy of SessionPhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionPhaseCopyWith<SessionPhase> get copyWith => _$SessionPhaseCopyWithImpl<SessionPhase>(this as SessionPhase, _$identity);

  /// Serializes this SessionPhase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionPhase&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&const DeepCollectionEquality().equals(other.activities, activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,durationMinutes,const DeepCollectionEquality().hash(exercises),const DeepCollectionEquality().hash(activities));

@override
String toString() {
  return 'SessionPhase(durationMinutes: $durationMinutes, exercises: $exercises, activities: $activities)';
}


}

/// @nodoc
abstract mixin class $SessionPhaseCopyWith<$Res>  {
  factory $SessionPhaseCopyWith(SessionPhase value, $Res Function(SessionPhase) _then) = _$SessionPhaseCopyWithImpl;
@useResult
$Res call({
 int? durationMinutes, List<Exercise>? exercises, List<Exercise>? activities
});




}
/// @nodoc
class _$SessionPhaseCopyWithImpl<$Res>
    implements $SessionPhaseCopyWith<$Res> {
  _$SessionPhaseCopyWithImpl(this._self, this._then);

  final SessionPhase _self;
  final $Res Function(SessionPhase) _then;

/// Create a copy of SessionPhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMinutes = freezed,Object? exercises = freezed,Object? activities = freezed,}) {
  return _then(_self.copyWith(
durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,exercises: freezed == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>?,activities: freezed == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<Exercise>?,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SessionPhase implements SessionPhase {
  const _SessionPhase({this.durationMinutes, final  List<Exercise>? exercises, final  List<Exercise>? activities}): _exercises = exercises,_activities = activities;
  factory _SessionPhase.fromJson(Map<String, dynamic> json) => _$SessionPhaseFromJson(json);

@override final  int? durationMinutes;
 final  List<Exercise>? _exercises;
@override List<Exercise>? get exercises {
  final value = _exercises;
  if (value == null) return null;
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Exercise>? _activities;
@override List<Exercise>? get activities {
  final value = _activities;
  if (value == null) return null;
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SessionPhase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionPhaseCopyWith<_SessionPhase> get copyWith => __$SessionPhaseCopyWithImpl<_SessionPhase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionPhaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionPhase&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&const DeepCollectionEquality().equals(other._activities, _activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,durationMinutes,const DeepCollectionEquality().hash(_exercises),const DeepCollectionEquality().hash(_activities));

@override
String toString() {
  return 'SessionPhase(durationMinutes: $durationMinutes, exercises: $exercises, activities: $activities)';
}


}

/// @nodoc
abstract mixin class _$SessionPhaseCopyWith<$Res> implements $SessionPhaseCopyWith<$Res> {
  factory _$SessionPhaseCopyWith(_SessionPhase value, $Res Function(_SessionPhase) _then) = __$SessionPhaseCopyWithImpl;
@override @useResult
$Res call({
 int? durationMinutes, List<Exercise>? exercises, List<Exercise>? activities
});




}
/// @nodoc
class __$SessionPhaseCopyWithImpl<$Res>
    implements _$SessionPhaseCopyWith<$Res> {
  __$SessionPhaseCopyWithImpl(this._self, this._then);

  final _SessionPhase _self;
  final $Res Function(_SessionPhase) _then;

/// Create a copy of SessionPhase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? durationMinutes = freezed,Object? exercises = freezed,Object? activities = freezed,}) {
  return _then(_SessionPhase(
durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,exercises: freezed == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>?,activities: freezed == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<Exercise>?,
  ));
}


}


/// @nodoc
mixin _$Exercise {

 String? get exerciseName; String? get details; String? get requiredEquipment; String? get sets; String? get reps; String? get rest; String? get intensity; String? get estimatedCompletionTime; String? get howToAdjust;
/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCopyWith<Exercise> get copyWith => _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exercise&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.details, details) || other.details == details)&&(identical(other.requiredEquipment, requiredEquipment) || other.requiredEquipment == requiredEquipment)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.rest, rest) || other.rest == rest)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedCompletionTime, estimatedCompletionTime) || other.estimatedCompletionTime == estimatedCompletionTime)&&(identical(other.howToAdjust, howToAdjust) || other.howToAdjust == howToAdjust));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseName,details,requiredEquipment,sets,reps,rest,intensity,estimatedCompletionTime,howToAdjust);

@override
String toString() {
  return 'Exercise(exerciseName: $exerciseName, details: $details, requiredEquipment: $requiredEquipment, sets: $sets, reps: $reps, rest: $rest, intensity: $intensity, estimatedCompletionTime: $estimatedCompletionTime, howToAdjust: $howToAdjust)';
}


}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res>  {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) = _$ExerciseCopyWithImpl;
@useResult
$Res call({
 String? exerciseName, String? details, String? requiredEquipment, String? sets, String? reps, String? rest, String? intensity, String? estimatedCompletionTime, String? howToAdjust
});




}
/// @nodoc
class _$ExerciseCopyWithImpl<$Res>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseName = freezed,Object? details = freezed,Object? requiredEquipment = freezed,Object? sets = freezed,Object? reps = freezed,Object? rest = freezed,Object? intensity = freezed,Object? estimatedCompletionTime = freezed,Object? howToAdjust = freezed,}) {
  return _then(_self.copyWith(
exerciseName: freezed == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,requiredEquipment: freezed == requiredEquipment ? _self.requiredEquipment : requiredEquipment // ignore: cast_nullable_to_non_nullable
as String?,sets: freezed == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as String?,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as String?,rest: freezed == rest ? _self.rest : rest // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String?,estimatedCompletionTime: freezed == estimatedCompletionTime ? _self.estimatedCompletionTime : estimatedCompletionTime // ignore: cast_nullable_to_non_nullable
as String?,howToAdjust: freezed == howToAdjust ? _self.howToAdjust : howToAdjust // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Exercise implements Exercise {
  const _Exercise({this.exerciseName, this.details, this.requiredEquipment, this.sets, this.reps, this.rest, this.intensity, this.estimatedCompletionTime, this.howToAdjust});
  factory _Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

@override final  String? exerciseName;
@override final  String? details;
@override final  String? requiredEquipment;
@override final  String? sets;
@override final  String? reps;
@override final  String? rest;
@override final  String? intensity;
@override final  String? estimatedCompletionTime;
@override final  String? howToAdjust;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCopyWith<_Exercise> get copyWith => __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exercise&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.details, details) || other.details == details)&&(identical(other.requiredEquipment, requiredEquipment) || other.requiredEquipment == requiredEquipment)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.rest, rest) || other.rest == rest)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.estimatedCompletionTime, estimatedCompletionTime) || other.estimatedCompletionTime == estimatedCompletionTime)&&(identical(other.howToAdjust, howToAdjust) || other.howToAdjust == howToAdjust));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseName,details,requiredEquipment,sets,reps,rest,intensity,estimatedCompletionTime,howToAdjust);

@override
String toString() {
  return 'Exercise(exerciseName: $exerciseName, details: $details, requiredEquipment: $requiredEquipment, sets: $sets, reps: $reps, rest: $rest, intensity: $intensity, estimatedCompletionTime: $estimatedCompletionTime, howToAdjust: $howToAdjust)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) = __$ExerciseCopyWithImpl;
@override @useResult
$Res call({
 String? exerciseName, String? details, String? requiredEquipment, String? sets, String? reps, String? rest, String? intensity, String? estimatedCompletionTime, String? howToAdjust
});




}
/// @nodoc
class __$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseName = freezed,Object? details = freezed,Object? requiredEquipment = freezed,Object? sets = freezed,Object? reps = freezed,Object? rest = freezed,Object? intensity = freezed,Object? estimatedCompletionTime = freezed,Object? howToAdjust = freezed,}) {
  return _then(_Exercise(
exerciseName: freezed == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,requiredEquipment: freezed == requiredEquipment ? _self.requiredEquipment : requiredEquipment // ignore: cast_nullable_to_non_nullable
as String?,sets: freezed == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as String?,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as String?,rest: freezed == rest ? _self.rest : rest // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String?,estimatedCompletionTime: freezed == estimatedCompletionTime ? _self.estimatedCompletionTime : estimatedCompletionTime // ignore: cast_nullable_to_non_nullable
as String?,howToAdjust: freezed == howToAdjust ? _self.howToAdjust : howToAdjust // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GlossaryItem {

 String? get term; String? get definition;
/// Create a copy of GlossaryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryItemCopyWith<GlossaryItem> get copyWith => _$GlossaryItemCopyWithImpl<GlossaryItem>(this as GlossaryItem, _$identity);

  /// Serializes this GlossaryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryItem&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,term,definition);

@override
String toString() {
  return 'GlossaryItem(term: $term, definition: $definition)';
}


}

/// @nodoc
abstract mixin class $GlossaryItemCopyWith<$Res>  {
  factory $GlossaryItemCopyWith(GlossaryItem value, $Res Function(GlossaryItem) _then) = _$GlossaryItemCopyWithImpl;
@useResult
$Res call({
 String? term, String? definition
});




}
/// @nodoc
class _$GlossaryItemCopyWithImpl<$Res>
    implements $GlossaryItemCopyWith<$Res> {
  _$GlossaryItemCopyWithImpl(this._self, this._then);

  final GlossaryItem _self;
  final $Res Function(GlossaryItem) _then;

/// Create a copy of GlossaryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? term = freezed,Object? definition = freezed,}) {
  return _then(_self.copyWith(
term: freezed == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String?,definition: freezed == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GlossaryItem implements GlossaryItem {
  const _GlossaryItem({this.term, this.definition});
  factory _GlossaryItem.fromJson(Map<String, dynamic> json) => _$GlossaryItemFromJson(json);

@override final  String? term;
@override final  String? definition;

/// Create a copy of GlossaryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryItemCopyWith<_GlossaryItem> get copyWith => __$GlossaryItemCopyWithImpl<_GlossaryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GlossaryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryItem&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,term,definition);

@override
String toString() {
  return 'GlossaryItem(term: $term, definition: $definition)';
}


}

/// @nodoc
abstract mixin class _$GlossaryItemCopyWith<$Res> implements $GlossaryItemCopyWith<$Res> {
  factory _$GlossaryItemCopyWith(_GlossaryItem value, $Res Function(_GlossaryItem) _then) = __$GlossaryItemCopyWithImpl;
@override @useResult
$Res call({
 String? term, String? definition
});




}
/// @nodoc
class __$GlossaryItemCopyWithImpl<$Res>
    implements _$GlossaryItemCopyWith<$Res> {
  __$GlossaryItemCopyWithImpl(this._self, this._then);

  final _GlossaryItem _self;
  final $Res Function(_GlossaryItem) _then;

/// Create a copy of GlossaryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? term = freezed,Object? definition = freezed,}) {
  return _then(_GlossaryItem(
term: freezed == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String?,definition: freezed == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
