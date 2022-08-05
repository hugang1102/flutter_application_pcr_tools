import 'package:flutter_application_pcr_tools/generated/json/base/json_field.dart';
import 'package:flutter_application_pcr_tools/generated/json/unit_nick_name_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UnitNickNameEntity {

	int? unitId;
	List<String>? nickNames;
	List<String>? requests;
  
  UnitNickNameEntity();

  factory UnitNickNameEntity.fromJson(Map<String, dynamic> json) => $UnitNickNameEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnitNickNameEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}