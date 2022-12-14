import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/locale_model.dart';
import 'package:provider/provider.dart';

class LanguageSelectPage extends StatelessWidget {
  const LanguageSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing:
        localeModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 此行代码会通知MaterialApp重新build
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("语言选择"),
      ),
      body: ListView(
        children: [
          _buildLanguageItem("简体中文", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem("自动", null),
        ],
      ),
    );
  }
}
