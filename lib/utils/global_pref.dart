import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/model/cache_config_entity.dart';
import 'package:flutter_application_pcr_tools/model/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/netCache_interceptor.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class GlobalPres {
  static late SharedPreferences _prefs;

  static ProfileEntity profile = ProfileEntity();
  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile_entity");
    if (_profile != null) {
      try {
        profile = ProfileEntity.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      // 默认主题索引为0，代表蓝色
      profile = ProfileEntity()..theme = 0;
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfigEntity()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 默认app内打开链接
    profile.openLinkInApp = profile.openLinkInApp ?? true;

    //初始化网络请求相关配置
    // Git.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile_entity", jsonEncode(profile.toJson()));
}
