import 'package:flutter_application_pcr_tools/generated/json/base/json_field.dart';
import 'package:flutter_application_pcr_tools/generated/json/profile_entity.g.dart';
import 'dart:convert';

import 'package:flutter_application_pcr_tools/model/cache_config_entity.dart';

@JsonSerializable()
class ProfileEntity {
  String? user;
  String? token;
  int? theme;
  CacheConfigEntity? cache;
  String? lastLogin;
  String? locale;
  bool? openLinkInApp;

  ProfileEntity();

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      $ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProfileEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
