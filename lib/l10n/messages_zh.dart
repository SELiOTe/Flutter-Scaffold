// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static m0(howMany) => "${howMany} 天前";

  static m1(howMany) => "评价（${howMany} 条）";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "apiForbidden" : MessageLookupByLibrary.simpleMessage("禁止访问"),
    "backendStatusDisplayError" : MessageLookupByLibrary.simpleMessage("服务器错误"),
    "backendStatusDisplaySuccess" : MessageLookupByLibrary.simpleMessage("成功"),
    "backendStatusDisplayUnknown" : MessageLookupByLibrary.simpleMessage("未知状态"),
    "backendStatusFrequent" : MessageLookupByLibrary.simpleMessage("操作频率过高"),
    "cancelButtonText" : MessageLookupByLibrary.simpleMessage("取消"),
    "captchaCodeFormatError" : MessageLookupByLibrary.simpleMessage("图形验证码格式错误"),
    "confirmButtonText" : MessageLookupByLibrary.simpleMessage("确认"),
    "cropAvatarPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("裁剪"),
    "homeDealerBottomBarText" : MessageLookupByLibrary.simpleMessage("经销商"),
    "homeMarketBottomBarText" : MessageLookupByLibrary.simpleMessage("商场"),
    "homeMineBottomBarText" : MessageLookupByLibrary.simpleMessage("我"),
    "homeMineMenuOnlneService" : MessageLookupByLibrary.simpleMessage("在线客服"),
    "homeMineMenuOrder" : MessageLookupByLibrary.simpleMessage("订单"),
    "homeMineMenuSetting" : MessageLookupByLibrary.simpleMessage("设置"),
    "homeScanQrCodeFailed" : MessageLookupByLibrary.simpleMessage("二维码扫描失败"),
    "loginCaptchaDialogTitle" : MessageLookupByLibrary.simpleMessage("图形验证码"),
    "loginCaptchaError" : MessageLookupByLibrary.simpleMessage("图形验证码错误，请重试"),
    "loginNewCaptchaButtonText" : MessageLookupByLibrary.simpleMessage("换一张？"),
    "loginSmsSendFailed" : MessageLookupByLibrary.simpleMessage("验证码发送失败"),
    "loginSmsSendSuccess" : MessageLookupByLibrary.simpleMessage("验证码发送成功"),
    "loginSubmitButton" : MessageLookupByLibrary.simpleMessage("登录"),
    "loginTelLabel" : MessageLookupByLibrary.simpleMessage("手机号码"),
    "loginVerifyCodeButton" : MessageLookupByLibrary.simpleMessage("获取"),
    "loginVerifyCodeError" : MessageLookupByLibrary.simpleMessage("短信验证码错误"),
    "loginVerifyCodeLabel" : MessageLookupByLibrary.simpleMessage("验证码"),
    "modifyAvatarAppBarTitle" : MessageLookupByLibrary.simpleMessage("修改头像"),
    "modifyAvatarModifyButton" : MessageLookupByLibrary.simpleMessage("修改"),
    "modifyInfoAppBarTitle" : MessageLookupByLibrary.simpleMessage("个人信息"),
    "modifyInfoGender" : MessageLookupByLibrary.simpleMessage("性别"),
    "modifyInfoGenderFemale" : MessageLookupByLibrary.simpleMessage("女"),
    "modifyInfoGenderIncorrect" : MessageLookupByLibrary.simpleMessage("性别格式不正确"),
    "modifyInfoGenderMale" : MessageLookupByLibrary.simpleMessage("男"),
    "modifyInfoGenderUnknown" : MessageLookupByLibrary.simpleMessage("未设置"),
    "modifyInfoImgTooBig" : MessageLookupByLibrary.simpleMessage("所选头像过大"),
    "modifyInfoImgTooSmall" : MessageLookupByLibrary.simpleMessage("所选头像过小"),
    "modifyInfoNickname" : MessageLookupByLibrary.simpleMessage("昵称"),
    "modifyInfoNicknameIncorrect" : MessageLookupByLibrary.simpleMessage("昵称格式不正确"),
    "moneySymbol" : MessageLookupByLibrary.simpleMessage("￥"),
    "none" : MessageLookupByLibrary.simpleMessage("无"),
    "productAddToCartFailed" : MessageLookupByLibrary.simpleMessage("添加至购物车失败"),
    "productAddToCartNotSelect" : MessageLookupByLibrary.simpleMessage("请先选择商品规格后再添加"),
    "productAddToCartSuccess" : MessageLookupByLibrary.simpleMessage("添加成功"),
    "productAddToCartText" : MessageLookupByLibrary.simpleMessage("加入购物车"),
    "productBuyNowText" : MessageLookupByLibrary.simpleMessage("立即购买"),
    "productColorBlack" : MessageLookupByLibrary.simpleMessage("黑色"),
    "productColorBlue" : MessageLookupByLibrary.simpleMessage("蓝色"),
    "productColorGreen" : MessageLookupByLibrary.simpleMessage("绿色"),
    "productColorOrange" : MessageLookupByLibrary.simpleMessage("橙色"),
    "productColorPink" : MessageLookupByLibrary.simpleMessage("粉色"),
    "productColorPrompt" : MessageLookupByLibrary.simpleMessage("颜色"),
    "productColorPurple" : MessageLookupByLibrary.simpleMessage("紫色"),
    "productColorRed" : MessageLookupByLibrary.simpleMessage("红色"),
    "productColorWhite" : MessageLookupByLibrary.simpleMessage("白色"),
    "productColorYellow" : MessageLookupByLibrary.simpleMessage("黄色"),
    "productCommentHowManyDaysAgo" : m0,
    "productCommentLoading" : MessageLookupByLibrary.simpleMessage("加载中"),
    "productCommentNoComment" : MessageLookupByLibrary.simpleMessage("暂无评论"),
    "productCommentNoMore" : MessageLookupByLibrary.simpleMessage("没有更多了"),
    "productCommentTitle" : m1,
    "productDealerWillEarn" : MessageLookupByLibrary.simpleMessage("经销商可获得："),
    "productSelecting" : MessageLookupByLibrary.simpleMessage("已选："),
    "productSizePrompt" : MessageLookupByLibrary.simpleMessage("尺码"),
    "productStockPrompt" : MessageLookupByLibrary.simpleMessage("库存"),
    "reLoginText" : MessageLookupByLibrary.simpleMessage("请重新登录"),
    "saveButton" : MessageLookupByLibrary.simpleMessage("保存"),
    "saveFailedPrompt" : MessageLookupByLibrary.simpleMessage("保存失败"),
    "saveSuccessPrompt" : MessageLookupByLibrary.simpleMessage("保存成功"),
    "scanAppBarTitle" : MessageLookupByLibrary.simpleMessage("扫描二维码"),
    "settingAppBarTitle" : MessageLookupByLibrary.simpleMessage("设置"),
    "settingClearCache" : MessageLookupByLibrary.simpleMessage("清空缓存"),
    "settingClearCacheSuccess" : MessageLookupByLibrary.simpleMessage("清空缓存成功"),
    "settingLogout" : MessageLookupByLibrary.simpleMessage("退出登录"),
    "settingVersion" : MessageLookupByLibrary.simpleMessage("版本"),
    "telNoFormatError" : MessageLookupByLibrary.simpleMessage("手机号码格式错误"),
    "title" : MessageLookupByLibrary.simpleMessage("试衣间"),
    "unknown" : MessageLookupByLibrary.simpleMessage("未知"),
    "unsavePrompt" : MessageLookupByLibrary.simpleMessage("未保存"),
    "verifyCodeFormatError" : MessageLookupByLibrary.simpleMessage("短信验证码格式错误")
  };
}
