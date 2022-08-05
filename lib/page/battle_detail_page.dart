import 'package:flutter/material.dart';
import 'package:flutter_application_pcr_tools/model/battle_team_entity.dart';
import 'package:flutter_application_pcr_tools/page/webview_page.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BattleDetailPage extends StatelessWidget {
  BattleDetailPage({Key? key, required this.battle}) : super(key: key);

  BattleTeamEntity battle;

  Widget _getLink(context, link) {
    var index = battle.links!.indexOf(link) + 1;
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            index.toString() + "、",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (GlobalPres.profile.openLinkInApp!) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return WebViewPage(
                            url: link[1].toString(),
                          );
                        },
                      ));
                    } else {
                      await launchUrlString(
                        link[1].toString(),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Text(
                    link[0].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                link[2].toString().isEmpty
                    ? Container()
                    : Text(
                        link[2].toString(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(battle.name.toString()),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text("阶段"),
              trailing: Text(battle.phase.toString()),
            ),
            ListTile(
              title: Text("boss"),
              trailing: Text(battle.boss.toString()),
            ),
            ListTile(
              title: Text("伤害"),
              trailing: Text(battle.damage.toString()),
            ),
            ListTile(
              title: Text("倍率"),
              trailing: Text(battle.pointRate.toString()),
            ),
            ListTile(
              title: Text("备注"),
              trailing: Text(battle.note.toString()),
            ),
            ListTile(
              title: Text("刀型"),
              trailing: Text(battle.auto != null
                  ? "自动"
                  : battle.tail != null
                      ? "尾刀"
                      : "手动"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: battle.links!.map((e) => _getLink(context, e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
