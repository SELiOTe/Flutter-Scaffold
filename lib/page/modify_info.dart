import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitting_room/util/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/const.dart';
import '../model/backend/user/update_info.dart';
import '../util/backend.dart';
import '../util/text.dart';
import '../widget/loading.dart';
import '../util/common.dart';
import '../l10n/l10n.dart';
import '../model/provider/global_model.dart';
import '../page/modify_avatar.dart';

// 页面名称
const MODIFY_INFO_PAGE_NAME = "/home/modify_info";

class ModifyInfoPage extends StatefulWidget {
  @override
  _ModifyInfoPageState createState() => _ModifyInfoPageState();
}

class _ModifyInfoPageState extends State<ModifyInfoPage> {
  // 头像显示尺寸
  final double avatarSize = 80.0;
  // 当前界面显示的头像，避免没有按保存就直接更新了 GlobalModel
  Image _avatar;
  String _nickname;
  Gender _gender;

  // 修改头像界面出来设置的，如果是 null 就表示没有改头像
  Uint8List _newAvatar;

  TextEditingController _nicknameEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var model = Provider.of<GlobalModel>(context, listen: false);
    _avatar = Image(
        image: CachedNetworkImageProvider(sha1ToImgUrl(model.avatar)),
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover);
    _nickname = model.nickname;
    _gender = model.gender;
    _nicknameEditController.text = _nickname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(), body: _getInfoModifyWidget());
  }

  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(FrLocalizations.of(context).modifyInfoAppBarTitle),
      actions: [
        Consumer<GlobalModel>(
            builder: (context, model, __) => Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => _saveButtonOnPressed(context, model))))
      ],
    );
  }

  Widget _getInfoModifyWidget() {
    var widgets = [
      _getAvatarModifyWidget(),
      _getNicknameModifyWidget(),
      _getGenderModifyWidget()
    ];
    return ListView(
      children: widgets,
    );
  }

  Widget _getAvatarModifyWidget() {
    return Builder(
        builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: GestureDetector(
              child: ClipOval(child: _avatar),
              onTap: () => _getAvatarTap(context),
            ))));
  }

  Widget _getNicknameModifyWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  FrLocalizations.of(context).modifyInfoNickname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.1,
                ))),
            SizedBox(
              width: 16,
            ),
            Expanded(
                flex: 3,
                child: TextField(
                  controller: _nicknameEditController,
                  maxLines: 1,
                  maxLength: 16,
                  onChanged: (value) => _nickname = value.trim(),
                ))
          ],
        ));
  }

  Widget _getGenderModifyWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  FrLocalizations.of(context).modifyInfoGender,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.1,
                ))),
            SizedBox(
              width: 16,
            ),
            Expanded(flex: 3, child: _getGenderDropdownWidget())
          ],
        ));
  }

  void _getAvatarTap(BuildContext context) async {
    var tmp = await Navigator.of(context).pushNamed(MODIFY_AVATAR_PAGE_NAME);
    // 没换头像
    if (tmp == null && tmp is! Uint8List) {
      return;
    }
    var bytes = tmp as Uint8List;
    // 检查头像大小，这里直接是字节
    if (bytes.length < 1 * 1024) {
      snackBar(context, FrLocalizations.of(context).modifyInfoImgTooSmall);
      return;
    } else if (bytes.length > 10 * 1024 * 1024) {
      snackBar(context, FrLocalizations.of(context).modifyInfoImgTooBig);
      return;
    } else {
      _newAvatar = bytes;
      // 更新界面显示的当前头像，注意这里 Model 并没有更新
      setState(() {
        _avatar = Image.memory(bytes,
            width: avatarSize, height: avatarSize, fit: BoxFit.cover);
      });
    }
  }

  Widget _getGenderDropdownWidget() {
    var genders = [
      FrLocalizations.of(context).modifyInfoGenderUnknown,
      FrLocalizations.of(context).modifyInfoGenderMale,
      FrLocalizations.of(context).modifyInfoGenderFemale
    ];
    return DropdownButton<String>(
      value: genders[_gender.index],
      items: genders
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _gender = Gender.values[genders.indexOf(value)];
        });
      },
    );
  }

  void _saveButtonOnPressed(BuildContext context, GlobalModel model) async {
    var isSavedSuccess = false;
    var loading = CircularLoading(context);
    loading.show();
    try {
      if (_newAvatar == null) {
        // 没换的就读当前的
        var file = await DefaultCacheManager()
            .getSingleFile(sha1ToImgUrl(model.avatar));
        _newAvatar = readFileAsBytes(file.path);
      }
      var avatar = base64Encode(_newAvatar);
      var nickname = _nickname.trim();
      var gender = _gender.index;
      if (!checkNickname(nickname)) {
        snackBar(
            context, FrLocalizations.of(context).modifyInfoNicknameIncorrect);
        return;
      }
      if (!checkGender(gender)) {
        snackBar(
            context, FrLocalizations.of(context).modifyInfoGenderIncorrect);
        return;
      }
      isSavedSuccess =
          await _reqAndSaveInfo(context, model, avatar, nickname, gender);
    } finally {
      loading.dismiss();
    }
    // 注意这个不能放进 try 块里
    // 否则会因为先 pop 再 dismiss 造成路由返回值丢失
    if (isSavedSuccess) {
      Navigator.of(context).pop(isSavedSuccess);
    } else {
      snackBar(context, FrLocalizations.of(context).saveFailedPrompt);
    }
  }

  Future<bool> _reqAndSaveInfo(BuildContext context, GlobalModel model,
      String avatar, String nickname, int gender) async {
    final uri = "user/update_info";
    var req = UpdateInfoReq(avatar, nickname, gender);
    var resp = await postObject(uri, req, context: context);
    if (resp != null && resp.isSuccess()) {
      var respModel = UpdateInfoResp.fromJson(resp.data);
      model.avatar = respModel.avatar;
      model.nickname = respModel.nickname;
      model.gender = Gender.values[respModel.gender];
      var sp = await SharedPreferences.getInstance();
      sp.setInt(SpConst.SP_ID_KEY, model.id);
      sp.setString(SpConst.SP_NICKNAME_KEY, model.nickname);
      sp.setInt(SpConst.SP_GENDER_KEY, model.gender.index);
      sp.setString(SpConst.SP_AVATAR_KEY, model.avatar);
      return true;
    }
    return false;
  }
}
