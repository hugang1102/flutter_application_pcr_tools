import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/unit_server_info_entity.dart';

UnitServerInfoEntity $UnitServerInfoEntityFromJson(Map<String, dynamic> json) {
	final UnitServerInfoEntity unitServerInfoEntity = UnitServerInfoEntity();
	final String? server = jsonConvert.convert<String>(json['server']);
	if (server != null) {
		unitServerInfoEntity.server = server;
	}
	final int? maxLevel = jsonConvert.convert<int>(json['maxLevel']);
	if (maxLevel != null) {
		unitServerInfoEntity.maxLevel = maxLevel;
	}
	final int? maxRank = jsonConvert.convert<int>(json['maxRank']);
	if (maxRank != null) {
		unitServerInfoEntity.maxRank = maxRank;
	}
	final int? maxLoveLevel = jsonConvert.convert<int>(json['maxLoveLevel']);
	if (maxLoveLevel != null) {
		unitServerInfoEntity.maxLoveLevel = maxLoveLevel;
	}
	final int? maxUniqueLevel = jsonConvert.convert<int>(json['maxUniqueLevel']);
	if (maxUniqueLevel != null) {
		unitServerInfoEntity.maxUniqueLevel = maxUniqueLevel;
	}
	final List<int>? rarity6Units = jsonConvert.convertListNotNull<int>(json['rarity6Units']);
	if (rarity6Units != null) {
		unitServerInfoEntity.rarity6Units = rarity6Units;
	}
	final List<int>? uniqueEquipUnits = jsonConvert.convertListNotNull<int>(json['uniqueEquipUnits']);
	if (uniqueEquipUnits != null) {
		unitServerInfoEntity.uniqueEquipUnits = uniqueEquipUnits;
	}
	final List<int>? limitedUnits = jsonConvert.convertListNotNull<int>(json['limitedUnits']);
	if (limitedUnits != null) {
		unitServerInfoEntity.limitedUnits = limitedUnits;
	}
	final String? lastModified = jsonConvert.convert<String>(json['lastModified']);
	if (lastModified != null) {
		unitServerInfoEntity.lastModified = lastModified;
	}
	final int? maxSlots = jsonConvert.convert<int>(json['maxSlots']);
	if (maxSlots != null) {
		unitServerInfoEntity.maxSlots = maxSlots;
	}
	final UnitServerInfoLastModifyDict? lastModifyDict = jsonConvert.convert<UnitServerInfoLastModifyDict>(json['lastModifyDict']);
	if (lastModifyDict != null) {
		unitServerInfoEntity.lastModifyDict = lastModifyDict;
	}
	final List<List>? uniqueEquipmentRankup = jsonConvert.convertListNotNull<List>(json['uniqueEquipmentRankup']);
	if (uniqueEquipmentRankup != null) {
		unitServerInfoEntity.uniqueEquipmentRankup = uniqueEquipmentRankup;
	}
	return unitServerInfoEntity;
}

Map<String, dynamic> $UnitServerInfoEntityToJson(UnitServerInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['server'] = entity.server;
	data['maxLevel'] = entity.maxLevel;
	data['maxRank'] = entity.maxRank;
	data['maxLoveLevel'] = entity.maxLoveLevel;
	data['maxUniqueLevel'] = entity.maxUniqueLevel;
	data['rarity6Units'] =  entity.rarity6Units;
	data['uniqueEquipUnits'] =  entity.uniqueEquipUnits;
	data['limitedUnits'] =  entity.limitedUnits;
	data['lastModified'] = entity.lastModified;
	data['maxSlots'] = entity.maxSlots;
	data['lastModifyDict'] = entity.lastModifyDict?.toJson();
	data['uniqueEquipmentRankup'] =  entity.uniqueEquipmentRankup;
	return data;
}

UnitServerInfoLastModifyDict $UnitServerInfoLastModifyDictFromJson(Map<String, dynamic> json) {
	final UnitServerInfoLastModifyDict unitServerInfoLastModifyDict = UnitServerInfoLastModifyDict();
	final String? unitSourceDataJP = jsonConvert.convert<String>(json['UnitSourceDataJP']);
	if (unitSourceDataJP != null) {
		unitServerInfoLastModifyDict.unitSourceDataJP = unitSourceDataJP;
	}
	final String? unitDatas = jsonConvert.convert<String>(json['UnitDatas']);
	if (unitDatas != null) {
		unitServerInfoLastModifyDict.unitDatas = unitDatas;
	}
	final String? equipmentDatas = jsonConvert.convert<String>(json['EquipmentDatas']);
	if (equipmentDatas != null) {
		unitServerInfoLastModifyDict.equipmentDatas = equipmentDatas;
	}
	final String? equipmentCrafts = jsonConvert.convert<String>(json['EquipmentCrafts']);
	if (equipmentCrafts != null) {
		unitServerInfoLastModifyDict.equipmentCrafts = equipmentCrafts;
	}
	final String? areaInfos = jsonConvert.convert<String>(json['AreaInfos']);
	if (areaInfos != null) {
		unitServerInfoLastModifyDict.areaInfos = areaInfos;
	}
	final String? unitPromotions = jsonConvert.convert<String>(json['UnitPromotions']);
	if (unitPromotions != null) {
		unitServerInfoLastModifyDict.unitPromotions = unitPromotions;
	}
	final String? equipmentEnhanceRates = jsonConvert.convert<String>(json['EquipmentEnhanceRates']);
	if (equipmentEnhanceRates != null) {
		unitServerInfoLastModifyDict.equipmentEnhanceRates = equipmentEnhanceRates;
	}
	final String? equipmentStatuses = jsonConvert.convert<String>(json['EquipmentStatuses']);
	if (equipmentStatuses != null) {
		unitServerInfoLastModifyDict.equipmentStatuses = equipmentStatuses;
	}
	final String? clanBattleInfos = jsonConvert.convert<String>(json['ClanBattleInfos']);
	if (clanBattleInfos != null) {
		unitServerInfoLastModifyDict.clanBattleInfos = clanBattleInfos;
	}
	return unitServerInfoLastModifyDict;
}

Map<String, dynamic> $UnitServerInfoLastModifyDictToJson(UnitServerInfoLastModifyDict entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['UnitSourceDataJP'] = entity.unitSourceDataJP;
	data['UnitDatas'] = entity.unitDatas;
	data['EquipmentDatas'] = entity.equipmentDatas;
	data['EquipmentCrafts'] = entity.equipmentCrafts;
	data['AreaInfos'] = entity.areaInfos;
	data['UnitPromotions'] = entity.unitPromotions;
	data['EquipmentEnhanceRates'] = entity.equipmentEnhanceRates;
	data['EquipmentStatuses'] = entity.equipmentStatuses;
	data['ClanBattleInfos'] = entity.clanBattleInfos;
	return data;
}