import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../model/provider/global_model.dart';
import '../model/backend/user/position.dart';
import '../util/backend.dart';
import '../util/common.dart';
import '../widget/home_dealer.dart';
import '../widget/home_market.dart';
import '../widget/home_mine.dart';

// 页面名称
const HOME_PAGE_NAME = "/home";

/// 主页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 下方导航栏当前索引
  int _currentBottomBarIndex = 0;

  List<Widget> _contentWidget = [HomeMarket(), HomeDealer(), HomeMine()];

  @override
  void initState() {
    super.initState();
    debugPrint("Init HomePage");
    // 获取用户信息
    refreshUserInfo(Provider.of<GlobalModel>(context, listen: false));
    // 获取用户位置并上传
    _autoUploadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentWidget[_currentBottomBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: FrLocalizations.of(context).homeMarketBottomBarText),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: FrLocalizations.of(context).homeDealerBottomBarText),
          BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: FrLocalizations.of(context).homeMineBottomBarText),
        ],
        currentIndex: _currentBottomBarIndex,
        onTap: _onBottomBarTap,
      ),
    );
  }

  // 点击下方导航栏事件
  void _onBottomBarTap(i) {
    setState(() {
      _currentBottomBarIndex = i;
    });
  }

  /// 自动获取用户位置并上传至服务器
  void _autoUploadLocation() {
    // 因为是自动获取，异常了就不上传了，不做任何处理
    determinePosition().then((value) {
      final uri = "user/position";
      var req = PositionReq(value.longitude, value.latitude);
      postObject(uri, req);
    }).catchError((err) => debugPrint("Can not get position, code: $err"));
  }
}
