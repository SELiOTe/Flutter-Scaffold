// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'others_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OthersInfoReq _$OthersInfoReqFromJson(Map<String, dynamic> json) {
  return OthersInfoReq(
    json['id'] as int,
  );
}

Map<String, dynamic> _$OthersInfoReqToJson(OthersInfoReq instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

OthersInfoResp _$OthersInfoRespFromJson(Map<String, dynamic> json) {
  return OthersInfoResp(
    json['id'] as int,
    json['nickname'] as String,
    json['gender'] as int,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$OthersInfoRespToJson(OthersInfoResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
