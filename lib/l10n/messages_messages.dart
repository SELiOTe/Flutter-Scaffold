// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(howMany) => "${howMany} days ago";

  static m1(howMany) => "Comment(${howMany})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "apiForbidden" : MessageLookupByLibrary.simpleMessage("Forbidden"),
    "backendStatusDisplayError" : MessageLookupByLibrary.simpleMessage("Server error"),
    "backendStatusDisplaySuccess" : MessageLookupByLibrary.simpleMessage("Success"),
    "backendStatusDisplayUnknown" : MessageLookupByLibrary.simpleMessage("Unknown status"),
    "backendStatusFrequent" : MessageLookupByLibrary.simpleMessage("Too frequent"),
    "cancelButtonText" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "captchaCodeFormatError" : MessageLookupByLibrary.simpleMessage("Captcha code format incorrect"),
    "confirmButtonText" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "cropAvatarPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("Crop"),
    "homeDealerBottomBarText" : MessageLookupByLibrary.simpleMessage("Dealer"),
    "homeMarketBottomBarText" : MessageLookupByLibrary.simpleMessage("Market"),
    "homeMineBottomBarText" : MessageLookupByLibrary.simpleMessage("Mine"),
    "homeMineMenuOnlneService" : MessageLookupByLibrary.simpleMessage("Online Service"),
    "homeMineMenuOrder" : MessageLookupByLibrary.simpleMessage("Order"),
    "homeMineMenuSetting" : MessageLookupByLibrary.simpleMessage("Settings"),
    "homeScanQrCodeFailed" : MessageLookupByLibrary.simpleMessage("Faild to scan QR Code"),
    "loginCaptchaDialogTitle" : MessageLookupByLibrary.simpleMessage("Captcha"),
    "loginCaptchaError" : MessageLookupByLibrary.simpleMessage("Captcha error, try again"),
    "loginNewCaptchaButtonText" : MessageLookupByLibrary.simpleMessage("New One?"),
    "loginSmsSendFailed" : MessageLookupByLibrary.simpleMessage("Verify code send failed"),
    "loginSmsSendSuccess" : MessageLookupByLibrary.simpleMessage("Verify code send success"),
    "loginSubmitButton" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginTelLabel" : MessageLookupByLibrary.simpleMessage("Telephone Number"),
    "loginVerifyCodeButton" : MessageLookupByLibrary.simpleMessage("Get"),
    "loginVerifyCodeError" : MessageLookupByLibrary.simpleMessage("Verify code error"),
    "loginVerifyCodeLabel" : MessageLookupByLibrary.simpleMessage("Verify Code"),
    "modifyAvatarAppBarTitle" : MessageLookupByLibrary.simpleMessage("Modify Avatar"),
    "modifyAvatarModifyButton" : MessageLookupByLibrary.simpleMessage("Modify"),
    "modifyInfoAppBarTitle" : MessageLookupByLibrary.simpleMessage("Modify Info"),
    "modifyInfoGender" : MessageLookupByLibrary.simpleMessage("Gender"),
    "modifyInfoGenderFemale" : MessageLookupByLibrary.simpleMessage("Female"),
    "modifyInfoGenderIncorrect" : MessageLookupByLibrary.simpleMessage("Gender pattern incorrect"),
    "modifyInfoGenderMale" : MessageLookupByLibrary.simpleMessage("Male"),
    "modifyInfoGenderUnknown" : MessageLookupByLibrary.simpleMessage("Unset"),
    "modifyInfoImgTooBig" : MessageLookupByLibrary.simpleMessage("Select avatar is too big"),
    "modifyInfoImgTooSmall" : MessageLookupByLibrary.simpleMessage("Select avatar is too small"),
    "modifyInfoNickname" : MessageLookupByLibrary.simpleMessage("Nickname"),
    "modifyInfoNicknameIncorrect" : MessageLookupByLibrary.simpleMessage("Nickname pattern incorrect"),
    "moneySymbol" : MessageLookupByLibrary.simpleMessage("\$"),
    "none" : MessageLookupByLibrary.simpleMessage("None"),
    "productAddToCartFailed" : MessageLookupByLibrary.simpleMessage("Add to cart faile"),
    "productAddToCartNotSelect" : MessageLookupByLibrary.simpleMessage("Please select product first"),
    "productAddToCartSuccess" : MessageLookupByLibrary.simpleMessage("Add success"),
    "productAddToCartText" : MessageLookupByLibrary.simpleMessage("Add to cart"),
    "productBuyNowText" : MessageLookupByLibrary.simpleMessage("Buy now"),
    "productColorBlack" : MessageLookupByLibrary.simpleMessage("Black"),
    "productColorBlue" : MessageLookupByLibrary.simpleMessage("Blue"),
    "productColorGreen" : MessageLookupByLibrary.simpleMessage("Green"),
    "productColorOrange" : MessageLookupByLibrary.simpleMessage("Orange"),
    "productColorPink" : MessageLookupByLibrary.simpleMessage("Pink"),
    "productColorPrompt" : MessageLookupByLibrary.simpleMessage("Color"),
    "productColorPurple" : MessageLookupByLibrary.simpleMessage("Purple"),
    "productColorRed" : MessageLookupByLibrary.simpleMessage("Red"),
    "productColorWhite" : MessageLookupByLibrary.simpleMessage("White"),
    "productColorYellow" : MessageLookupByLibrary.simpleMessage("Yellow"),
    "productCommentHowManyDaysAgo" : m0,
    "productCommentLoading" : MessageLookupByLibrary.simpleMessage("Loading"),
    "productCommentNoComment" : MessageLookupByLibrary.simpleMessage("No comment"),
    "productCommentNoMore" : MessageLookupByLibrary.simpleMessage("No more"),
    "productCommentTitle" : m1,
    "productDealerWillEarn" : MessageLookupByLibrary.simpleMessage("Dealer will earn: "),
    "productSelecting" : MessageLookupByLibrary.simpleMessage("Selecting: "),
    "productSizePrompt" : MessageLookupByLibrary.simpleMessage("Size"),
    "productStockPrompt" : MessageLookupByLibrary.simpleMessage("stock"),
    "reLoginText" : MessageLookupByLibrary.simpleMessage("Please relogin"),
    "saveButton" : MessageLookupByLibrary.simpleMessage("Save"),
    "saveFailedPrompt" : MessageLookupByLibrary.simpleMessage("Save failed"),
    "saveSuccessPrompt" : MessageLookupByLibrary.simpleMessage("Save success"),
    "scanAppBarTitle" : MessageLookupByLibrary.simpleMessage("Scan QR"),
    "settingAppBarTitle" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settingClearCache" : MessageLookupByLibrary.simpleMessage("Clear cache"),
    "settingClearCacheSuccess" : MessageLookupByLibrary.simpleMessage("Clear cache success"),
    "settingLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settingVersion" : MessageLookupByLibrary.simpleMessage("Version"),
    "telNoFormatError" : MessageLookupByLibrary.simpleMessage("Telephone number format incorrect"),
    "title" : MessageLookupByLibrary.simpleMessage("Fitting Room"),
    "unknown" : MessageLookupByLibrary.simpleMessage("Unknown"),
    "unsavePrompt" : MessageLookupByLibrary.simpleMessage("Unsaved"),
    "verifyCodeFormatError" : MessageLookupByLibrary.simpleMessage("Verify code format incorrect")
  };
}
