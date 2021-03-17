import 'package:json_annotation/json_annotation.dart';

part 'others_info.g.dart';

@JsonSerializable()
class OthersInfoReq {
  // 用户 ID
  @JsonKey(name: "id")
  int id;

  OthersInfoReq(this.id);

  factory OthersInfoReq.fromJson(Map<String, dynamic> json) =>
      _$OthersInfoReqFromJson(json);

  Map<String, dynamic> toJson() => _$OthersInfoReqToJson(this);
}

@JsonSerializable()
class OthersInfoResp {
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

  OthersInfoResp(this.id, this.nickname, this.gender, this.avatar);

  factory OthersInfoResp.fromJson(Map<String, dynamic> json) =>
      _$OthersInfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$OthersInfoRespToJson(this);
}
