import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/unit_nick_name_entity.dart';

UnitNickNameEntity $UnitNickNameEntityFromJson(Map<String, dynamic> json) {
	final UnitNickNameEntity unitNickNameEntity = UnitNickNameEntity();
	final int? unitId = jsonConvert.convert<int>(json['unitId']);
	if (unitId != null) {
		unitNickNameEntity.unitId = unitId;
	}
	final List<String>? nickNames = jsonConvert.convertListNotNull<String>(json['nickNames']);
	if (nickNames != null) {
		unitNickNameEntity.nickNames = nickNames;
	}
	final List<String>? requests = jsonConvert.convertListNotNull<String>(json['requests']);
	if (requests != null) {
		unitNickNameEntity.requests = requests;
	}
	return unitNickNameEntity;
}

Map<String, dynamic> $UnitNickNameEntityToJson(UnitNickNameEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['unitId'] = entity.unitId;
	data['nickNames'] =  entity.nickNames;
	data['requests'] =  entity.requests;
	return data;
}