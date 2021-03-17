// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'others_info_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OthersInfoBatchReq _$OthersInfoBatchReqFromJson(Map<String, dynamic> json) {
  return OthersInfoBatchReq(
    json['id'] as int,
  );
}

Map<String, dynamic> _$OthersInfoBatchReqToJson(OthersInfoBatchReq instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

OthersInfoBatchResp _$OthersInfoBatchRespFromJson(Map<String, dynamic> json) {
  return OthersInfoBatchResp(
    json['id'] as int,
    json['nickname'] as String,
    json['gender'] as int,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$OthersInfoBatchRespToJson(
        OthersInfoBatchResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
