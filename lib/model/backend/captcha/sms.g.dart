// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaSmsReq _$CaptchaSmsReqFromJson(Map<String, dynamic> json) {
  return CaptchaSmsReq(
    json['country_code'] as String,
    json['tel_no'] as String,
  );
}

Map<String, dynamic> _$CaptchaSmsReqToJson(CaptchaSmsReq instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'tel_no': instance.telNo,
    };

CaptchaSmsResp _$CaptchaSmsRespFromJson(Map<String, dynamic> json) {
  return CaptchaSmsResp(
    json['captcha'] as String,
  );
}

Map<String, dynamic> _$CaptchaSmsRespToJson(CaptchaSmsResp instance) =>
    <String, dynamic>{
      'captcha': instance.captcha,
    };
