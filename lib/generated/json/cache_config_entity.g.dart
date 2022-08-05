import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/cache_config_entity.dart';

CacheConfigEntity $CacheConfigEntityFromJson(Map<String, dynamic> json) {
	final CacheConfigEntity cacheConfigEntity = CacheConfigEntity();
	final bool? enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		cacheConfigEntity.enable = enable;
	}
	final int? maxAge = jsonConvert.convert<int>(json['maxAge']);
	if (maxAge != null) {
		cacheConfigEntity.maxAge = maxAge;
	}
	final int? maxCount = jsonConvert.convert<int>(json['maxCount']);
	if (maxCount != null) {
		cacheConfigEntity.maxCount = maxCount;
	}
	return cacheConfigEntity;
}

Map<String, dynamic> $CacheConfigEntityToJson(CacheConfigEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['enable'] = entity.enable;
	data['maxAge'] = entity.maxAge;
	data['maxCount'] = entity.maxCount;
	return data;
}