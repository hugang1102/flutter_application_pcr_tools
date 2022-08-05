import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/profile_change_notifier.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';

/// APP主题状态
/// 主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  MaterialColor get theme =>
      GlobalPres.themes.firstWhere((element) => element.value == profile.theme,
          orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(MaterialColor color) {
    if (color != theme) {
      profile.theme = color[500]?.value;
      notifyListeners();
    }
  }
}
