import 'package:flutter_application_pcr_tools/model/profile_entity.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:flutter/material.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  ProfileEntity get profile => GlobalPres.profile;

  @override
  void notifyListeners() {
    GlobalPres.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}