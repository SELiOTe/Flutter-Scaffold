import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/image_viewer.dart';
import 'page/product.dart';
import 'page/product_comment.dart';
import 'page/setting.dart';
import 'util/const.dart';
import 'l10n/l10n.dart';
import 'model/provider/global_model.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/modify_avatar.dart';
import 'page/modify_info.dart';
import 'page/scan.dart';
import 'util/backend.dart';
import 'page/error.dart';
import 'util/io.dart';

/// 应用入口方法
void main(List<String> args) async {
  // debugPaintSizeEnabled = true;
  debugPrint("Init application");
  // 确保初始化成功
  WidgetsFlutterBinding.ensureInitialized();
  // 拉取本地 token 确定第一页该跳进哪里
  var sp = await SharedPreferences.getInstance();
  token = sp.getString(SpConst.SP_TOKEN_KEY);
  debugPrint("Retrive token: ${token == null}");
  // 获取本地缓存目录
  tmpPath = (await getTemporaryDirectory()).path;
  runApp(ChangeNotifierProvider(
    create: (context) => GlobalModel(),
    // 去除懒加载
    lazy: false,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme,
      navigatorKey: globalKey,
      localizationsDelegates: [
        const FrLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        ...FrLocalizationsDelegate.SUPPORT_LOCALES.map((e) => Locale(e, ""))
      ],
      onGenerateTitle: (context) => FrLocalizations.of(context).title,
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return _dispatchPage(settings, token: token);
        } else {
          return _dispatchPage(settings);
        }
      },
    ),
  ));
}

// 用于获取全局 Context
final GlobalKey<NavigatorState> globalKey = new GlobalKey<NavigatorState>();

// 应用主题
final ThemeData _theme = ThemeData(primarySwatch: Colors.teal);

// 应用路由钩子
Route<dynamic> _dispatchPage(RouteSettings settings, {String token}) {
  String name = settings.name;
  Object args = settings.arguments;
  debugPrint("Dispatch page: $name, args: $args");
  switch (name) {
    case "/":
      return MaterialPageRoute(
          builder: (context) => token == null ? LoginPage() : HomePage());
    case LOGIN_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case HOME_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => HomePage());
    case SCAN_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => ScanPage());
    case MODIFY_INFO_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => ModifyInfoPage());
    case MODIFY_AVATAR_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => ModifyAvatarPage());
    case SETTING_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => SettingPage());
    case PRODUCT_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => ProductPage(args));
    case PAGE_VIEWER_NAME:
      return MaterialPageRoute(builder: (context) => ImageViewerPage(args));
    case PRODUCT_COMMENT_PAGE_NAME:
      return MaterialPageRoute(builder: (context) => ProductCommentPage(args));
    default:
      return MaterialPageRoute(builder: (context) => ErrorPage(name, args));
  }
}
