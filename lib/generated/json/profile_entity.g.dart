import 'package:flutter_application_pcr_tools/generated/json/base/json_convert_content.dart';
import 'package:flutter_application_pcr_tools/model/cache_config_entity.dart';
import 'package:flutter_application_pcr_tools/model/profile_entity.dart';

ProfileEntity $ProfileEntityFromJson(Map<String, dynamic> json) {
	final ProfileEntity profileEntity = ProfileEntity();
	final String? user = jsonConvert.convert<String>(json['user']);
	if (user != null) {
		profileEntity.user = user;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		profileEntity.token = token;
	}
	final int? theme = jsonConvert.convert<int>(json['theme']);
	if (theme != null) {
		profileEntity.theme = theme;
	}
	final CacheConfigEntity? cache = jsonConvert.convert<CacheConfigEntity>(json['cache']);
	if (cache != null) {
		profileEntity.cache = cache;
	}
	final String? lastLogin = jsonConvert.convert<String>(json['lastLogin']);
	if (lastLogin != null) {
		profileEntity.lastLogin = lastLogin;
	}
	final String? locale = jsonConvert.convert<String>(json['locale']);
	if (locale != null) {
		profileEntity.locale = locale;
	}
	return profileEntity;
}

Map<String, dynamic> $ProfileEntityToJson(ProfileEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user;
	data['token'] = entity.token;
	data['theme'] = entity.theme;
	data['cache'] = entity.cache;
	data['lastLogin'] = entity.lastLogin;
	data['locale'] = entity.locale;
	return data;
}