import 'package:json_annotation/json_annotation.dart';

import '../data.dart';

part 'week_schedule_model.g.dart';

@JsonSerializable(createToJson: false)
class WeekScheduleModel {
  final List<ScheduleItemModel> friday;
  final List<ScheduleItemModel> monday;
  final List<ScheduleItemModel> tuesday;
  final List<ScheduleItemModel> thursday;
  final List<ScheduleItemModel> saturday;
  final List<ScheduleItemModel> wednesday;

  const WeekScheduleModel({
    required this.friday,
    required this.monday,
    required this.tuesday,
    required this.saturday,
    required this.thursday,
    required this.wednesday,
  });

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$WeekScheduleModelFromJson(json);
}
