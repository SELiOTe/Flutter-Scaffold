import 'package:json_annotation/json_annotation.dart';

part 'others_info_batch.g.dart';

/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/// 这两个为批处理接口，请求与响应均为 List<Type>
/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

@JsonSerializable()
class OthersInfoBatchReq {
  // 用户 ID
  @JsonKey(name: "id")
  int id;

  OthersInfoBatchReq(this.id);

  factory OthersInfoBatchReq.fromJson(Map<String, dynamic> json) =>
      _$OthersInfoBatchReqFromJson(json);

  Map<String, dynamic> toJson() => _$OthersInfoBatchReqToJson(this);
}

@JsonSerializable()
class OthersInfoBatchResp {
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

  OthersInfoBatchResp(this.id, this.nickname, this.gender, this.avatar);

  factory OthersInfoBatchResp.fromJson(Map<String, dynamic> json) =>
      _$OthersInfoBatchRespFromJson(json);

  Map<String, dynamic> toJson() => _$OthersInfoBatchRespToJson(this);
}
