import 'package:json_annotation/json_annotation.dart';

part 'update_info.g.dart';

@JsonSerializable()
class UpdateInfoReq {
  // 用户头像 Base 64
  @JsonKey(name: "avatar")
  String avatar;

  // 用户昵称
  @JsonKey(name: "nickname")
  String nickname;

  // 用户头像 Base 64
  @JsonKey(name: "gender")
  int gender;

  UpdateInfoReq(this.avatar, this.nickname, this.gender);

  factory UpdateInfoReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoReqFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInfoReqToJson(this);
}

@JsonSerializable()
class UpdateInfoResp {
  // 用户 ID
  @JsonKey(name: "id")
  int id;

  // 用户昵称
  @JsonKey(name: "nickname")
  String nickname;

  // 性别
  @JsonKey(name: "gender")
  int gender;

  // 用户头像文件 SHA1
  @JsonKey(name: "avatar")
  String avatar;

  UpdateInfoResp(this.id, this.nickname, this.gender, this.avatar);

  factory UpdateInfoResp.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInfoRespToJson(this);
}
