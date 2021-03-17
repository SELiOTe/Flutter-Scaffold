import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class SmsLoginReq {
  // 国际电话呼叫码
  @JsonKey(name: "country_code")
  String countryCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  // 图形验证码
  @JsonKey(name: "captcha")
  String captcha;

  SmsLoginReq(this.countryCode, this.telNo, this.captcha);

  factory SmsLoginReq.fromJson(Map<String, dynamic> json) =>
      _$SmsLoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$SmsLoginReqToJson(this);
}

@JsonSerializable()
class SmsLoginResp {
  // 发送结果，0 为成功，-1 为未知原因失败，1 为图形验证码错误
  @JsonKey(name: "send_result")
  int sendResult;

  SmsLoginResp(this.sendResult);

  factory SmsLoginResp.fromJson(Map<String, dynamic> json) =>
      _$SmsLoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$SmsLoginRespToJson(this);
}
