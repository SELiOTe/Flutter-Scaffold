import 'package:json_annotation/json_annotation.dart';

import '../../l10n/l10n.dart';
import '../../main.dart';

part 'resp.g.dart';

/// 后台接口响应，不含实际数据
@JsonSerializable()
class Resp {
  // 响应状态码
  @JsonKey(name: "code")
  int code;

  // 响应状态码描述
  @JsonKey(name: "msg")
  String msg;

  Resp(this.code, this.msg);

  factory Resp.fromJson(Map<String, dynamic> json) => _$RespFromJson(json);

  Map<String, dynamic> toJson() => _$RespToJson(this);

  /// 判断该响应对应的请求是否成功
  ///
  /// return 成功返回 true，否则返回 false
  bool isSuccess() => code == 0;

  /// 判断接口响应是否为未授权
  ///
  /// return 未授权返回 true，否则返回 false
  bool isUnauthorized() => code == -1;

  /// 获取该请求的显示信息
  ///
  /// return 请求的前端显示信息
  String displayMsg() {
    var context = globalKey.currentContext;
    if (code == 0) {
      return FrLocalizations.of(context).backendStatusDisplaySuccess;
    } else if (code == -2000) {
      return FrLocalizations.of(context).backendStatusFrequent;
    } else if (code == -2) {
      return FrLocalizations.of(context).apiForbidden;
    } else if (code < 0) {
      return FrLocalizations.of(context).backendStatusDisplayError;
    } else {
      return FrLocalizations.of(context).backendStatusDisplayUnknown;
    }
  }
}

/// 后台接口响应对象基类
@JsonSerializable()
class RespObject extends Resp {
  // 响应数据
  @JsonKey(name: "data")
  Map<String, dynamic> data;

  RespObject(int code, String msg, this.data) : super(code, msg);

  factory RespObject.fromJson(Map<String, dynamic> json) =>
      _$RespObjectFromJson(json);

  Map<String, dynamic> toJson() => _$RespObjectToJson(this);
}

/// 后台接口响应列表基类
@JsonSerializable()
class RespArray extends Resp {
  // 响应数据
  @JsonKey(name: "data")
  List<dynamic> data;

  RespArray(int code, String msg, this.data) : super(code, msg);

  factory RespArray.fromJson(Map<String, dynamic> json) =>
      _$RespArrayFromJson(json);

  Map<String, dynamic> toJson() => _$RespArrayToJson(this);
}
