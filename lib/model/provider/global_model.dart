import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/const.dart';

/// 应用全局模型，所有 getter 均 null 安全
class GlobalModel with ChangeNotifier {
  /// 初始化资源
  /// 需要去除懒加载，否则会导致第一次使用时才调用构造器
  GlobalModel() {
    debugPrint("Construct GlobalModel");
    SharedPreferences.getInstance().then((sp) {
      _id = sp.getInt(SpConst.SP_ID_KEY) ?? 0;
      _nickname = sp.getString(SpConst.SP_NICKNAME_KEY) ?? "";
      _gender = Gender.values[sp.getInt(SpConst.SP_GENDER_KEY) ?? 0];
      _avatar = sp.getString(SpConst.SP_AVATAR_KEY) ??
          "0000000000000000000000000000000000000000";
    }).catchError((Object obj) {
      _id = 0;
      _nickname = "";
      _gender = Gender.unknown;
      _avatar = "0000000000000000000000000000000000000000";
    });
  }

  // 用户 ID
  int _id;

  int get id => _id;

  set id(int id) {
    _id = id;
    notifyListeners();
  }

  // 用户昵称
  String _nickname;

  String get nickname => _nickname;

  set nickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  // 用户性别
  Gender _gender = Gender.unknown;

  Gender get gender => _gender;

  set gender(Gender gender) {
    _gender = gender;
    notifyListeners();
  }

  // 用户头像 SHA1
  String _avatar;

  String get avatar => _avatar;

  set avatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }
}

enum Gender { unknown, male, famale }
