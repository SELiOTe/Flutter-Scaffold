import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';
import '../util/common.dart';
import '../widget/loading.dart';
import '../page/login.dart';
import '../util/text.dart';
import '../util/io.dart';

// 页面名称
const SETTING_PAGE_NAME = "/setting";

/// 设置页面
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // 缓存大小
  String _cacheSize = "";
  // 软件版本
  String _version = "";

  @override
  void initState() {
    super.initState();
    _getCacheSize();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FrLocalizations.of(context).settingAppBarTitle),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    var menus = [
      Builder(
          builder: (context) => ListTile(
                title: Text(FrLocalizations.of(context).settingClearCache),
                trailing: Text(_cacheSize),
                onTap: () => _clearCache(context),
              )),
      ListTile(
        title: Text(FrLocalizations.of(context).settingVersion),
        trailing: Text(_version),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        OutlineButton(
            child: Text(FrLocalizations.of(context).settingLogout),
            onPressed: _logout)
      ]),
    ];
    var divider = Divider();
    return ListView.separated(
        itemCount: menus.length,
        separatorBuilder: (_, __) => divider,
        itemBuilder: (_, index) => menus[index]);
  }

  void _clearCache(BuildContext context) {
    var loading = CircularLoading(context);
    loading.show();
    try {
      delSubDir(tmpPath);
    } finally {
      loading.dismiss();
    }
    snackBar(context, FrLocalizations.of(context).settingClearCacheSuccess);
    _getCacheSize();
  }

  void _getCacheSize() async {
    var path = getTempPath();
    var size = getDirSize(path);
    setState(() {
      _cacheSize = bitsUnitConvert(size);
    });
  }

  void _getVersion() async {
    var pkgInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = pkgInfo.version;
    });
  }

  void _logout() async {
    var loading = CircularLoading(context);
    loading.show();
    try {
      var sp = await SharedPreferences.getInstance();
      await sp.clear();
    } finally {
      loading.dismiss();
    }
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LOGIN_PAGE_NAME, (route) => false);
  }
}
