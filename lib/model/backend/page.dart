import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

// Dart JSON 反序列化会创建实例，生成的 Model 里会直接引用
// 这里无法做抽象类
@JsonSerializable()
class PageReq {
  // 页码，从 1 开始
  @JsonKey(name: "page_number")
  int pageNumber;

  // 页大小
  // 最小为 1 最大为 500
  @JsonKey(name: "page_size")
  int pageSize;

  PageReq(this.pageNumber, this.pageSize);

  factory PageReq.fromJson(Map<String, dynamic> json) =>
      _$PageReqFromJson(json);

  Map<String, dynamic> toJson() => _$PageReqToJson(this);
}

@JsonSerializable()
class SortablePageReq extends PageReq {
  // 排序方式，各接口中预先定义，SQL 中进行 switch 选择，接口中会进行校验
  // 传输错误数值时接口将返回 order by 异常
  @JsonKey(name: "order_by")
  int orderBy;

  SortablePageReq(int pageNumber, int pageSize, this.orderBy)
      : super(pageNumber, pageSize);

  factory SortablePageReq.fromJson(Map<String, dynamic> json) =>
      _$SortablePageReqFromJson(json);

  Map<String, dynamic> toJson() => _$SortablePageReqToJson(this);
}

@JsonSerializable()
class PageResp {
  // 页码，从 1 开始
  @JsonKey(name: "page_number")
  int pageNumber;

  // 页大小
  // 最小为 1 最大为 500
  @JsonKey(name: "page_size")
  int pageSize;

  // 总数据量
  @JsonKey(name: "total_count")
  int totalCount;

  // 实际页数据
  // 这里实际上只是一个对象，但是得用 Map 来接类型
  @JsonKey(name: "page")
  List<Map<String, dynamic>> page;

  PageResp(this.pageNumber, this.pageSize, this.totalCount);

  factory PageResp.fromJson(Map<String, dynamic> json) =>
      _$PageRespFromJson(json);

  Map<String, dynamic> toJson() => _$PageRespToJson(this);

  /// 获取总页数
  int get totalPage => (totalCount / pageSize).ceil();
}
