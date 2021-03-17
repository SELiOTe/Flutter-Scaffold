// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsLoginReq _$SmsLoginReqFromJson(Map<String, dynamic> json) {
  return SmsLoginReq(
    json['country_code'] as String,
    json['tel_no'] as String,
    json['captcha'] as String,
  );
}

Map<String, dynamic> _$SmsLoginReqToJson(SmsLoginReq instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'tel_no': instance.telNo,
      'captcha': instance.captcha,
    };

SmsLoginResp _$SmsLoginRespFromJson(Map<String, dynamic> json) {
  return SmsLoginResp(
    json['send_result'] as int,
  );
}

Map<String, dynamic> _$SmsLoginRespToJson(SmsLoginResp instance) =>
    <String, dynamic>{
      'send_result': instance.sendResult,
    };
