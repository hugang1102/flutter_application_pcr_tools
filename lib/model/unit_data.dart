import 'package:json_annotation/json_annotation.dart';

part 'unit_data.g.dart';

List<UnitData> getUnitDataList(List<dynamic> list) {
  List<UnitData> result = [];
  list.forEach((item) {
    result.add(UnitData.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class UnitData extends Object {
  @JsonKey(name: 'unitId')
  int? unitId;

  @JsonKey(name: 'unitName')
  String? unitName;

  @JsonKey(name: 'rarity')
  int? rarity;

  @JsonKey(name: 'searchAreaWidth')
  int? searchAreaWidth;

  @JsonKey(name: 'guildId')
  int? guildId;

  @JsonKey(name: 'comment')
  String comment;

  @JsonKey(name: 'atkType')
  int? atkType;

  @JsonKey(name: 'cutin1_Star6')
  int? cutin1Star6;

  @JsonKey(name: 'endTime')
  String? endTime;

  @JsonKey(name: 'icon')
  String? icon;

  UnitData(
    this.unitId,
    this.unitName,
    this.rarity,
    this.searchAreaWidth,
    this.guildId,
    this.comment,
    this.atkType,
    this.cutin1Star6,
    this.endTime,
    this.icon,
  );

  factory UnitData.fromJson(Map<String, dynamic> srcJson) =>
      _$UnitDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UnitDataToJson(this);
}
