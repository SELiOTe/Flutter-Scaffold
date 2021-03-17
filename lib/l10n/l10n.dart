import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

/// 应用本地化工具
/// 修改该 dart 文件后需要执行 [预构建脚本](script/prebuild.sh)

/// Fitting Room [LocalizationsDelegate] 工具类
class FrLocalizationsDelegate extends LocalizationsDelegate<FrLocalizations> {
  static const SUPPORT_LOCALES = ["en", "zh"];

  const FrLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      SUPPORT_LOCALES.contains(locale.languageCode);

  @override
  Future<FrLocalizations> load(Locale locale) => FrLocalizations.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<FrLocalizations> old) =>
      false;
}

/// Fitting Room Localizations 工具类
class FrLocalizations {
  static Future<FrLocalizations> load(Locale locale) {
    final name = Intl.canonicalizedLocale(
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString());
    return initializeMessages(name).then((locale) {
      Intl.defaultLocale = name;
      return FrLocalizations();
    });
  }

  static FrLocalizations of(BuildContext buildContext) {
    return Localizations.of<FrLocalizations>(buildContext, FrLocalizations);
  }

  String get title =>
      Intl.message("Fitting Room", name: "title", desc: "Application title");

  String get loginTelLabel => Intl.message("Telephone Number",
      name: "loginTelLabel",
      desc: "Login page telephone number field label text");

  String get loginVerifyCodeLabel => Intl.message("Verify Code",
      name: "loginVerifyCodeLabel",
      desc: "Login page verify code field label text");

  String get loginVerifyCodeButton => Intl.message("Get",
      name: "loginVerifyCodeButton",
      desc: "Login page get verify code field button text");

  String get loginSubmitButton => Intl.message("Login",
      name: "loginSubmitButton", desc: "Login page login button text");

  String get backendStatusDisplaySuccess => Intl.message("Success",
      name: "backendStatusDisplaySuccess",
      desc: "Backend response status display message for success");

  String get backendStatusDisplayError => Intl.message("Server error",
      name: "backendStatusDisplayError",
      desc: "Backend response status display message for error");

  String get backendStatusFrequent => Intl.message("Too frequent",
      name: "backendStatusFrequent", desc: "Backend API request frequent");

  String get backendStatusDisplayUnknown => Intl.message("Unknown status",
      name: "backendStatusDisplayUnknown",
      desc: "Backend response status display message for unknow");

  String get confirmButtonText => Intl.message("Confirm",
      name: "confirmButtonText", desc: "Confirm button text");

  String get telNoFormatError =>
      Intl.message("Telephone number format incorrect",
          name: "telNoFormatError",
          desc: "Telephone number format error promat text");

  String get loginNewCaptchaButtonText => Intl.message("New One?",
      name: "loginNewCaptchaButtonText",
      desc: "Login page request new one captcha button text");

  String get loginCaptchaDialogTitle => Intl.message("Captcha",
      name: "loginCaptchaDialogTitle", desc: "Login page captcha dialog title");

  String get loginSmsSendSuccess => Intl.message("Verify code send success",
      name: "loginSmsSendSuccess", desc: "Login page sms send success text");

  String get loginSmsSendFailed => Intl.message("Verify code send failed",
      name: "loginSmsSendFailed", desc: "Login page sms send field text");

  String get loginCaptchaError => Intl.message("Captcha error, try again",
      name: "loginCaptchaError",
      desc: "Login page captcha input error, try again");

  String get reLoginText => Intl.message("Please relogin",
      name: "reLoginText", desc: "Unauthorized for API, tell user relogin");

  String get apiForbidden => Intl.message("Forbidden",
      name: "apiForbidden", desc: "API return 403 forbidden");

  String get verifyCodeFormatError =>
      Intl.message("Verify code format incorrect",
          name: "verifyCodeFormatError",
          desc: "Verify code format error promat text");

  String get captchaCodeFormatError =>
      Intl.message("Captcha code format incorrect",
          name: "captchaCodeFormatError",
          desc: "Captcha code format error promat text");

  String get loginVerifyCodeError => Intl.message("Verify code error",
      name: "loginVerifyCodeError",
      desc: "Login verify code not match server send");

  String get homeMarketBottomBarText => Intl.message("Market",
      name: "homeMarketBottomBarText",
      desc: "Home page bottom bar market text");

  String get homeDealerBottomBarText => Intl.message("Dealer",
      name: "homeDealerBottomBarText",
      desc: "Home page bottom bar dealer text");

  String get homeMineBottomBarText => Intl.message("Mine",
      name: "homeMineBottomBarText", desc: "Home page bottom bar mine text");

  String get cancelButtonText => Intl.message("Cancel",
      name: "cancelButtonText", desc: "Cancel button text");

  String get homeScanQrCodeFailed => Intl.message("Faild to scan QR Code",
      name: "homeScanQrCodeFailed", desc: "Home page scan QR code failed text");

  String get scanAppBarTitle => Intl.message("Scan QR",
      name: "scanAppBarTitle", desc: "Scan page app bar title");

  String get homeMineMenuOnlneService => Intl.message("Online Service",
      name: "homeMineMenuOnlneService",
      desc: "Home mine Online service menu title");

  String get homeMineMenuSetting => Intl.message("Settings",
      name: "homeMineMenuSetting", desc: "Home mine setting menu title");

  String get modifyInfoAppBarTitle => Intl.message("Modify Info",
      name: "modifyInfoAppBarTitle",
      desc: "Modify information page app bar title");

  String get modifyInfoNickname => Intl.message("Nickname",
      name: "modifyInfoNickname",
      desc: "Modify information page nickname field");

  String get modifyInfoGender => Intl.message("Gender",
      name: "modifyInfoGender", desc: "Modify information page gender field");

  String get modifyInfoGenderMale => Intl.message("Male",
      name: "modifyInfoGenderMale",
      desc: "Modify information page gender male");

  String get modifyInfoGenderFemale => Intl.message("Female",
      name: "modifyInfoGenderFemale",
      desc: "Modify information page gender famale");

  String get modifyInfoGenderUnknown => Intl.message("Unset",
      name: "modifyInfoGenderUnknown",
      desc: "Modify information page gender unknown");

  String get saveButton =>
      Intl.message("Save", name: "saveButton", desc: "Save button text");

  String get modifyAvatarAppBarTitle => Intl.message("Modify Avatar",
      name: "modifyAvatarAppBarTitle",
      desc: "Modify avatar page app bar title");

  String get modifyAvatarModifyButton => Intl.message("Modify",
      name: "modifyAvatarModifyButton",
      desc: "Modify avatar page modify button text");

  String get cropAvatarPageAppBarTitle => Intl.message("Crop",
      name: "cropAvatarPageAppBarTitle",
      desc: "Crop avatar page app bar title");

  String get modifyInfoImgTooSmall => Intl.message("Select avatar is too small",
      name: "modifyInfoImgTooSmall",
      desc: "Modify infomation page select avatar is too small");

  String get modifyInfoImgTooBig => Intl.message("Select avatar is too big",
      name: "modifyInfoImgTooBig",
      desc: "Modify infomation page select avatar is too big");

  String get modifyInfoNicknameIncorrect =>
      Intl.message("Nickname pattern incorrect",
          name: "modifyInfoNicknameIncorrect",
          desc: "Modify infomation page nickname pattern incorrect");

  String get modifyInfoGenderIncorrect =>
      Intl.message("Gender pattern incorrect",
          name: "modifyInfoGenderIncorrect",
          desc: "Modify infomation page gender pattern incorrect");

  String get saveSuccessPrompt => Intl.message("Save success",
      name: "saveSuccessPrompt", desc: "Sava success snack bar prompt text");

  String get unsavePrompt => Intl.message("Unsaved",
      name: "unsavePrompt", desc: "Unsave snack bar prompt text");

  String get saveFailedPrompt => Intl.message("Save failed",
      name: "saveFailedPrompt", desc: "Sava failed snack bar prompt text");

  String get settingAppBarTitle => Intl.message("Settings",
      name: "settingAppBarTitle", desc: "Setting page app bar title");

  String get settingClearCache => Intl.message("Clear cache",
      name: "settingClearCache", desc: "Setting page clear cache menu name");

  String get settingVersion => Intl.message("Version",
      name: "settingVersion", desc: "Setting page version menu name");

  String get settingLogout => Intl.message("Logout",
      name: "settingLogout", desc: "Setting page logout menu name");

  String get settingClearCacheSuccess => Intl.message("Clear cache success",
      name: "settingClearCacheSuccess",
      desc: "Setting page clear cache success prompt");

  String get homeMineMenuOrder => Intl.message("Order",
      name: "homeMineMenuOrder", desc: "Home mine order menu title");

  String get moneySymbol =>
      Intl.message(r"$", name: "moneySymbol", desc: "Money symbol");

  String get productDealerWillEarn => Intl.message("Dealer will earn: ",
      name: "productDealerWillEarn",
      desc: "Product page dealer will earn prompt");

  String get productSelecting => Intl.message("Selecting: ",
      name: "productSelecting", desc: "Product page selecting");

  String get none => Intl.message("None", name: "none", desc: "None string");

  String productCommentTitle(int howMany) => Intl.message("Comment($howMany)",
      name: "productCommentTitle",
      args: [howMany],
      desc: "Product page comment title");

  String productCommentHowManyDaysAgo(int howMany) =>
      Intl.message("$howMany days ago",
          name: "productCommentHowManyDaysAgo",
          args: [howMany],
          desc: "Product page comment how many days ago prompt");

  String get productAddToCartText => Intl.message("Add to cart",
      name: "productAddToCartText",
      desc: "Product page add product to cart text");

  String get productBuyNowText => Intl.message("Buy now",
      name: "productBuyNowText", desc: "Product page buy now text");

  String get productColorWhite => Intl.message("White",
      name: "productColorWhite", desc: "Product color white");

  String get productColorBlack => Intl.message("Black",
      name: "productColorBlack", desc: "Product color black");

  String get productColorRed =>
      Intl.message("Red", name: "productColorRed", desc: "Product color red");

  String get productColorOrange => Intl.message("Orange",
      name: "productColorOrange", desc: "Product color orange");

  String get productColorYellow => Intl.message("Yellow",
      name: "productColorYellow", desc: "Product color yellow");

  String get productColorGreen => Intl.message("Green",
      name: "productColorGreen", desc: "Product color green");

  String get productColorBlue => Intl.message("Blue",
      name: "productColorBlue", desc: "Product color blue");

  String get productColorPurple => Intl.message("Purple",
      name: "productColorPurple", desc: "Product color purple");

  String get productColorPink => Intl.message("Pink",
      name: "productColorPink", desc: "Product color pink");

  String get productColorPrompt => Intl.message("Color",
      name: "productColorPrompt", desc: "Product page color prompt");

  String get productSizePrompt => Intl.message("Size",
      name: "productSizePrompt", desc: "Product page size prompt");

  String get unknown =>
      Intl.message("Unknown", name: "unknown", desc: "Unknown text");

  String get productStockPrompt => Intl.message("stock",
      name: "productStockPrompt", desc: "Product page stock prompt");

  String get productCommentNoMore => Intl.message("No more",
      name: "productCommentNoMore",
      desc: "Product comment page no more prompt");

  String get productCommentNoComment => Intl.message("No comment",
      name: "productCommentNoComment",
      desc: "Product comment page no comment prompt");

  String get productCommentLoading => Intl.message("Loading",
      name: "productCommentLoading",
      desc: "Product comment page no loading prompt");

  String get productAddToCartFailed => Intl.message("Add to cart faile",
      name: "productAddToCartFailed",
      desc: "Product page add to cart faild prompt");

  String get productAddToCartNotSelect =>
      Intl.message("Please select product first",
          name: "productAddToCartNotSelect",
          desc: "Product page add to cart faild not select product prompt");

  String get productAddToCartSuccess => Intl.message("Add success",
      name: "productAddToCartSuccess",
      desc: "Product page add to cart success prompt");
}
