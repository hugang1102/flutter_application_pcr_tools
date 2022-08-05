class NetApis {
  static const String host_pcrBox = "https://pcr.satroki.tech/api";
  static const String host_caimogu = "https://www.caimogu.cc/gzlj/data";

  /// 获取角色服务器信息
  static String getUnitServerInfo([String server = "cn"]) {
    return "/Unit/GetUnitServerInfo?s=$server";
  }

  /// 从文档获取工会战数据
  static String getBattleTeamsFromDoc([phase, boss]) {
    return "/Teams/GetBattleTeamsFromDoc?&phase=$phase&boss=$boss";
  }

  /// 获取icon地址
  static String getUnitIcon(int id, {int iconType = 3}) {
    return "https://pcr.satroki.tech/icon/unit/${id + iconType * 10}.webp";
  }

  /// 获取角色列表
  static String getUnitDatas([String server = "cn"]) {
    return "/Unit/GetUnitDatas?s=$server";
  }

  /// 获取时间日历
  static String getEvents([String server = "cn"]) {
    return "/Manage/GetEvents?s=$server";
  }
}
