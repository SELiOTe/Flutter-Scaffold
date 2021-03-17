import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class InfoReq {
  // 商品 ID
  @JsonKey(name: "id")
  int id;

  // 跳转来源，即从哪里点击获取商品信息页的
  @JsonKey(name: "jump_from")
  int jumpFrom;

  InfoReq(this.id, this.jumpFrom);

  factory InfoReq.fromJson(Map<String, dynamic> json) =>
      _$InfoReqFromJson(json);

  Map<String, dynamic> toJson() => _$InfoReqToJson(this);
}

@JsonSerializable()
class InfoResp {
  // 商品 ID
  @JsonKey(name: "id")
  int id;

  // 商品名称
  @JsonKey(name: "name")
  String name;

  // 商品出厂价，单位为分
  @JsonKey(name: "price")
  int price;

  // 商品售价计算方式
  @JsonKey(name: "list_price_cal_method")
  int listPriceMethod;

  // 商品图片
  @JsonKey(name: "images")
  List<InfoImageResp> images;

  // 商品 SKU
  @JsonKey(name: "skus")
  List<InfoSkuResp> skus;

  InfoResp(this.id, this.name, this.price, this.listPriceMethod, this.images,
      this.skus);

  factory InfoResp.fromJson(Map<String, dynamic> json) =>
      _$InfoRespFromJson(json);

  Map<String, dynamic> toJson() => _$InfoRespToJson(this);
}

@JsonSerializable()
class InfoImageResp {
  // 商品图片 SHA1
  @JsonKey(name: "image")
  String image;

  // 商品图片顺序
  @JsonKey(name: "image_order")
  int imageOrder;

  InfoImageResp(this.image, this.imageOrder);

  factory InfoImageResp.fromJson(Map<String, dynamic> json) =>
      _$InfoImageRespFromJson(json);

  Map<String, dynamic> toJson() => _$InfoImageRespToJson(this);
}

@JsonSerializable()
class InfoSkuResp {
  // 商品颜色 ID
  @JsonKey(name: "color_id")
  int colorId;

  // 商品尺码 ID
  @JsonKey(name: "size_id")
  int sizeId;

  // 商品库存
  @JsonKey(name: "stock")
  int stock;

  InfoSkuResp(this.colorId, this.sizeId, this.stock);

  factory InfoSkuResp.fromJson(Map<String, dynamic> json) =>
      _$InfoSkuRespFromJson(json);

  Map<String, dynamic> toJson() => _$InfoSkuRespToJson(this);
}
