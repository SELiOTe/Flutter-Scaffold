import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class UserLoginReq {
  // 国际电话呼叫码
  @JsonKey(name: "country_code")
  String countryCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  // 短信验证码
  @JsonKey(name: "verify_code")
  String verifyCode;

  UserLoginReq(this.countryCode, this.telNo, this.verifyCode);

  factory UserLoginReq.fromJson(Map<String, dynamic> json) =>
      _$UserLoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginReqToJson(this);
}

@JsonSerializable()
class UserLoginResp {
  // 登录结果，0 为登录成功且 Token 域必存在，其他为登录失败且 Token 域未知
  @JsonKey(name: "login_result")
  int loginResult;

  // 登录 Token
  @JsonKey(name: "token")
  String token;

  UserLoginResp(this.loginResult, this.token);

  factory UserLoginResp.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRespToJson(this);
}
