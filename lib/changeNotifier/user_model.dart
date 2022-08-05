import 'package:flutter_application_pcr_tools/changeNotifier/profile_change_notifier.dart';

class UserModel extends ProfileChangeNotifier {
  String? get user => profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(String? user) {
    if(user != profile.user) {
      profile.user = user;
      notifyListeners();
    }
  }
}