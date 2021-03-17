// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInfoReq _$UpdateInfoReqFromJson(Map<String, dynamic> json) {
  return UpdateInfoReq(
    json['avatar'] as String,
    json['nickname'] as String,
    json['gender'] as int,
  );
}

Map<String, dynamic> _$UpdateInfoReqToJson(UpdateInfoReq instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'gender': instance.gender,
    };

UpdateInfoResp _$UpdateInfoRespFromJson(Map<String, dynamic> json) {
  return UpdateInfoResp(
    json['id'] as int,
    json['nickname'] as String,
    json['gender'] as int,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$UpdateInfoRespToJson(UpdateInfoResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
