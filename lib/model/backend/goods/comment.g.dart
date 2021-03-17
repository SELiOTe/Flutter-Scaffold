// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReq _$CommentReqFromJson(Map<String, dynamic> json) {
  return CommentReq(
    json['page_number'] as int,
    json['page_size'] as int,
    json['order_by'] as int,
    json['id'] as int,
  );
}

Map<String, dynamic> _$CommentReqToJson(CommentReq instance) =>
    <String, dynamic>{
      'page_number': instance.pageNumber,
      'page_size': instance.pageSize,
      'order_by': instance.orderBy,
      'id': instance.id,
    };

CommentResp _$CommentRespFromJson(Map<String, dynamic> json) {
  return CommentResp(
    json['user_id'] as int,
    (json['created_at'] as num)?.toDouble(),
    json['text'] as String,
    (json['images'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$CommentRespToJson(CommentResp instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'text': instance.text,
      'images': instance.images,
    };

CommentImageResp _$CommentImageRespFromJson(Map<String, dynamic> json) {
  return CommentImageResp(
    json['image'] as String,
    json['image_order'] as int,
  );
}

Map<String, dynamic> _$CommentImageRespToJson(CommentImageResp instance) =>
    <String, dynamic>{
      'image': instance.image,
      'image_order': instance.imageOrder,
    };
