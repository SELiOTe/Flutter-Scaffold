import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';
import '../model/backend/captcha/sms.dart';
import '../model/backend/sms/login.dart';
import '../model/backend/user/login.dart';
import '../page/home.dart';
import '../util/backend.dart';
import '../util/const.dart';
import '../util/text.dart';
import '../util/common.dart';
import '../widget/loading.dart';

// 页面名称
const LOGIN_PAGE_NAME = "/login";

/// 登录页
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 距离下一次可发送验证码间隔
  int _sendInterval = -1;
  Timer _sendIntervalTimer;

  // 国际电话呼叫码
  String _countryCode = "86";
  // 手机号码
  String _telNo;
  // 用户输入的短信验证码
  String _verifyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          // 组件纵向需要加上间距
          ...[
            _getTelNoInputWidget(),
            _getVerifyCodeRow(context),
            _getLoginButton()
          ].expand((element) => [
                element,
                SizedBox(
                  height: 16,
                )
              ])
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Dispose login");
    // 关闭 Timer
    if (_sendIntervalTimer != null && _sendIntervalTimer.isActive) {
      _sendIntervalTimer.cancel();
    }
  }

  /// 获取 AppBar
  ///
  /// param ·[context] BuildContext 对象
  ///
  /// reurn [AppBar] AppBar 对象
  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(FrLocalizations.of(context).title),
    );
  }

  /// 获取手机号码输入框
  ///
  /// return  Widget 对象
  Widget _getTelNoInputWidget() {
    return TextFormField(
      decoration: InputDecoration(
          prefix: Text("+$_countryCode "),
          labelText: FrLocalizations.of(context).loginTelLabel),
      keyboardType: TextInputType.phone,
      maxLines: 1,
      maxLength: 11,
      onChanged: (value) => _telNo = value,
    );
  }

  /// 获取短信验证码行组件
  ///
  /// param [context] BuildContext 对象
  ///
  /// return Widget 对象
  Widget _getVerifyCodeRow(BuildContext context) {
    // 让 Row 中元素与最高元素等高
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: _getVerifyCodeInputField(context)),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: _getVerifyCodeButton(context),
          ),
        ],
      ),
    );
  }

  /// 获取登录按钮
  ///
  /// return Widget 对象
  Widget _getLoginButton() {
    return Builder(
        builder: (context) => TextButton(
            onPressed: () async => _loginButtonOnPressed(context),
            child: Text(FrLocalizations.of(context).loginSubmitButton)));
  }

  /// 获取短信验证码输入框
  ///
  /// param [context] BuildContext 对象
  ///
  /// return Widget 对象
  Widget _getVerifyCodeInputField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: FrLocalizations.of(context).loginVerifyCodeLabel,
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      onChanged: (value) => _verifyCode = value,
    );
  }

  /// 获取短信验证码按钮
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  ///
  /// return Widget 对象
  Widget _getVerifyCodeButton(BuildContext context) {
    // 内部有使用 SnackBar
    return Builder(
        builder: (context) => OutlineButton(
            // 根据发送间隔来判断发送按钮的状态
            child: _sendInterval <= 0
                ? Text(FrLocalizations.of(context).loginVerifyCodeButton)
                : Text("$_sendInterval S"),
            onPressed: _sendInterval > 0
                ? null
                : () => _verifyCodeButtonOnPress(context)));
  }

  /// 发送验证码按钮按下后响应
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  void _verifyCodeButtonOnPress(BuildContext context) async {
    var loading = CircularLoading(context);
    loading.show();
    try {
      var img = await _requestSmsCaptcha(context, _countryCode, _telNo);
      // null 说明服务器返回数据有问题
      // 服务器返回信息失败的界面处理 _requestSmsCaptcha 中做的
      if (img == null) return;
      // 弹窗让输入图片验证码做人机校验，返回验证码发送图片成功与否
      // 这里允许用户按 back 键，但是返回结果就是 null
      // 只有短信验证码发送成功这里才会返回 true
      var sendResult = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CaptchaInputDialog(_countryCode, _telNo, img));
      if (sendResult == true) {
        snackBar(context, FrLocalizations.of(context).loginSmsSendSuccess);
        _verifyCodeButtonTimer();
      } else {
        snackBar(context, FrLocalizations.of(context).loginSmsSendFailed);
      }
    } finally {
      loading.dismiss();
    }
  }

  ///  发送验证码按钮按下后响应倒计时
  void _verifyCodeButtonTimer() {
    _sendInterval = 60;
    // 立即 setState 避免一秒间隔
    setState(() {});
    // 倒计时 Timer
    _sendIntervalTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 不能让 Timer 无限跑
      if (_sendInterval < 0) {
        timer.cancel();
        _sendInterval = 0;
      }
      setState(() {
        _sendInterval--;
      });
    });
  }

  /// 登录按钮按下响应
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  void _loginButtonOnPressed(BuildContext context) async {
    // 校验
    if (!checkCountryCode(_countryCode) || !checkTelNo(_telNo)) {
      snackBar(context, FrLocalizations.of(context).telNoFormatError);
      return;
    }
    if (!checkVerifyCode(_verifyCode)) {
      snackBar(context, FrLocalizations.of(context).captchaCodeFormatError);
      return;
    }
    final uri = "user/login";
    var req = UserLoginReq(_countryCode, _telNo, _verifyCode);
    var resp = await postObject(uri, req, context: context);
    if (resp == null) {
      return;
    }
    var respModel = UserLoginResp.fromJson(resp.data);
    if (respModel.loginResult == 0) {
      token = respModel.token;
      // 本地存上
      var sp = await SharedPreferences.getInstance();
      sp.setString(SpConst.SP_TOKEN_KEY, token);
      // 跳首页
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HOME_PAGE_NAME, (route) => false);
      return;
    } else if (respModel.loginResult == 1) {
      snackBar(context, FrLocalizations.of(context).loginVerifyCodeError);
      return;
    } else {
      snackBar(context, FrLocalizations.of(context).backendStatusDisplayError);
      return;
    }
  }
}

/// 请求图片验证码
///
/// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
/// param [countryCode] 国际电话呼叫码
/// param [telNo] 手机号码
///
/// return 请求成功返回相应的 Image 对象，否则返回 null
Future<Image> _requestSmsCaptcha(
    BuildContext context, String countryCode, String telNo) async {
  // 校验
  if (!checkCountryCode(countryCode) || !checkTelNo(telNo)) {
    snackBar(context, FrLocalizations.of(context).telNoFormatError);
    return null;
  }
  final uri = "captcha/sms";
  var req = CaptchaSmsReq(countryCode, telNo);
  var resp = await postObject(uri, req, context: context);
  if (resp == null) {
    return null;
  }
  var base64 = CaptchaSmsResp.fromJson(resp.data).captcha;
  // Base 64 解码一下返回相应的 Windget 对象
  var img = base64ToImg(base64, width: 200, height: 70, fit: BoxFit.cover);
  return img;
}

/// 图形验证码输入弹窗
class CaptchaInputDialog extends StatefulWidget {
  // 国际电话呼叫码
  final String _countryCode;
  // 手机号码
  final String _telNo;
  // 初始验证码图片
  final Image _img;

  CaptchaInputDialog(this._countryCode, this._telNo, this._img);

  @override
  _CaptchaInputDialogState createState() => _CaptchaInputDialogState();
}

class _CaptchaInputDialogState extends State<CaptchaInputDialog> {
  // 当前验证码图片
  Image _img;
  // 用户输入的图片验证码
  String _captchaCode;

  @override
  void initState() {
    super.initState();
    _img = widget._img;
  }

  @override
  Widget build(BuildContext context) {
    // 因为要用 SnackBar 所以还需要包一层 Scaffold
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Builder(
                builder: (context) => AlertDialog(
                      title: _getDialogTitle(context),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _img,
                          _getNewCaptchaButton(),
                          _getCaptchaInputField(context)
                        ],
                      ),
                      actions: [
                        _getCancelAction(context),
                        _getConfirmAction(context)
                      ],
                    )),
          ),
        ));
  }

  /// 获取弹窗标题
  ///
  /// param ·[context] BuildContext 对象
  ///
  /// reurn [AppBar] AppBar 对象
  Widget _getDialogTitle(BuildContext context) {
    return Text(FrLocalizations.of(context).loginCaptchaDialogTitle);
  }

  /// 获取新图片验证码按钮
  ///
  /// reurn [AppBar] AppBar 对象
  Widget _getNewCaptchaButton() {
    // 内部有使用 SnackBar
    return Builder(builder: (context) {
      return TextButton(
        child: Text(FrLocalizations.of(context).loginNewCaptchaButtonText),
        onPressed: () async {
          var loading = CircularLoading(context);
          loading.show();
          try {
            // 获取新图并做替换
            var img = await _requestSmsCaptcha(
                context, widget._countryCode, widget._telNo);
            // 这里很重要，否则会导致界面报错
            if (img == null) return;
            setState(() {
              _img = img;
            });
          } finally {
            loading.dismiss();
          }
        },
      );
    });
  }

  /// 获取图片验证码输入区域
  ///
  /// param [context] BuildContext 对象
  ///
  /// return Widget 对象
  Widget _getCaptchaInputField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: FrLocalizations.of(context).loginVerifyCodeLabel),
      maxLines: 1,
      maxLength: 4,
      onChanged: (value) => _captchaCode = value,
    );
  }

  /// 获取取消 Action
  ///
  /// param [context] BuildContext 对象
  ///
  /// return Widget 对象
  Widget _getCancelAction(BuildContext context) {
    return FlatButton(
      child: Text(FrLocalizations.of(context).cancelButtonText),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
  }

  /// 获取确认 Action
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  ///
  /// return Widget 对象
  Widget _getConfirmAction(BuildContext context) {
    return Builder(builder: (context) {
      return FlatButton(
        child: Text(FrLocalizations.of(context).confirmButtonText),
        onPressed: () async {
          if (!checkCaptchaCode(_captchaCode)) {
            snackBar(
                context, FrLocalizations.of(context).captchaCodeFormatError);
            return;
          }
          var result = await _requestLoginSms(context);
          if (0 == result) {
            Navigator.of(context).pop(true);
          } else if (1 == result) {
            // 1 表示图形验证码填写错了，刷新一下让重新填
            var result = await _requestSmsCaptcha(
                context, widget._countryCode, widget._telNo);
            if (result != null) {
              setState(() => _img = result);
            }
            snackBar(context, FrLocalizations.of(context).loginCaptchaError);
          } else {
            // 其他状态，比如 API 请求超频
            Navigator.of(context).pop(false);
          }
        },
      );
    });
  }

  /// 请求发送短信验证码
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  ///
  /// return 发送结果
  Future<int> _requestLoginSms(BuildContext context) async {
    if (!checkCountryCode(widget._countryCode) || !checkTelNo(widget._telNo)) {
      snackBar(context, FrLocalizations.of(context).telNoFormatError);
      return null;
    }
    final uri = "sms/login";
    var req = SmsLoginReq(widget._countryCode, widget._telNo, _captchaCode);
    var resp = await postObject(uri, req, context: context);
    if (resp == null) {
      return null;
    } else {
      return SmsLoginResp.fromJson(resp.data).sendResult;
    }
  }
}
