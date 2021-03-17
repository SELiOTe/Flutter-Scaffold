// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageReq _$PageReqFromJson(Map<String, dynamic> json) {
  return PageReq(
    json['page_number'] as int,
    json['page_size'] as int,
  );
}

Map<String, dynamic> _$PageReqToJson(PageReq instance) => <String, dynamic>{
      'page_number': instance.pageNumber,
      'page_size': instance.pageSize,
    };

SortablePageReq _$SortablePageReqFromJson(Map<String, dynamic> json) {
  return SortablePageReq(
    json['page_number'] as int,
    json['page_size'] as int,
    json['order_by'] as int,
  );
}

Map<String, dynamic> _$SortablePageReqToJson(SortablePageReq instance) =>
    <String, dynamic>{
      'page_number': instance.pageNumber,
      'page_size': instance.pageSize,
      'order_by': instance.orderBy,
    };

PageResp _$PageRespFromJson(Map<String, dynamic> json) {
  return PageResp(
    json['page_number'] as int,
    json['page_size'] as int,
    json['total_count'] as int,
  )..page =
      (json['page'] as List)?.map((e) => e as Map<String, dynamic>)?.toList();
}

Map<String, dynamic> _$PageRespToJson(PageResp instance) => <String, dynamic>{
      'page_number': instance.pageNumber,
      'page_size': instance.pageSize,
      'total_count': instance.totalCount,
      'page': instance.page,
    };
