import 'package:flutter_application_pcr_tools/generated/json/base/json_field.dart';
import 'package:flutter_application_pcr_tools/generated/json/unit_server_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UnitServerInfoEntity {

	String? server;
	int? maxLevel;
	int? maxRank;
	int? maxLoveLevel;
	int? maxUniqueLevel;
	List<int>? rarity6Units;
	List<int>? uniqueEquipUnits;
	List<int>? limitedUnits;
	String? lastModified;
	int? maxSlots;
	UnitServerInfoLastModifyDict? lastModifyDict;
	List<List>? uniqueEquipmentRankup;
  
  UnitServerInfoEntity();

  factory UnitServerInfoEntity.fromJson(Map<String, dynamic> json) => $UnitServerInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnitServerInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnitServerInfoLastModifyDict {

	@JSONField(name: "UnitSourceDataJP")
	String? unitSourceDataJP;
	@JSONField(name: "UnitDatas")
	String? unitDatas;
	@JSONField(name: "EquipmentDatas")
	String? equipmentDatas;
	@JSONField(name: "EquipmentCrafts")
	String? equipmentCrafts;
	@JSONField(name: "AreaInfos")
	String? areaInfos;
	@JSONField(name: "UnitPromotions")
	String? unitPromotions;
	@JSONField(name: "EquipmentEnhanceRates")
	String? equipmentEnhanceRates;
	@JSONField(name: "EquipmentStatuses")
	String? equipmentStatuses;
	@JSONField(name: "ClanBattleInfos")
	String? clanBattleInfos;
  
  UnitServerInfoLastModifyDict();

  factory UnitServerInfoLastModifyDict.fromJson(Map<String, dynamic> json) => $UnitServerInfoLastModifyDictFromJson(json);

  Map<String, dynamic> toJson() => $UnitServerInfoLastModifyDictToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}