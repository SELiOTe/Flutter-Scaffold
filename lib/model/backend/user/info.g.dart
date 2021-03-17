// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoResp _$InfoRespFromJson(Map<String, dynamic> json) {
  return InfoResp(
    json['id'] as int,
    json['nickname'] as String,
    json['gender'] as int,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$InfoRespToJson(InfoResp instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
