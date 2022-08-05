import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/battle_team_entity.dart';

BattleTeamEntity $BattleTeamEntityFromJson(Map<String, dynamic> json) {
	final BattleTeamEntity battleTeamEntity = BattleTeamEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		battleTeamEntity.id = id;
	}
	final String? server = jsonConvert.convert<String>(json['server']);
	if (server != null) {
		battleTeamEntity.server = server;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		battleTeamEntity.name = name;
	}
	final String? phase = jsonConvert.convert<String>(json['phase']);
	if (phase != null) {
		battleTeamEntity.phase = phase;
	}
	final int? boss = jsonConvert.convert<int>(json['boss']);
	if (boss != null) {
		battleTeamEntity.boss = boss;
	}
	final String? note = jsonConvert.convert<String>(json['note']);
	if (note != null) {
		battleTeamEntity.note = note;
	}
	final int? damage = jsonConvert.convert<int>(json['damage']);
	if (damage != null) {
		battleTeamEntity.damage = damage;
	}
	final double? pointRate = jsonConvert.convert<double>(json['pointRate']);
	if (pointRate != null) {
		battleTeamEntity.pointRate = pointRate;
	}
	final List<int>? unitIds = jsonConvert.convertListNotNull<int>(json['unitIds']);
	if (unitIds != null) {
		battleTeamEntity.unitIds = unitIds;
	}
	final bool? auto = jsonConvert.convert<bool>(json['auto']);
	if (auto != null) {
		battleTeamEntity.auto = auto;
	}
	final bool? tail = jsonConvert.convert<bool>(json['tail']);
	if (tail != null) {
		battleTeamEntity.tail = tail;
	}
	final bool? fromDoc = jsonConvert.convert<bool>(json['fromDoc']);
	if (fromDoc != null) {
		battleTeamEntity.fromDoc = fromDoc;
	}
	final List<List>? links = jsonConvert.convertListNotNull<List>(json['links']);
	if (links != null) {
		battleTeamEntity.links = links;
	}
	return battleTeamEntity;
}

Map<String, dynamic> $BattleTeamEntityToJson(BattleTeamEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['server'] = entity.server;
	data['name'] = entity.name;
	data['phase'] = entity.phase;
	data['boss'] = entity.boss;
	data['note'] = entity.note;
	data['damage'] = entity.damage;
	data['pointRate'] = entity.pointRate;
	data['unitIds'] =  entity.unitIds;
	data['auto'] = entity.auto;
	data['tail'] = entity.tail;
	data['fromDoc'] = entity.fromDoc;
	data['links'] =  entity.links;
	return data;
}