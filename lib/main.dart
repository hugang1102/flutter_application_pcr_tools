import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/locale_model.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/user_model.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/theme_model.dart';
import 'package:flutter_application_pcr_tools/localization/custom_localizations.dart';
import 'package:flutter_application_pcr_tools/model/battle_team_entity.dart';
import 'package:flutter_application_pcr_tools/page/battle_detail_page.dart';
import 'package:flutter_application_pcr_tools/page/events_calendar_page.dart';
import 'package:flutter_application_pcr_tools/page/home_page.dart';
import 'package:flutter_application_pcr_tools/page/language_select.dart';
import 'package:flutter_application_pcr_tools/page/login_page.dart';
import 'package:flutter_application_pcr_tools/page/role_page.dart';
import 'package:flutter_application_pcr_tools/page/setting_page.dart';
import 'package:flutter_application_pcr_tools/page/theme_selecte_page.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() {
    GlobalPres.init().then((value) => runApp(MyApp()));
  }, (dynamic error, dynamic stack) {
    print("Something went wrong!");
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (context, themeModel, localeModel, child) {
          return ScreenUtilInit(
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: themeModel.theme,
                ),
                onGenerateTitle: (context) {
                  // ??????context???Localizations????????????
                  return CustomLocalizations.of(context).title;
                },
                home: child,
                locale: localeModel.getLocale(),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  CustomLocalizationsDelegate(),
                ],
                supportedLocales: [
                  const Locale('en', 'US'), // ????????????
                  const Locale('zh', 'CN'), // ????????????
                  //??????Locales
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  if (localeModel.getLocale() != null) {
                    //?????????????????????????????????????????????
                    return localeModel.getLocale();
                  } else {
                    //????????????
                    Locale _locale;
                    if (supportedLocales.contains(locale)) {
                      _locale = locale!;
                    } else {
                      //?????????????????????????????????????????????????????????????????????????????????
                      _locale = Locale('en', 'US');
                    }
                    return _locale;
                  }
                },
                routes: <String, WidgetBuilder>{
                  "login": (context) => LoginPage(),
                  "themes": (context) => ThemeSelectPage(),
                  "language": (context) => LanguageSelectPage(),
                  "events_calendar": (context) => EventsCalendatPage(),
                },
                onGenerateRoute: (settings) {
                  if (settings.name.toString() == "battle_detail") {
                    return MaterialPageRoute(
                        builder: (context) => BattleDetailPage(
                            battle: (settings.arguments as BattleTeamEntity)));
                  }
                },
              );
            },
            child: RootBottomNavbar(),
          );
        },
      ),
    );
  }
}

class RootBottomNavbar extends StatefulWidget {
  RootBottomNavbar({Key? key}) : super(key: key);

  @override
  State<RootBottomNavbar> createState() => _RootBottomNavbarState();
}

class _RootBottomNavbarState extends State<RootBottomNavbar> {
  int _currentIndex = 0;

  List<Widget> _pageList = [
    HomePage(),
    RolePage(),
    SettingPage(),
  ];

  List<String> _itemTitleList = [
    "??????",
    "??????",
    "??????",
  ];

  List<IconData> _itemIconList = [
    Icons.home,
    Icons.person,
    Icons.settings,
  ];

  List<BottomNavigationBarItem> _items() {
    var list = <BottomNavigationBarItem>[];
    for (var i = 0; i < 3; i++) {
      var item = BottomNavigationBarItem(
        icon: Icon(_itemIconList[i]),
        label: _itemTitleList[i],
      );
      list.add(item);
    }
    return list;
  }

  List<String> _dateTitleList = [
    "????????????",
    "2022-06",
    "2022-05",
  ];

  String _currentDate = "????????????";

  final PageController _pageController = PageController(
    initialPage: 0, //???????????????0?????????
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
          _pageController.jumpToPage(index);
        },
        items: _items(),
      ),
    );
  }
}
