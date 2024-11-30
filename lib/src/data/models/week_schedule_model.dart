import 'package:json_annotation/json_annotation.dart';

import '../data.dart';

part 'week_schedule_model.g.dart';

@JsonSerializable(createToJson: false)
class WeekScheduleModel {
  @JsonKey(name: 'Пятница')
  final List<ScheduleItemModel>? friday;
  @JsonKey(name: 'Понедельник')
  final List<ScheduleItemModel>? monday;
  @JsonKey(name: 'Вторник')
  final List<ScheduleItemModel>? tuesday;
  @JsonKey(name: 'Четверг')
  final List<ScheduleItemModel>? thursday;
  @JsonKey(name: 'Суббота')
  final List<ScheduleItemModel>? saturday;
  @JsonKey(name: 'Среда')
  final List<ScheduleItemModel>? wednesday;

  const WeekScheduleModel({
    this.friday,
    this.monday,
    this.tuesday,
    this.saturday,
    this.thursday,
    this.wednesday,
  });

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$WeekScheduleModelFromJson(json);
}
