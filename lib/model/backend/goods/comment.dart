import 'package:json_annotation/json_annotation.dart';

import '../page.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentReq extends SortablePageReq {
  // 商品 ID
  @JsonKey(name: "id")
  int id;

  CommentReq(int pageNumber, int pageSize, int orderBy, this.id)
      : super(pageNumber, pageSize, orderBy);

  factory CommentReq.fromJson(Map<String, dynamic> json) =>
      _$CommentReqFromJson(json);

  Map<String, dynamic> toJson() => _$CommentReqToJson(this);
}

@JsonSerializable()
class CommentResp {
  // 用户 ID
  @JsonKey(name: "user_id")
  int userId;

  // 用户评论创建时间
  @JsonKey(name: "created_at")
  double createdAt;

  // 用户评论文本
  @JsonKey(name: "text")
  String text;

  // 商品评论图片列表
  @JsonKey(name: "images")
  List<Map<String, dynamic>> images;

  CommentResp(this.userId, this.createdAt, this.text, this.images);

  factory CommentResp.fromJson(Map<String, dynamic> json) =>
      _$CommentRespFromJson(json);

  Map<String, dynamic> toJson() => _$CommentRespToJson(this);
}

@JsonSerializable()
class CommentImageResp {
  // 图片 SHA1
  @JsonKey(name: "image")
  String image;

  // 商品评论图片排序
  @JsonKey(name: "image_order")
  int imageOrder;

  CommentImageResp(this.image, this.imageOrder);

  factory CommentImageResp.fromJson(Map<String, dynamic> json) =>
      _$CommentImageRespFromJson(json);

  Map<String, dynamic> toJson() => _$CommentImageRespToJson(this);
}
