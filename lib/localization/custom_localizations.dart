import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/generated/intl/messages_all.dart';
import 'package:intl/intl.dart';

class CustomLocalizations {
  static Future<CustomLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((value) {
      Intl.defaultLocale = localeName;
      return CustomLocalizations();
    });
  }

  CustomLocalizations();

  //是否为中文
  bool isZh = false;
  //为了使用方便，我们定义一个静态方法
  static CustomLocalizations of(BuildContext context) {
    return Localizations.of(context, CustomLocalizations);
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? "Flutter应用" : "Flutter APP";
  }
  //... 其它的值
}

//Locale代理类
class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  CustomLocalizationsDelegate();

  //是否支持某个Locale
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<CustomLocalizations> load(Locale locale) {
    return CustomLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(covariant LocalizationsDelegate<CustomLocalizations> old) =>
      false;
}
