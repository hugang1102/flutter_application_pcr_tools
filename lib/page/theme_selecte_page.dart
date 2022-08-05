import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_pcr_tools/changeNotifier/theme_model.dart';

class ThemeSelectPage extends StatelessWidget {
  const ThemeSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题选择"),
      ),
      body: ListView.builder(
        itemCount: GlobalPres.themes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Container(
                color: GlobalPres.themes[index],
                height: 40,
              ),
            ),
            onTap: (){
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context,listen: false).theme = GlobalPres.themes[index];
            },
          );
        },
      ),
    );
  }
}
