import 'dart:async';
import 'dart:convert';
import 'package:fitting_room/model/backend/user/others_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/backend/resp.dart';
import '../l10n/l10n.dart';
import '../main.dart';
import '../util/const.dart';
import '../util/common.dart';
import '../page/login.dart';

// HTTP 请求中 Token 请求头 Key 值
const HTTP_TOKEN_KEY = "Authorization";

// 当前用户的 Token
String token;

/// POST 方式请求后端，自动携带 Token
///
/// param [uri] 后端接口 URI
/// param [reqBody] 请求体
/// param [timeout] 超时时长
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
///
/// return JSON 字符串
Future<String> _post(String uri, Object reqBody,
    {int timeout, BuildContext context}) async {
  debugPrint("Request $uri, body: ${json.encode(reqBody)}, timeout: $timeout, "
      "provide context: ${context == null ? false : true}");
  timeout = timeout ?? 5;
  Map<String, String> headers = {
    "Content-Type": "application/json",
    if (token != null) HTTP_TOKEN_KEY: token
  };
  var url = "${UrlConst.BASE_URL}$uri";
  http.Response resp;
  try {
    if (reqBody != null) {
      resp = await http
          .post(url, headers: headers, body: json.encode(reqBody))
          .timeout(Duration(seconds: timeout));
    } else {
      resp = await http
          .post(url, headers: headers)
          .timeout(Duration(seconds: timeout));
    }
  } on Exception catch (e) {
    debugPrint(
        "Occur exception: ${e.runtimeType.toString()}, msg: ${e.toString()}");
    // 服务器连接异常的 SocketException 以及超时的 TimeoutException
    if (context != null) {
      snackBar(context, FrLocalizations.of(context).backendStatusDisplayError);
    }
    return null;
  }
  return _handleResult(uri, resp, context: context);
}

/// POST 方式请求后端 data 字段为 JSON 对象的接口，自动携带 Token
///
/// param [uri] 后端接口 URI
/// param [reqBody] 请求体
/// param [timeout] 超时时长
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
///
/// return Resp 对象
Future<RespObject> postObject(String uri, Object reqBody,
    {int timeout, BuildContext context}) async {
  var resp = await _post(uri, reqBody, timeout: timeout, context: context);
  if (resp == null) {
    return null;
  }
  return RespObject.fromJson(json.decode(resp));
}

/// POST 方式请求后端 data 字段为 JSON 数组的接口，自动携带 Token
///
/// param [uri] 后端接口 URI
/// param [reqBody] 请求体
/// param [timeout] 超时时长
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
///
/// return Resp 对象
Future<RespArray> postArray(String uri, Object reqBody,
    {int timeout, BuildContext context}) async {
  var resp = await _post(uri, reqBody, timeout: timeout, context: context);
  if (resp == null) {
    return null;
  }
  return RespArray.fromJson(json.decode(resp));
}

/// 处理响应结果
///
/// param [resp] http.Response 响应对象
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
///
/// return Resp 对象
String _handleResult(String uri, http.Response resp, {BuildContext context}) {
  if (resp.statusCode != 200) {
    if (context != null) {
      snackBar(context, FrLocalizations.of(context).backendStatusDisplayError);
    }
    debugPrint("Response for $uri not success, status is: ${resp.statusCode}");
    return null;
  }
  var respModel = Resp.fromJson(json.decode(resp.body));
  if (!respModel.isSuccess()) {
    debugPrint("Response for $uri not success, code is: ${respModel.code}");
    if (respModel.isUnauthorized()) {
      if (context != null) {
        snackBar(context, FrLocalizations.of(context).reLoginText);
      }
      // 未登录或 Token 错误，跳到登录页
      Navigator.of(globalKey.currentContext)
          .pushNamedAndRemoveUntil(LOGIN_PAGE_NAME, (route) => false);
    }
    if (context != null) {
      snackBar(context, respModel.displayMsg());
    }
    return null;
  }
  debugPrint("Response for $uri: ${resp.body}");
  return resp.body;
}

Future<OthersInfoResp> getUserInfo(int userId) async {
  final uri = "user/others_info";
  var resp = await postObject(uri, OthersInfoReq(userId));
  return OthersInfoResp.fromJson(resp.data);
}

/// 颜色 ID 解析为文本
///
/// param [colorId] 颜色 ID
///
/// return 颜色文本，未知 ID 返回 null
String colorId2String(int colorId) {
  switch (colorId) {
    case 1:
      return FrLocalizations.of(globalKey.currentContext).productColorWhite;
    case 2:
      return FrLocalizations.of(globalKey.currentContext).productColorBlack;
    case 3:
      return FrLocalizations.of(globalKey.currentContext).productColorRed;
    case 4:
      return FrLocalizations.of(globalKey.currentContext).productColorOrange;
    case 5:
      return FrLocalizations.of(globalKey.currentContext).productColorYellow;
    case 6:
      return FrLocalizations.of(globalKey.currentContext).productColorGreen;
    case 7:
      return FrLocalizations.of(globalKey.currentContext).productColorBlue;
    case 8:
      return FrLocalizations.of(globalKey.currentContext).productColorPurple;
    case 9:
      return FrLocalizations.of(globalKey.currentContext).productColorPink;
    default:
      return null;
  }
}

String sizeId2String(int sizeId) {
  switch (sizeId) {
    case 1:
      return "150";
    case 2:
      return "155";
    case 3:
      return "160";
    case 4:
      return "165";
    case 5:
      return "170";
    case 6:
      return "175";
    case 7:
      return "180";
    case 8:
      return "185";
    case 9:
      return "190";
    case 10:
      return "195";
    case 11:
      return "200";
    default:
      return null;
  }
}
