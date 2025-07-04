// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingProgram _$TrainingProgramFromJson(Map<String, dynamic> json) {
  return _TrainingProgram.fromJson(json);
}

/// @nodoc
mixin _$TrainingProgram {
  String? get id => throw _privateConstructorUsedError;
  String? get programTitle => throw _privateConstructorUsedError;
  String? get programFocus => throw _privateConstructorUsedError;
  int? get durationWeeks => throw _privateConstructorUsedError;
  String? get programDescripton => throw _privateConstructorUsedError;
  ProgramNotes? get programNotes => throw _privateConstructorUsedError;
  List<WeeklySession>? get weeklySchedule => throw _privateConstructorUsedError;
  List<GlossaryItem>? get glossary => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this TrainingProgram to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingProgramCopyWith<TrainingProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingProgramCopyWith<$Res> {
  factory $TrainingProgramCopyWith(
    TrainingProgram value,
    $Res Function(TrainingProgram) then,
  ) = _$TrainingProgramCopyWithImpl<$Res, TrainingProgram>;
  @useResult
  $Res call({
    String? id,
    String? programTitle,
    String? programFocus,
    int? durationWeeks,
    String? programDescripton,
    ProgramNotes? programNotes,
    List<WeeklySession>? weeklySchedule,
    List<GlossaryItem>? glossary,
    @TimestampConverter() DateTime? startedAt,
    @TimestampConverter() DateTime? generatedAt,
  });

  $ProgramNotesCopyWith<$Res>? get programNotes;
}

/// @nodoc
class _$TrainingProgramCopyWithImpl<$Res, $Val extends TrainingProgram>
    implements $TrainingProgramCopyWith<$Res> {
  _$TrainingProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programTitle = freezed,
    Object? programFocus = freezed,
    Object? durationWeeks = freezed,
    Object? programDescripton = freezed,
    Object? programNotes = freezed,
    Object? weeklySchedule = freezed,
    Object? glossary = freezed,
    Object? startedAt = freezed,
    Object? generatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            programTitle: freezed == programTitle
                ? _value.programTitle
                : programTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            programFocus: freezed == programFocus
                ? _value.programFocus
                : programFocus // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationWeeks: freezed == durationWeeks
                ? _value.durationWeeks
                : durationWeeks // ignore: cast_nullable_to_non_nullable
                      as int?,
            programDescripton: freezed == programDescripton
                ? _value.programDescripton
                : programDescripton // ignore: cast_nullable_to_non_nullable
                      as String?,
            programNotes: freezed == programNotes
                ? _value.programNotes
                : programNotes // ignore: cast_nullable_to_non_nullable
                      as ProgramNotes?,
            weeklySchedule: freezed == weeklySchedule
                ? _value.weeklySchedule
                : weeklySchedule // ignore: cast_nullable_to_non_nullable
                      as List<WeeklySession>?,
            glossary: freezed == glossary
                ? _value.glossary
                : glossary // ignore: cast_nullable_to_non_nullable
                      as List<GlossaryItem>?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            generatedAt: freezed == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgramNotesCopyWith<$Res>? get programNotes {
    if (_value.programNotes == null) {
      return null;
    }

    return $ProgramNotesCopyWith<$Res>(_value.programNotes!, (value) {
      return _then(_value.copyWith(programNotes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainingProgramImplCopyWith<$Res>
    implements $TrainingProgramCopyWith<$Res> {
  factory _$$TrainingProgramImplCopyWith(
    _$TrainingProgramImpl value,
    $Res Function(_$TrainingProgramImpl) then,
  ) = __$$TrainingProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? programTitle,
    String? programFocus,
    int? durationWeeks,
    String? programDescripton,
    ProgramNotes? programNotes,
    List<WeeklySession>? weeklySchedule,
    List<GlossaryItem>? glossary,
    @TimestampConverter() DateTime? startedAt,
    @TimestampConverter() DateTime? generatedAt,
  });

  @override
  $ProgramNotesCopyWith<$Res>? get programNotes;
}

/// @nodoc
class __$$TrainingProgramImplCopyWithImpl<$Res>
    extends _$TrainingProgramCopyWithImpl<$Res, _$TrainingProgramImpl>
    implements _$$TrainingProgramImplCopyWith<$Res> {
  __$$TrainingProgramImplCopyWithImpl(
    _$TrainingProgramImpl _value,
    $Res Function(_$TrainingProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programTitle = freezed,
    Object? programFocus = freezed,
    Object? durationWeeks = freezed,
    Object? programDescripton = freezed,
    Object? programNotes = freezed,
    Object? weeklySchedule = freezed,
    Object? glossary = freezed,
    Object? startedAt = freezed,
    Object? generatedAt = freezed,
  }) {
    return _then(
      _$TrainingProgramImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        programTitle: freezed == programTitle
            ? _value.programTitle
            : programTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        programFocus: freezed == programFocus
            ? _value.programFocus
            : programFocus // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationWeeks: freezed == durationWeeks
            ? _value.durationWeeks
            : durationWeeks // ignore: cast_nullable_to_non_nullable
                  as int?,
        programDescripton: freezed == programDescripton
            ? _value.programDescripton
            : programDescripton // ignore: cast_nullable_to_non_nullable
                  as String?,
        programNotes: freezed == programNotes
            ? _value.programNotes
            : programNotes // ignore: cast_nullable_to_non_nullable
                  as ProgramNotes?,
        weeklySchedule: freezed == weeklySchedule
            ? _value._weeklySchedule
            : weeklySchedule // ignore: cast_nullable_to_non_nullable
                  as List<WeeklySession>?,
        glossary: freezed == glossary
            ? _value._glossary
            : glossary // ignore: cast_nullable_to_non_nullable
                  as List<GlossaryItem>?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        generatedAt: freezed == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingProgramImpl extends _TrainingProgram {
  const _$TrainingProgramImpl({
    this.id,
    this.programTitle,
    this.programFocus,
    this.durationWeeks,
    this.programDescripton,
    this.programNotes,
    final List<WeeklySession>? weeklySchedule,
    final List<GlossaryItem>? glossary,
    @TimestampConverter() this.startedAt,
    @TimestampConverter() this.generatedAt,
  }) : _weeklySchedule = weeklySchedule,
       _glossary = glossary,
       super._();

  factory _$TrainingProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingProgramImplFromJson(json);

  @override
  final String? id;
  @override
  final String? programTitle;
  @override
  final String? programFocus;
  @override
  final int? durationWeeks;
  @override
  final String? programDescripton;
  @override
  final ProgramNotes? programNotes;
  final List<WeeklySession>? _weeklySchedule;
  @override
  List<WeeklySession>? get weeklySchedule {
    final value = _weeklySchedule;
    if (value == null) return null;
    if (_weeklySchedule is EqualUnmodifiableListView) return _weeklySchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GlossaryItem>? _glossary;
  @override
  List<GlossaryItem>? get glossary {
    final value = _glossary;
    if (value == null) return null;
    if (_glossary is EqualUnmodifiableListView) return _glossary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @TimestampConverter()
  final DateTime? startedAt;
  @override
  @TimestampConverter()
  final DateTime? generatedAt;

  @override
  String toString() {
    return 'TrainingProgram(id: $id, programTitle: $programTitle, programFocus: $programFocus, durationWeeks: $durationWeeks, programDescripton: $programDescripton, programNotes: $programNotes, weeklySchedule: $weeklySchedule, glossary: $glossary, startedAt: $startedAt, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.programTitle, programTitle) ||
                other.programTitle == programTitle) &&
            (identical(other.programFocus, programFocus) ||
                other.programFocus == programFocus) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            (identical(other.programDescripton, programDescripton) ||
                other.programDescripton == programDescripton) &&
            (identical(other.programNotes, programNotes) ||
                other.programNotes == programNotes) &&
            const DeepCollectionEquality().equals(
              other._weeklySchedule,
              _weeklySchedule,
            ) &&
            const DeepCollectionEquality().equals(other._glossary, _glossary) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    programTitle,
    programFocus,
    durationWeeks,
    programDescripton,
    programNotes,
    const DeepCollectionEquality().hash(_weeklySchedule),
    const DeepCollectionEquality().hash(_glossary),
    startedAt,
    generatedAt,
  );

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingProgramImplCopyWith<_$TrainingProgramImpl> get copyWith =>
      __$$TrainingProgramImplCopyWithImpl<_$TrainingProgramImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingProgramImplToJson(this);
  }
}

abstract class _TrainingProgram extends TrainingProgram {
  const factory _TrainingProgram({
    final String? id,
    final String? programTitle,
    final String? programFocus,
    final int? durationWeeks,
    final String? programDescripton,
    final ProgramNotes? programNotes,
    final List<WeeklySession>? weeklySchedule,
    final List<GlossaryItem>? glossary,
    @TimestampConverter() final DateTime? startedAt,
    @TimestampConverter() final DateTime? generatedAt,
  }) = _$TrainingProgramImpl;
  const _TrainingProgram._() : super._();

  factory _TrainingProgram.fromJson(Map<String, dynamic> json) =
      _$TrainingProgramImpl.fromJson;

  @override
  String? get id;
  @override
  String? get programTitle;
  @override
  String? get programFocus;
  @override
  int? get durationWeeks;
  @override
  String? get programDescripton;
  @override
  ProgramNotes? get programNotes;
  @override
  List<WeeklySession>? get weeklySchedule;
  @override
  List<GlossaryItem>? get glossary;
  @override
  @TimestampConverter()
  DateTime? get startedAt;
  @override
  @TimestampConverter()
  DateTime? get generatedAt;

  /// Create a copy of TrainingProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingProgramImplCopyWith<_$TrainingProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramNotes _$ProgramNotesFromJson(Map<String, dynamic> json) {
  return _ProgramNotes.fromJson(json);
}

/// @nodoc
mixin _$ProgramNotes {
  String? get safetyDisclaimer => throw _privateConstructorUsedError;
  String? get injuryModifications => throw _privateConstructorUsedError;
  String? get assumptionsMade => throw _privateConstructorUsedError;

  /// Serializes this ProgramNotes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramNotes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramNotesCopyWith<ProgramNotes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramNotesCopyWith<$Res> {
  factory $ProgramNotesCopyWith(
    ProgramNotes value,
    $Res Function(ProgramNotes) then,
  ) = _$ProgramNotesCopyWithImpl<$Res, ProgramNotes>;
  @useResult
  $Res call({
    String? safetyDisclaimer,
    String? injuryModifications,
    String? assumptionsMade,
  });
}

/// @nodoc
class _$ProgramNotesCopyWithImpl<$Res, $Val extends ProgramNotes>
    implements $ProgramNotesCopyWith<$Res> {
  _$ProgramNotesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramNotes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? safetyDisclaimer = freezed,
    Object? injuryModifications = freezed,
    Object? assumptionsMade = freezed,
  }) {
    return _then(
      _value.copyWith(
            safetyDisclaimer: freezed == safetyDisclaimer
                ? _value.safetyDisclaimer
                : safetyDisclaimer // ignore: cast_nullable_to_non_nullable
                      as String?,
            injuryModifications: freezed == injuryModifications
                ? _value.injuryModifications
                : injuryModifications // ignore: cast_nullable_to_non_nullable
                      as String?,
            assumptionsMade: freezed == assumptionsMade
                ? _value.assumptionsMade
                : assumptionsMade // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramNotesImplCopyWith<$Res>
    implements $ProgramNotesCopyWith<$Res> {
  factory _$$ProgramNotesImplCopyWith(
    _$ProgramNotesImpl value,
    $Res Function(_$ProgramNotesImpl) then,
  ) = __$$ProgramNotesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? safetyDisclaimer,
    String? injuryModifications,
    String? assumptionsMade,
  });
}

/// @nodoc
class __$$ProgramNotesImplCopyWithImpl<$Res>
    extends _$ProgramNotesCopyWithImpl<$Res, _$ProgramNotesImpl>
    implements _$$ProgramNotesImplCopyWith<$Res> {
  __$$ProgramNotesImplCopyWithImpl(
    _$ProgramNotesImpl _value,
    $Res Function(_$ProgramNotesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramNotes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? safetyDisclaimer = freezed,
    Object? injuryModifications = freezed,
    Object? assumptionsMade = freezed,
  }) {
    return _then(
      _$ProgramNotesImpl(
        safetyDisclaimer: freezed == safetyDisclaimer
            ? _value.safetyDisclaimer
            : safetyDisclaimer // ignore: cast_nullable_to_non_nullable
                  as String?,
        injuryModifications: freezed == injuryModifications
            ? _value.injuryModifications
            : injuryModifications // ignore: cast_nullable_to_non_nullable
                  as String?,
        assumptionsMade: freezed == assumptionsMade
            ? _value.assumptionsMade
            : assumptionsMade // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramNotesImpl implements _ProgramNotes {
  const _$ProgramNotesImpl({
    this.safetyDisclaimer,
    this.injuryModifications,
    this.assumptionsMade,
  });

  factory _$ProgramNotesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramNotesImplFromJson(json);

  @override
  final String? safetyDisclaimer;
  @override
  final String? injuryModifications;
  @override
  final String? assumptionsMade;

  @override
  String toString() {
    return 'ProgramNotes(safetyDisclaimer: $safetyDisclaimer, injuryModifications: $injuryModifications, assumptionsMade: $assumptionsMade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramNotesImpl &&
            (identical(other.safetyDisclaimer, safetyDisclaimer) ||
                other.safetyDisclaimer == safetyDisclaimer) &&
            (identical(other.injuryModifications, injuryModifications) ||
                other.injuryModifications == injuryModifications) &&
            (identical(other.assumptionsMade, assumptionsMade) ||
                other.assumptionsMade == assumptionsMade));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    safetyDisclaimer,
    injuryModifications,
    assumptionsMade,
  );

  /// Create a copy of ProgramNotes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramNotesImplCopyWith<_$ProgramNotesImpl> get copyWith =>
      __$$ProgramNotesImplCopyWithImpl<_$ProgramNotesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramNotesImplToJson(this);
  }
}

abstract class _ProgramNotes implements ProgramNotes {
  const factory _ProgramNotes({
    final String? safetyDisclaimer,
    final String? injuryModifications,
    final String? assumptionsMade,
  }) = _$ProgramNotesImpl;

  factory _ProgramNotes.fromJson(Map<String, dynamic> json) =
      _$ProgramNotesImpl.fromJson;

  @override
  String? get safetyDisclaimer;
  @override
  String? get injuryModifications;
  @override
  String? get assumptionsMade;

  /// Create a copy of ProgramNotes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramNotesImplCopyWith<_$ProgramNotesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeeklySession _$WeeklySessionFromJson(Map<String, dynamic> json) {
  return _WeeklySession.fromJson(json);
}

/// @nodoc
mixin _$WeeklySession {
  int? get week => throw _privateConstructorUsedError;
  String? get phase => throw _privateConstructorUsedError;
  String? get weeklyFocus => throw _privateConstructorUsedError;
  List<DailySession>? get dailySessions => throw _privateConstructorUsedError;

  /// Serializes this WeeklySession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklySession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklySessionCopyWith<WeeklySession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklySessionCopyWith<$Res> {
  factory $WeeklySessionCopyWith(
    WeeklySession value,
    $Res Function(WeeklySession) then,
  ) = _$WeeklySessionCopyWithImpl<$Res, WeeklySession>;
  @useResult
  $Res call({
    int? week,
    String? phase,
    String? weeklyFocus,
    List<DailySession>? dailySessions,
  });
}

/// @nodoc
class _$WeeklySessionCopyWithImpl<$Res, $Val extends WeeklySession>
    implements $WeeklySessionCopyWith<$Res> {
  _$WeeklySessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklySession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = freezed,
    Object? phase = freezed,
    Object? weeklyFocus = freezed,
    Object? dailySessions = freezed,
  }) {
    return _then(
      _value.copyWith(
            week: freezed == week
                ? _value.week
                : week // ignore: cast_nullable_to_non_nullable
                      as int?,
            phase: freezed == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as String?,
            weeklyFocus: freezed == weeklyFocus
                ? _value.weeklyFocus
                : weeklyFocus // ignore: cast_nullable_to_non_nullable
                      as String?,
            dailySessions: freezed == dailySessions
                ? _value.dailySessions
                : dailySessions // ignore: cast_nullable_to_non_nullable
                      as List<DailySession>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklySessionImplCopyWith<$Res>
    implements $WeeklySessionCopyWith<$Res> {
  factory _$$WeeklySessionImplCopyWith(
    _$WeeklySessionImpl value,
    $Res Function(_$WeeklySessionImpl) then,
  ) = __$$WeeklySessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? week,
    String? phase,
    String? weeklyFocus,
    List<DailySession>? dailySessions,
  });
}

/// @nodoc
class __$$WeeklySessionImplCopyWithImpl<$Res>
    extends _$WeeklySessionCopyWithImpl<$Res, _$WeeklySessionImpl>
    implements _$$WeeklySessionImplCopyWith<$Res> {
  __$$WeeklySessionImplCopyWithImpl(
    _$WeeklySessionImpl _value,
    $Res Function(_$WeeklySessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklySession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = freezed,
    Object? phase = freezed,
    Object? weeklyFocus = freezed,
    Object? dailySessions = freezed,
  }) {
    return _then(
      _$WeeklySessionImpl(
        week: freezed == week
            ? _value.week
            : week // ignore: cast_nullable_to_non_nullable
                  as int?,
        phase: freezed == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as String?,
        weeklyFocus: freezed == weeklyFocus
            ? _value.weeklyFocus
            : weeklyFocus // ignore: cast_nullable_to_non_nullable
                  as String?,
        dailySessions: freezed == dailySessions
            ? _value._dailySessions
            : dailySessions // ignore: cast_nullable_to_non_nullable
                  as List<DailySession>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklySessionImpl implements _WeeklySession {
  const _$WeeklySessionImpl({
    this.week,
    this.phase,
    this.weeklyFocus,
    final List<DailySession>? dailySessions,
  }) : _dailySessions = dailySessions;

  factory _$WeeklySessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklySessionImplFromJson(json);

  @override
  final int? week;
  @override
  final String? phase;
  @override
  final String? weeklyFocus;
  final List<DailySession>? _dailySessions;
  @override
  List<DailySession>? get dailySessions {
    final value = _dailySessions;
    if (value == null) return null;
    if (_dailySessions is EqualUnmodifiableListView) return _dailySessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WeeklySession(week: $week, phase: $phase, weeklyFocus: $weeklyFocus, dailySessions: $dailySessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklySessionImpl &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.weeklyFocus, weeklyFocus) ||
                other.weeklyFocus == weeklyFocus) &&
            const DeepCollectionEquality().equals(
              other._dailySessions,
              _dailySessions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    week,
    phase,
    weeklyFocus,
    const DeepCollectionEquality().hash(_dailySessions),
  );

  /// Create a copy of WeeklySession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklySessionImplCopyWith<_$WeeklySessionImpl> get copyWith =>
      __$$WeeklySessionImplCopyWithImpl<_$WeeklySessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklySessionImplToJson(this);
  }
}

abstract class _WeeklySession implements WeeklySession {
  const factory _WeeklySession({
    final int? week,
    final String? phase,
    final String? weeklyFocus,
    final List<DailySession>? dailySessions,
  }) = _$WeeklySessionImpl;

  factory _WeeklySession.fromJson(Map<String, dynamic> json) =
      _$WeeklySessionImpl.fromJson;

  @override
  int? get week;
  @override
  String? get phase;
  @override
  String? get weeklyFocus;
  @override
  List<DailySession>? get dailySessions;

  /// Create a copy of WeeklySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklySessionImplCopyWith<_$WeeklySessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailySession _$DailySessionFromJson(Map<String, dynamic> json) {
  return _DailySession.fromJson(json);
}

/// @nodoc
mixin _$DailySession {
  int? get sessionNumber => throw _privateConstructorUsedError;
  String? get dayOfTheWeek => throw _privateConstructorUsedError;
  String? get sessionType => throw _privateConstructorUsedError;
  String? get sessionFocus => throw _privateConstructorUsedError;
  SessionPhase? get warmUp => throw _privateConstructorUsedError;
  SessionPhase? get mainSession => throw _privateConstructorUsedError;
  SessionPhase? get coolDown => throw _privateConstructorUsedError;

  /// Serializes this DailySession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySessionCopyWith<DailySession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySessionCopyWith<$Res> {
  factory $DailySessionCopyWith(
    DailySession value,
    $Res Function(DailySession) then,
  ) = _$DailySessionCopyWithImpl<$Res, DailySession>;
  @useResult
  $Res call({
    int? sessionNumber,
    String? dayOfTheWeek,
    String? sessionType,
    String? sessionFocus,
    SessionPhase? warmUp,
    SessionPhase? mainSession,
    SessionPhase? coolDown,
  });

  $SessionPhaseCopyWith<$Res>? get warmUp;
  $SessionPhaseCopyWith<$Res>? get mainSession;
  $SessionPhaseCopyWith<$Res>? get coolDown;
}

/// @nodoc
class _$DailySessionCopyWithImpl<$Res, $Val extends DailySession>
    implements $DailySessionCopyWith<$Res> {
  _$DailySessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionNumber = freezed,
    Object? dayOfTheWeek = freezed,
    Object? sessionType = freezed,
    Object? sessionFocus = freezed,
    Object? warmUp = freezed,
    Object? mainSession = freezed,
    Object? coolDown = freezed,
  }) {
    return _then(
      _value.copyWith(
            sessionNumber: freezed == sessionNumber
                ? _value.sessionNumber
                : sessionNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            dayOfTheWeek: freezed == dayOfTheWeek
                ? _value.dayOfTheWeek
                : dayOfTheWeek // ignore: cast_nullable_to_non_nullable
                      as String?,
            sessionType: freezed == sessionType
                ? _value.sessionType
                : sessionType // ignore: cast_nullable_to_non_nullable
                      as String?,
            sessionFocus: freezed == sessionFocus
                ? _value.sessionFocus
                : sessionFocus // ignore: cast_nullable_to_non_nullable
                      as String?,
            warmUp: freezed == warmUp
                ? _value.warmUp
                : warmUp // ignore: cast_nullable_to_non_nullable
                      as SessionPhase?,
            mainSession: freezed == mainSession
                ? _value.mainSession
                : mainSession // ignore: cast_nullable_to_non_nullable
                      as SessionPhase?,
            coolDown: freezed == coolDown
                ? _value.coolDown
                : coolDown // ignore: cast_nullable_to_non_nullable
                      as SessionPhase?,
          )
          as $Val,
    );
  }

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionPhaseCopyWith<$Res>? get warmUp {
    if (_value.warmUp == null) {
      return null;
    }

    return $SessionPhaseCopyWith<$Res>(_value.warmUp!, (value) {
      return _then(_value.copyWith(warmUp: value) as $Val);
    });
  }

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionPhaseCopyWith<$Res>? get mainSession {
    if (_value.mainSession == null) {
      return null;
    }

    return $SessionPhaseCopyWith<$Res>(_value.mainSession!, (value) {
      return _then(_value.copyWith(mainSession: value) as $Val);
    });
  }

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionPhaseCopyWith<$Res>? get coolDown {
    if (_value.coolDown == null) {
      return null;
    }

    return $SessionPhaseCopyWith<$Res>(_value.coolDown!, (value) {
      return _then(_value.copyWith(coolDown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailySessionImplCopyWith<$Res>
    implements $DailySessionCopyWith<$Res> {
  factory _$$DailySessionImplCopyWith(
    _$DailySessionImpl value,
    $Res Function(_$DailySessionImpl) then,
  ) = __$$DailySessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? sessionNumber,
    String? dayOfTheWeek,
    String? sessionType,
    String? sessionFocus,
    SessionPhase? warmUp,
    SessionPhase? mainSession,
    SessionPhase? coolDown,
  });

  @override
  $SessionPhaseCopyWith<$Res>? get warmUp;
  @override
  $SessionPhaseCopyWith<$Res>? get mainSession;
  @override
  $SessionPhaseCopyWith<$Res>? get coolDown;
}

/// @nodoc
class __$$DailySessionImplCopyWithImpl<$Res>
    extends _$DailySessionCopyWithImpl<$Res, _$DailySessionImpl>
    implements _$$DailySessionImplCopyWith<$Res> {
  __$$DailySessionImplCopyWithImpl(
    _$DailySessionImpl _value,
    $Res Function(_$DailySessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionNumber = freezed,
    Object? dayOfTheWeek = freezed,
    Object? sessionType = freezed,
    Object? sessionFocus = freezed,
    Object? warmUp = freezed,
    Object? mainSession = freezed,
    Object? coolDown = freezed,
  }) {
    return _then(
      _$DailySessionImpl(
        sessionNumber: freezed == sessionNumber
            ? _value.sessionNumber
            : sessionNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        dayOfTheWeek: freezed == dayOfTheWeek
            ? _value.dayOfTheWeek
            : dayOfTheWeek // ignore: cast_nullable_to_non_nullable
                  as String?,
        sessionType: freezed == sessionType
            ? _value.sessionType
            : sessionType // ignore: cast_nullable_to_non_nullable
                  as String?,
        sessionFocus: freezed == sessionFocus
            ? _value.sessionFocus
            : sessionFocus // ignore: cast_nullable_to_non_nullable
                  as String?,
        warmUp: freezed == warmUp
            ? _value.warmUp
            : warmUp // ignore: cast_nullable_to_non_nullable
                  as SessionPhase?,
        mainSession: freezed == mainSession
            ? _value.mainSession
            : mainSession // ignore: cast_nullable_to_non_nullable
                  as SessionPhase?,
        coolDown: freezed == coolDown
            ? _value.coolDown
            : coolDown // ignore: cast_nullable_to_non_nullable
                  as SessionPhase?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySessionImpl implements _DailySession {
  const _$DailySessionImpl({
    this.sessionNumber,
    this.dayOfTheWeek,
    this.sessionType,
    this.sessionFocus,
    this.warmUp,
    this.mainSession,
    this.coolDown,
  });

  factory _$DailySessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySessionImplFromJson(json);

  @override
  final int? sessionNumber;
  @override
  final String? dayOfTheWeek;
  @override
  final String? sessionType;
  @override
  final String? sessionFocus;
  @override
  final SessionPhase? warmUp;
  @override
  final SessionPhase? mainSession;
  @override
  final SessionPhase? coolDown;

  @override
  String toString() {
    return 'DailySession(sessionNumber: $sessionNumber, dayOfTheWeek: $dayOfTheWeek, sessionType: $sessionType, sessionFocus: $sessionFocus, warmUp: $warmUp, mainSession: $mainSession, coolDown: $coolDown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySessionImpl &&
            (identical(other.sessionNumber, sessionNumber) ||
                other.sessionNumber == sessionNumber) &&
            (identical(other.dayOfTheWeek, dayOfTheWeek) ||
                other.dayOfTheWeek == dayOfTheWeek) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.sessionFocus, sessionFocus) ||
                other.sessionFocus == sessionFocus) &&
            (identical(other.warmUp, warmUp) || other.warmUp == warmUp) &&
            (identical(other.mainSession, mainSession) ||
                other.mainSession == mainSession) &&
            (identical(other.coolDown, coolDown) ||
                other.coolDown == coolDown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionNumber,
    dayOfTheWeek,
    sessionType,
    sessionFocus,
    warmUp,
    mainSession,
    coolDown,
  );

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySessionImplCopyWith<_$DailySessionImpl> get copyWith =>
      __$$DailySessionImplCopyWithImpl<_$DailySessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySessionImplToJson(this);
  }
}

abstract class _DailySession implements DailySession {
  const factory _DailySession({
    final int? sessionNumber,
    final String? dayOfTheWeek,
    final String? sessionType,
    final String? sessionFocus,
    final SessionPhase? warmUp,
    final SessionPhase? mainSession,
    final SessionPhase? coolDown,
  }) = _$DailySessionImpl;

  factory _DailySession.fromJson(Map<String, dynamic> json) =
      _$DailySessionImpl.fromJson;

  @override
  int? get sessionNumber;
  @override
  String? get dayOfTheWeek;
  @override
  String? get sessionType;
  @override
  String? get sessionFocus;
  @override
  SessionPhase? get warmUp;
  @override
  SessionPhase? get mainSession;
  @override
  SessionPhase? get coolDown;

  /// Create a copy of DailySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySessionImplCopyWith<_$DailySessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionPhase _$SessionPhaseFromJson(Map<String, dynamic> json) {
  return _SessionPhase.fromJson(json);
}

/// @nodoc
mixin _$SessionPhase {
  int? get durationMinutes => throw _privateConstructorUsedError;
  List<Exercise>? get exercises => throw _privateConstructorUsedError;
  List<Exercise>? get activities => throw _privateConstructorUsedError;

  /// Serializes this SessionPhase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionPhaseCopyWith<SessionPhase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionPhaseCopyWith<$Res> {
  factory $SessionPhaseCopyWith(
    SessionPhase value,
    $Res Function(SessionPhase) then,
  ) = _$SessionPhaseCopyWithImpl<$Res, SessionPhase>;
  @useResult
  $Res call({
    int? durationMinutes,
    List<Exercise>? exercises,
    List<Exercise>? activities,
  });
}

/// @nodoc
class _$SessionPhaseCopyWithImpl<$Res, $Val extends SessionPhase>
    implements $SessionPhaseCopyWith<$Res> {
  _$SessionPhaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionPhase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationMinutes = freezed,
    Object? exercises = freezed,
    Object? activities = freezed,
  }) {
    return _then(
      _value.copyWith(
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            exercises: freezed == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<Exercise>?,
            activities: freezed == activities
                ? _value.activities
                : activities // ignore: cast_nullable_to_non_nullable
                      as List<Exercise>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionPhaseImplCopyWith<$Res>
    implements $SessionPhaseCopyWith<$Res> {
  factory _$$SessionPhaseImplCopyWith(
    _$SessionPhaseImpl value,
    $Res Function(_$SessionPhaseImpl) then,
  ) = __$$SessionPhaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? durationMinutes,
    List<Exercise>? exercises,
    List<Exercise>? activities,
  });
}

/// @nodoc
class __$$SessionPhaseImplCopyWithImpl<$Res>
    extends _$SessionPhaseCopyWithImpl<$Res, _$SessionPhaseImpl>
    implements _$$SessionPhaseImplCopyWith<$Res> {
  __$$SessionPhaseImplCopyWithImpl(
    _$SessionPhaseImpl _value,
    $Res Function(_$SessionPhaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionPhase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationMinutes = freezed,
    Object? exercises = freezed,
    Object? activities = freezed,
  }) {
    return _then(
      _$SessionPhaseImpl(
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        exercises: freezed == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<Exercise>?,
        activities: freezed == activities
            ? _value._activities
            : activities // ignore: cast_nullable_to_non_nullable
                  as List<Exercise>?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SessionPhaseImpl implements _SessionPhase {
  const _$SessionPhaseImpl({
    this.durationMinutes,
    final List<Exercise>? exercises,
    final List<Exercise>? activities,
  }) : _exercises = exercises,
       _activities = activities;

  factory _$SessionPhaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionPhaseImplFromJson(json);

  @override
  final int? durationMinutes;
  final List<Exercise>? _exercises;
  @override
  List<Exercise>? get exercises {
    final value = _exercises;
    if (value == null) return null;
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Exercise>? _activities;
  @override
  List<Exercise>? get activities {
    final value = _activities;
    if (value == null) return null;
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SessionPhase(durationMinutes: $durationMinutes, exercises: $exercises, activities: $activities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionPhaseImpl &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ) &&
            const DeepCollectionEquality().equals(
              other._activities,
              _activities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    durationMinutes,
    const DeepCollectionEquality().hash(_exercises),
    const DeepCollectionEquality().hash(_activities),
  );

  /// Create a copy of SessionPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionPhaseImplCopyWith<_$SessionPhaseImpl> get copyWith =>
      __$$SessionPhaseImplCopyWithImpl<_$SessionPhaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionPhaseImplToJson(this);
  }
}

abstract class _SessionPhase implements SessionPhase {
  const factory _SessionPhase({
    final int? durationMinutes,
    final List<Exercise>? exercises,
    final List<Exercise>? activities,
  }) = _$SessionPhaseImpl;

  factory _SessionPhase.fromJson(Map<String, dynamic> json) =
      _$SessionPhaseImpl.fromJson;

  @override
  int? get durationMinutes;
  @override
  List<Exercise>? get exercises;
  @override
  List<Exercise>? get activities;

  /// Create a copy of SessionPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionPhaseImplCopyWith<_$SessionPhaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String? get exerciseName => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  String? get requiredEquipment => throw _privateConstructorUsedError;
  String? get sets => throw _privateConstructorUsedError;
  String? get reps => throw _privateConstructorUsedError;
  String? get rest => throw _privateConstructorUsedError;
  String? get intensity => throw _privateConstructorUsedError;
  String? get estimatedCompletionTime => throw _privateConstructorUsedError;
  String? get howToAdjust => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call({
    String? exerciseName,
    String? details,
    String? requiredEquipment,
    String? sets,
    String? reps,
    String? rest,
    String? intensity,
    String? estimatedCompletionTime,
    String? howToAdjust,
  });
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseName = freezed,
    Object? details = freezed,
    Object? requiredEquipment = freezed,
    Object? sets = freezed,
    Object? reps = freezed,
    Object? rest = freezed,
    Object? intensity = freezed,
    Object? estimatedCompletionTime = freezed,
    Object? howToAdjust = freezed,
  }) {
    return _then(
      _value.copyWith(
            exerciseName: freezed == exerciseName
                ? _value.exerciseName
                : exerciseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredEquipment: freezed == requiredEquipment
                ? _value.requiredEquipment
                : requiredEquipment // ignore: cast_nullable_to_non_nullable
                      as String?,
            sets: freezed == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as String?,
            reps: freezed == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as String?,
            rest: freezed == rest
                ? _value.rest
                : rest // ignore: cast_nullable_to_non_nullable
                      as String?,
            intensity: freezed == intensity
                ? _value.intensity
                : intensity // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedCompletionTime: freezed == estimatedCompletionTime
                ? _value.estimatedCompletionTime
                : estimatedCompletionTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            howToAdjust: freezed == howToAdjust
                ? _value.howToAdjust
                : howToAdjust // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
    _$ExerciseImpl value,
    $Res Function(_$ExerciseImpl) then,
  ) = __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? exerciseName,
    String? details,
    String? requiredEquipment,
    String? sets,
    String? reps,
    String? rest,
    String? intensity,
    String? estimatedCompletionTime,
    String? howToAdjust,
  });
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
    _$ExerciseImpl _value,
    $Res Function(_$ExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseName = freezed,
    Object? details = freezed,
    Object? requiredEquipment = freezed,
    Object? sets = freezed,
    Object? reps = freezed,
    Object? rest = freezed,
    Object? intensity = freezed,
    Object? estimatedCompletionTime = freezed,
    Object? howToAdjust = freezed,
  }) {
    return _then(
      _$ExerciseImpl(
        exerciseName: freezed == exerciseName
            ? _value.exerciseName
            : exerciseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredEquipment: freezed == requiredEquipment
            ? _value.requiredEquipment
            : requiredEquipment // ignore: cast_nullable_to_non_nullable
                  as String?,
        sets: freezed == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as String?,
        reps: freezed == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as String?,
        rest: freezed == rest
            ? _value.rest
            : rest // ignore: cast_nullable_to_non_nullable
                  as String?,
        intensity: freezed == intensity
            ? _value.intensity
            : intensity // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedCompletionTime: freezed == estimatedCompletionTime
            ? _value.estimatedCompletionTime
            : estimatedCompletionTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        howToAdjust: freezed == howToAdjust
            ? _value.howToAdjust
            : howToAdjust // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl({
    this.exerciseName,
    this.details,
    this.requiredEquipment,
    this.sets,
    this.reps,
    this.rest,
    this.intensity,
    this.estimatedCompletionTime,
    this.howToAdjust,
  });

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String? exerciseName;
  @override
  final String? details;
  @override
  final String? requiredEquipment;
  @override
  final String? sets;
  @override
  final String? reps;
  @override
  final String? rest;
  @override
  final String? intensity;
  @override
  final String? estimatedCompletionTime;
  @override
  final String? howToAdjust;

  @override
  String toString() {
    return 'Exercise(exerciseName: $exerciseName, details: $details, requiredEquipment: $requiredEquipment, sets: $sets, reps: $reps, rest: $rest, intensity: $intensity, estimatedCompletionTime: $estimatedCompletionTime, howToAdjust: $howToAdjust)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.requiredEquipment, requiredEquipment) ||
                other.requiredEquipment == requiredEquipment) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.rest, rest) || other.rest == rest) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(
                  other.estimatedCompletionTime,
                  estimatedCompletionTime,
                ) ||
                other.estimatedCompletionTime == estimatedCompletionTime) &&
            (identical(other.howToAdjust, howToAdjust) ||
                other.howToAdjust == howToAdjust));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exerciseName,
    details,
    requiredEquipment,
    sets,
    reps,
    rest,
    intensity,
    estimatedCompletionTime,
    howToAdjust,
  );

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(this);
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise({
    final String? exerciseName,
    final String? details,
    final String? requiredEquipment,
    final String? sets,
    final String? reps,
    final String? rest,
    final String? intensity,
    final String? estimatedCompletionTime,
    final String? howToAdjust,
  }) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String? get exerciseName;
  @override
  String? get details;
  @override
  String? get requiredEquipment;
  @override
  String? get sets;
  @override
  String? get reps;
  @override
  String? get rest;
  @override
  String? get intensity;
  @override
  String? get estimatedCompletionTime;
  @override
  String? get howToAdjust;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GlossaryItem _$GlossaryItemFromJson(Map<String, dynamic> json) {
  return _GlossaryItem.fromJson(json);
}

/// @nodoc
mixin _$GlossaryItem {
  String? get term => throw _privateConstructorUsedError;
  String? get definition => throw _privateConstructorUsedError;

  /// Serializes this GlossaryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GlossaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GlossaryItemCopyWith<GlossaryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlossaryItemCopyWith<$Res> {
  factory $GlossaryItemCopyWith(
    GlossaryItem value,
    $Res Function(GlossaryItem) then,
  ) = _$GlossaryItemCopyWithImpl<$Res, GlossaryItem>;
  @useResult
  $Res call({String? term, String? definition});
}

/// @nodoc
class _$GlossaryItemCopyWithImpl<$Res, $Val extends GlossaryItem>
    implements $GlossaryItemCopyWith<$Res> {
  _$GlossaryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GlossaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? term = freezed, Object? definition = freezed}) {
    return _then(
      _value.copyWith(
            term: freezed == term
                ? _value.term
                : term // ignore: cast_nullable_to_non_nullable
                      as String?,
            definition: freezed == definition
                ? _value.definition
                : definition // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GlossaryItemImplCopyWith<$Res>
    implements $GlossaryItemCopyWith<$Res> {
  factory _$$GlossaryItemImplCopyWith(
    _$GlossaryItemImpl value,
    $Res Function(_$GlossaryItemImpl) then,
  ) = __$$GlossaryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? term, String? definition});
}

/// @nodoc
class __$$GlossaryItemImplCopyWithImpl<$Res>
    extends _$GlossaryItemCopyWithImpl<$Res, _$GlossaryItemImpl>
    implements _$$GlossaryItemImplCopyWith<$Res> {
  __$$GlossaryItemImplCopyWithImpl(
    _$GlossaryItemImpl _value,
    $Res Function(_$GlossaryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GlossaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? term = freezed, Object? definition = freezed}) {
    return _then(
      _$GlossaryItemImpl(
        term: freezed == term
            ? _value.term
            : term // ignore: cast_nullable_to_non_nullable
                  as String?,
        definition: freezed == definition
            ? _value.definition
            : definition // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GlossaryItemImpl implements _GlossaryItem {
  const _$GlossaryItemImpl({this.term, this.definition});

  factory _$GlossaryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GlossaryItemImplFromJson(json);

  @override
  final String? term;
  @override
  final String? definition;

  @override
  String toString() {
    return 'GlossaryItem(term: $term, definition: $definition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlossaryItemImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.definition, definition) ||
                other.definition == definition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, term, definition);

  /// Create a copy of GlossaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GlossaryItemImplCopyWith<_$GlossaryItemImpl> get copyWith =>
      __$$GlossaryItemImplCopyWithImpl<_$GlossaryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GlossaryItemImplToJson(this);
  }
}

abstract class _GlossaryItem implements GlossaryItem {
  const factory _GlossaryItem({final String? term, final String? definition}) =
      _$GlossaryItemImpl;

  factory _GlossaryItem.fromJson(Map<String, dynamic> json) =
      _$GlossaryItemImpl.fromJson;

  @override
  String? get term;
  @override
  String? get definition;

  /// Create a copy of GlossaryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GlossaryItemImplCopyWith<_$GlossaryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
