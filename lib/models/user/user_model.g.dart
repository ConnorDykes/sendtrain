// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      activeProgramId: json['activeProgramId'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'activeProgramId': instance.activeProgramId,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'photoUrl': instance.photoUrl,
      'isPremium': instance.isPremium,
    };
