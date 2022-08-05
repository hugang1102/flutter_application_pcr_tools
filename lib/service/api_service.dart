import 'package:flutter_application_pcr_tools/model/activity_event.dart';
import 'package:flutter_application_pcr_tools/model/unit_data.dart';
import 'package:flutter_application_pcr_tools/net/apis.dart';
import 'package:flutter_application_pcr_tools/net/request_client.dart';
import 'package:flutter_application_pcr_tools/net/result_data.dart';
import 'package:flutter_application_pcr_tools/service/battle_team_param.dart';

class ApiService {
  static Future getBattleTeam(BattleTeamParam params, {onError}) {
    return requestClient.get(
      NetApis.getBattleTeamsFromDoc(params.phase, params.boss),
      onError: onError,
    );
  }

  static Future<List<UnitData>> getUnitDatas() async {
    var r = await requestClient.get<ResultData>(NetApis.getUnitDatas());
    return getUnitDataList(r?.data);
  }

  static Future<List<ActivityEvents>> getActivityEvents() async {
    var r = await requestClient.get<ResultData>(NetApis.getEvents());
    return getActivityEventsList(r?.data);
  }
}
