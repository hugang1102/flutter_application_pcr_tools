import 'package:flutter_application_pcr_tools/generated/json/base/json_field.dart';
import 'package:flutter_application_pcr_tools/generated/json/battle_team_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class BattleTeamEntity {

	int? id;
	String? server;
	String? name;
	String? phase;
	int? boss;
	String? note;
	int? damage;
	double? pointRate;
	List<int>? unitIds;
	bool? auto; // 自动
	bool? tail; // 尾刀
	bool? fromDoc;
	List<List>? links;
  
  BattleTeamEntity();

  factory BattleTeamEntity.fromJson(Map<String, dynamic> json) => $BattleTeamEntityFromJson(json);

  Map<String, dynamic> toJson() => $BattleTeamEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}