import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'const.dart';

/// 显示 SnackBar
///
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
/// param [text] 要显示的文本
void snackBar(BuildContext context, String text) {
  debugPrint("Show snackbar $text");
  var state = Scaffold.of(context);
  // 立即移除当前的 SnackBar
  state.removeCurrentSnackBar();
  state.showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 3000),
  ));
}

/// 获取当前定位
///
/// return Future<Position> 对象
///        获取失败时 error 为 1 表示定位服务未开启
Future<Position> determinePosition() async {
  debugPrint("Determine position");
  var serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error(1);
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(2);
    }
    if (permission == LocationPermission.denied) {
      return Future.error(3);
    }
  }
  return await Geolocator.getCurrentPosition();
}

CachedNetworkImage getCachedNetworkImage(String sha1,
    {double width, double height, BoxFit fit}) {
  return CachedNetworkImage(
      imageUrl: sha1ToImgUrl(sha1),
      width: width,
      height: height,
      fit: fit,
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error));
}

String sha1ToImgUrl(String sha1) {
  return "${UrlConst.IMG_URL}${sha1.substring(0, 1)}/${sha1.substring(1, 2)}/$sha1";
}

Widget dividerWidget({double horizontal, double vertical}) {
  return SizedBox(
    width: horizontal ?? 0,
    height: vertical ?? 0,
  );
}
