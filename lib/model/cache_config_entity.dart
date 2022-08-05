import 'package:flutter_application_pcr_tools/generated/json/base/json_field.dart';
import 'package:flutter_application_pcr_tools/generated/json/cache_config_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CacheConfigEntity {

	late bool enable;
	late int maxAge;
	late int maxCount;
  
  CacheConfigEntity();

  factory CacheConfigEntity.fromJson(Map<String, dynamic> json) => $CacheConfigEntityFromJson(json);

  Map<String, dynamic> toJson() => $CacheConfigEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}