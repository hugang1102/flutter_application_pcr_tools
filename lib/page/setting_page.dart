import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/locale_model.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var localeModel = Provider.of<LocaleModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.link),
            title: Text("打开链接方式"),
            trailing: PopupMenuButton(
              child: Text(GlobalPres.profile.openLinkInApp! ? "内置网页" : "外部浏览器"),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("内置网页"),
                    onTap: () {
                      GlobalPres.profile.openLinkInApp = true;
                      setState(() {});
                    },
                  ),
                  PopupMenuItem(
                    child: Text("外部浏览器"),
                    onTap: () {
                      GlobalPres.profile.openLinkInApp = false;
                      setState(() {});
                    },
                  ),
                ];
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.data_object),
            title: Text("切换会战数据源"),
            trailing: PopupMenuButton(
              child: Text("公主连结Box"),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(child: Text("公主连结Box")),
                  PopupMenuItem(child: Text("踩蘑菇")),
                ];
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.color_lens_outlined),
            title: Text("切换主题"),
            trailing: Container(
              color: Theme.of(context).primaryColor,
              width: 80,
              height: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("themes");
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("语言选择"),
            trailing: Text(localeModel.locale ?? "自动"),
            onTap: () {
              Navigator.of(context).pushNamed("language");
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("事件日历"),
            trailing: Text(formatDate(DateTime.now(), [yyyy,'-',m,'-',d])),
            onTap: () {
              Navigator.of(context).pushNamed("events_calendar");
            },
          ),
        ],
      ),
    );
  }
}
