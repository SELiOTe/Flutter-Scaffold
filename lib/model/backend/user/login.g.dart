// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginReq _$UserLoginReqFromJson(Map<String, dynamic> json) {
  return UserLoginReq(
    json['country_code'] as String,
    json['tel_no'] as String,
    json['verify_code'] as String,
  );
}

Map<String, dynamic> _$UserLoginReqToJson(UserLoginReq instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'tel_no': instance.telNo,
      'verify_code': instance.verifyCode,
    };

UserLoginResp _$UserLoginRespFromJson(Map<String, dynamic> json) {
  return UserLoginResp(
    json['login_result'] as int,
    json['token'] as String,
  );
}

Map<String, dynamic> _$UserLoginRespToJson(UserLoginResp instance) =>
    <String, dynamic>{
      'login_result': instance.loginResult,
      'token': instance.token,
    };
