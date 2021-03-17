import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class InfoResp {
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

  InfoResp(this.id, this.nickname, this.gender, this.avatar);

  factory InfoResp.fromJson(Map<String, dynamic> json) =>
      _$InfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$InfoRespToJson(this);
}
