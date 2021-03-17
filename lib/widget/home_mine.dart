import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/backend/user/info.dart';
import '../util/backend.dart';
import '../util/const.dart';
import '../l10n/l10n.dart';
import '../util/common.dart';
import '../util/text.dart';
import '../page/modify_info.dart';
import '../model/provider/global_model.dart';
import '../page/setting.dart';

/// 首页我的
class HomeMine extends StatefulWidget {
  @override
  _HomeMineState createState() => _HomeMineState();
}

class _HomeMineState extends State<HomeMine> {
  // 头像大小
  static const avatarSize = 64.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GlobalModel>(
      builder: (_, model, child) => RefreshIndicator(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_getSelfInfoWidget(model), child],
          ),
          onRefresh: () => refreshUserInfo(model)),
      child: _getMenusWidget(),
    ));
  }

  /// 获取个人信息组件
  ///
  /// return 个人信息组件
  Widget _getSelfInfoWidget(GlobalModel model) {
    debugPrint("Get self information");
    return Builder(
        builder: (context) => GestureDetector(
              child: Container(
                  padding: EdgeInsets.fromLTRB(16, 56, 16, 32),
                  color: Theme.of(context).primaryColor,
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: IntrinsicHeight(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _getHeaderAvatarWidget(model),
                      SizedBox(
                        width: 24,
                      ),
                      _getHeaderInfoWidget(model),
                      _getHeaderRightRow()
                    ],
                  ))),
              onTap: () => _onHeaderTap(context),
            ));
  }

  /// 获取头部点击响应
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  void _onHeaderTap(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed(MODIFY_INFO_PAGE_NAME);
    if (result != null && result is bool && result == true) {
      snackBar(context, FrLocalizations.of(context).saveSuccessPrompt);
    } else {
      snackBar(context, FrLocalizations.of(context).unsavePrompt);
    }
  }

  /// 获取头部头像组件
  ///
  /// param [model] 数据模型
  ///
  /// return 头部头像组件
  Widget _getHeaderAvatarWidget(GlobalModel model) {
    return Container(
        width: avatarSize,
        height: avatarSize,
        child: Stack(children: [
          ClipOval(
            child: getCachedNetworkImage(model.avatar,
                width: avatarSize, height: avatarSize, fit: BoxFit.cover),
          ),
          if (model.gender != Gender.unknown) _getAvatarGender(model.gender)
        ]));
  }

  /// 获取头部个人信息组件
  ///
  /// param ·[model] 数据模型
  ///
  /// return 头部个人信息组件
  Widget _getHeaderInfoWidget(GlobalModel model) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            // 加个 Row 是为了让垂直居中
            child: Row(children: [
          Text(
            "${model.nickname}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ])),
        Expanded(child: Row(children: [Text("ID: ${model.id}")]))
      ],
    ));
  }

  /// 获取头部右箭头组件
  ///
  /// return 头部右箭头组件
  Widget _getHeaderRightRow() {
    return Icon(Icons.chevron_right);
  }

  /// 获取头像性别组件
  ///
  /// param [gender] 性别
  ///
  /// return 头像性别组件
  Widget _getAvatarGender(Gender gender) {
    if (gender == Gender.male) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          FrIcons.male,
          color: Colors.blue,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          FrIcons.female,
          color: Colors.pink,
        ),
      );
    }
  }

  /// 获取菜单组件
  ///
  /// return 菜单组件
  Widget _getMenusWidget() {
    var menus = [
      ListTile(
        leading: Icon(Icons.strikethrough_s),
        title: Text(FrLocalizations.of(context).homeMineMenuOrder),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.group),
        title: Text(FrLocalizations.of(context).homeMineMenuOnlneService),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text(FrLocalizations.of(context).homeMineMenuSetting),
        onTap: () {
          Navigator.of(context).pushNamed(SETTING_PAGE_NAME);
        },
      )
    ];
    var divider = Divider();
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
                itemCount: menus.length,
                separatorBuilder: (context, index) => divider,
                itemBuilder: (context, index) => menus[index])));
  }
}

/// 更新用户信息
///
/// param [model] 更新操作的 GlobalModel
Future<void> refreshUserInfo(GlobalModel model) async {
  final uri = "user/info";
  var resp = await postObject(uri, null);
  if (resp == null) {
    return;
  }
  // 需要注意如果服务器存在异常，下方所有代码均不会再执行
  var info = InfoResp.fromJson(resp.data);
  var sp = await SharedPreferences.getInstance();
  if (model.id != info.id) {
    sp.setInt(SpConst.SP_ID_KEY, info.id);
    model.id = info.id;
  }
  if (model.nickname != info.nickname) {
    sp.setString(SpConst.SP_NICKNAME_KEY, info.nickname);
    model.nickname = info.nickname;
  }
  if (model.gender.index != info.gender) {
    sp.setInt(SpConst.SP_GENDER_KEY, info.gender);
    model.gender = info.gender == 1 || info.gender == 2
        ? (info.gender == 1 ? Gender.male : Gender.famale)
        : Gender.unknown;
  }
  if (model.avatar != info.avatar) {
    sp.setString(SpConst.SP_AVATAR_KEY, info.avatar);
    model.avatar = info.avatar;
  }
}
