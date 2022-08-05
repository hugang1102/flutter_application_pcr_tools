// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitData _$UnitDataFromJson(Map<String, dynamic> json) => UnitData(
      json['unitId'] as int?,
      json['unitName'] as String?,
      json['rarity'] as int?,
      json['searchAreaWidth'] as int?,
      json['guildId'] as int?,
      json['comment'] as String,
      json['atkType'] as int?,
      json['cutin1_Star6'] as int?,
      json['endTime'] as String?,
      json['icon'] as String?,
    );

Map<String, dynamic> _$UnitDataToJson(UnitData instance) => <String, dynamic>{
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'rarity': instance.rarity,
      'searchAreaWidth': instance.searchAreaWidth,
      'guildId': instance.guildId,
      'comment': instance.comment,
      'atkType': instance.atkType,
      'cutin1_Star6': instance.cutin1Star6,
      'endTime': instance.endTime,
      'icon': instance.icon,
    };
