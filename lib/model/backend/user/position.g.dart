// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionReq _$PositionReqFromJson(Map<String, dynamic> json) {
  return PositionReq(
    (json['longitude'] as num)?.toDouble(),
    (json['latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PositionReqToJson(PositionReq instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
