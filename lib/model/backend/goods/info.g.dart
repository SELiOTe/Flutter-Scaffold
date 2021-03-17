// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoReq _$InfoReqFromJson(Map<String, dynamic> json) {
  return InfoReq(
    json['id'] as int,
    json['jump_from'] as int,
  );
}

Map<String, dynamic> _$InfoReqToJson(InfoReq instance) => <String, dynamic>{
      'id': instance.id,
      'jump_from': instance.jumpFrom,
    };

InfoResp _$InfoRespFromJson(Map<String, dynamic> json) {
  return InfoResp(
    json['id'] as int,
    json['name'] as String,
    json['price'] as int,
    json['list_price_cal_method'] as int,
    (json['images'] as List)
        ?.map((e) => e == null
            ? null
            : InfoImageResp.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['skus'] as List)
        ?.map((e) =>
            e == null ? null : InfoSkuResp.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InfoRespToJson(InfoResp instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'list_price_cal_method': instance.listPriceMethod,
      'images': instance.images,
      'skus': instance.skus,
    };

InfoImageResp _$InfoImageRespFromJson(Map<String, dynamic> json) {
  return InfoImageResp(
    json['image'] as String,
    json['image_order'] as int,
  );
}

Map<String, dynamic> _$InfoImageRespToJson(InfoImageResp instance) =>
    <String, dynamic>{
      'image': instance.image,
      'image_order': instance.imageOrder,
    };

InfoSkuResp _$InfoSkuRespFromJson(Map<String, dynamic> json) {
  return InfoSkuResp(
    json['color_id'] as int,
    json['size_id'] as int,
    json['stock'] as int,
  );
}

Map<String, dynamic> _$InfoSkuRespToJson(InfoSkuResp instance) =>
    <String, dynamic>{
      'color_id': instance.colorId,
      'size_id': instance.sizeId,
      'stock': instance.stock,
    };
