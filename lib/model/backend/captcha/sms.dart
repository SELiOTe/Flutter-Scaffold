import 'package:json_annotation/json_annotation.dart';

part 'sms.g.dart';

@JsonSerializable()
class CaptchaSmsReq {
  // 国际电话呼叫码
  @JsonKey(name: "country_code")
  String countryCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  CaptchaSmsReq(this.countryCode, this.telNo);

  factory CaptchaSmsReq.fromJson(Map<String, dynamic> json) =>
      _$CaptchaSmsReqFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaSmsReqToJson(this);
}

@JsonSerializable()
class CaptchaSmsResp {
  // 图形验证码 Base 64 编码
  @JsonKey(name: "captcha")
  String captcha;

  CaptchaSmsResp(this.captcha);

  factory CaptchaSmsResp.fromJson(Map<String, dynamic> json) =>
      _$CaptchaSmsRespFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaSmsRespToJson(this);
}
