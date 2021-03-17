import 'package:json_annotation/json_annotation.dart';

part 'add.g.dart';

@JsonSerializable()
class AddReq {
  // 商品 ID
  @JsonKey(name: "goods_id")
  int goodsId;

  // 商品颜色 ID
  @JsonKey(name: "color_id")
  int colorId;

  // 商品尺码 ID
  @JsonKey(name: "size_id")
  int sizeId;

  AddReq(this.goodsId, this.colorId, this.sizeId);

  factory AddReq.fromJson(Map<String, dynamic> json) => _$AddReqFromJson(json);

  Map<String, dynamic> toJson() => _$AddReqToJson(this);
}

@JsonSerializable()
class AddResp {
  // 添加状态，0 为成功，1 为商品不存在
  @JsonKey(name: "status")
  int status;

  AddResp(this.status);

  factory AddResp.fromJson(Map<String, dynamic> json) =>
      _$AddRespFromJson(json);

  Map<String, dynamic> toJson() => _$AddRespToJson(this);
}
