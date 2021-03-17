import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// 检查手机号码格式
///
/// param [telNo] 手机号码
///
/// return 校验成功返回 true，否则返回 false
bool checkTelNo(String telNo) {
  if (telNo == null) return false;
  var regExp = RegExp(r"^1\d{10}$");
  return regExp.hasMatch(telNo);
}

/// 检查国际电话呼叫码格式
///
/// param [countryCode] 国际电话呼叫码
///
/// return 校验成功返回 true，否则返回 false
bool checkCountryCode(String countryCode) {
  if (countryCode == null) return false;
  var regExp = RegExp(r"^86$");
  return regExp.hasMatch(countryCode);
}

/// 检查图片验证码格式
///
/// param [captchaCode] 图片验证码
///
/// return 校验成功返回 true，否则返回 false
bool checkCaptchaCode(String captchaCode) {
  if (captchaCode == null) return false;
  var regExp = RegExp(r"^\w{4}$");
  return regExp.hasMatch(captchaCode);
}

/// 检查短信验证码格式
///
/// param [verifyCode] 短信验证码
///
/// return 校验成功返回 true，否则返回 false
bool checkVerifyCode(String verifyCode) {
  if (verifyCode == null) return false;
  var regExp = RegExp(r"^\d{6}$");
  return regExp.hasMatch(verifyCode);
}

/// 检查用户昵称格式
///
/// param [nickname] 用户昵称
///
/// return 校验成功返回 true，否则返回 false
bool checkNickname(String nickname) {
  if (nickname == null) return false;
  var regExp = RegExp(r"^[^\s]{1,16}$");
  return regExp.hasMatch(nickname);
}

/// 检查用户性别格式
///
/// param [gender] 用户昵称
///
/// return 校验成功返回 true，否则返回 false
bool checkGender(int gender) {
  if (gender == null) return false;
  return [0, 1, 2].contains(gender);
}

/// Base 64 编码的图片转 Image Widget
///
/// param [base64] Base 64 编码的字符
/// param [width] Image Widget 宽
/// param [height] Image Widget 高
/// param [fit] Image Widget 缩放方式
///
/// return Image Widget
Image base64ToImg(String base64, {double width, double height, BoxFit fit}) {
  var captchaBytes = Base64Decoder().convert(base64);
  return Image.memory(
    captchaBytes,
    width: width,
    height: height,
    fit: fit,
  );
}

/// Base 64 解码
///
/// param [base64] Base 64 编码的字符
///
/// return 解码后的 Uint8List
Uint8List base64Decode(String base64) {
  if (base64 == null) {
    return null;
  }
  return Base64Decoder().convert(base64);
}

/// Base 64 编码
///
/// param [base64] 需要解码的 Uint8List
///
/// return Base 64 编码的字符
String base64Encode(Uint8List bytes) {
  if (bytes == null) {
    return null;
  }
  return Base64Encoder().convert(bytes);
}

/// Bits 单位转换
///
/// param [bits] 位数
///
/// return 最小可用单位字符串
String bitsUnitConvert(int bits) {
  var value = bits / 8;
  var unit = 0;
  for (; value > 1024; value /= 1024.0) {
    ++unit;
  }
  return value.toStringAsFixed(1) +
      [" B", " kB", " MB", " GB", " TB", " PB", "EB"][unit];
}

/// 时间戳转 DateTime
///
/// param [timestamp]时间戳，单位为秒，可为 double
///
/// return DateTime 对象
DateTime timestamp2DateTime(double timestamp) {
  return DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
}

/// 应用自定义 Icon
class FrIcons {
  // 男
  static const IconData male =
      const IconData(0xe69b, fontFamily: "frIcon", matchTextDirection: true);

  // 女
  static const IconData female =
      const IconData(0xe65d, fontFamily: "frIcon", matchTextDirection: true);
}
