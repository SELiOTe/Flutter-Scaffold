class UrlConst {
  // 后台接口基础 URL
  // static const BASE_URL = "http://10.0.2.2:8080/"; // 安卓模拟器访问本地
  static const BASE_URL = "http://192.168.0.199:8080/"; // 真机调试时环境
  // static const BASE_URL = "http://116.62.149.236:8080/fr/"; // 公网部署环境

  // 后台图片 URL
  // static const IMG_URL = "http://10.0.2.2/"; // 安卓模拟器访问本地
  static const IMG_URL = "http://192.168.0.199/"; // 真机调试时环境
  // static onst IMG_URL = "http://116.62.149.236/"; // 公网部署环境

  // 默认头像
  static const DEFAULT_AVATAR = "0000000000000000000000000000000000000000";
}

/// SharedPreference 存储常量
class SpConst {
  // 本地 SP 存储 Token 键
  static const SP_TOKEN_KEY = "token";
  // 本地 SP 存储 id 键
  static const SP_ID_KEY = "id";
  // 本地 SP 存储 nickname 键
  static const SP_NICKNAME_KEY = "nickname";
  // 本地 SP 存储 gender 键
  static const SP_GENDER_KEY = "gender";
  // 本地 SP 存储 avatar 键
  static const SP_AVATAR_KEY = "avatar";
}
