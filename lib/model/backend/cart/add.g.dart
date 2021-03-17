// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReq _$AddReqFromJson(Map<String, dynamic> json) {
  return AddReq(
    json['goods_id'] as int,
    json['color_id'] as int,
    json['size_id'] as int,
  );
}

Map<String, dynamic> _$AddReqToJson(AddReq instance) => <String, dynamic>{
      'goods_id': instance.goodsId,
      'color_id': instance.colorId,
      'size_id': instance.sizeId,
    };

AddResp _$AddRespFromJson(Map<String, dynamic> json) {
  return AddResp(
    json['status'] as int,
  );
}

Map<String, dynamic> _$AddRespToJson(AddResp instance) => <String, dynamic>{
      'status': instance.status,
    };
