import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class PositionReq {
  // 经度
  @JsonKey(name: "longitude")
  double longitude;

  // 纬度
  @JsonKey(name: "latitude")
  double latitude;

  PositionReq(this.longitude, this.latitude);

  factory PositionReq.fromJson(Map<String, dynamic> json) =>
      _$PositionReqFromJson(json);

  Map<String, dynamic> toJson() => _$PositionReqToJson(this);
}
