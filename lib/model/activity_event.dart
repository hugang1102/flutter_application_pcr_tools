import 'package:json_annotation/json_annotation.dart';

List<ActivityEvents> getActivityEventsList(List<dynamic> list) {
  List<ActivityEvents> result = [];
  list.forEach((item) {
    result.add(ActivityEvents.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class ActivityEvents extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'endTime')
  String endTime;

  ActivityEvents(
    this.id,
    this.type,
    this.title,
    this.startTime,
    this.endTime,
  );

  factory ActivityEvents.fromJson(Map<String, dynamic> srcJson) =>
      _$ActivityEventsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityEventsToJson(this);
}

ActivityEvents _$ActivityEventsFromJson(Map<String, dynamic> json) =>
    ActivityEvents(
      json['id'] as int,
      json['type'] as int,
      json['title'] as String,
      json['startTime'] as String,
      json['endTime'] as String,
    );

Map<String, dynamic> _$ActivityEventsToJson(ActivityEvents instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
