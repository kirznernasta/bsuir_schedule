import 'package:json_annotation/json_annotation.dart';

import '../data.dart';

part 'schedule_model.g.dart';

@JsonSerializable(createToJson: false)
class ScheduleModel {
  @JsonKey(name: 'employeeDto')
  final EmployeeModel? employee;
  @JsonKey(name: 'studentGroupDto')
  final StudentGroupModel? studentGroup;
  final WeekScheduleModel? schedules;
  final String? startDate;
  final String? endDate;
  final String? startExamsDate;
  final String? endExamsDate;
  final List<ScheduleItemModel>? exams;

  const ScheduleModel({
    this.exams,
    this.endDate,
    this.employee,
    this.schedules,
    this.startDate,
    this.endExamsDate,
    this.studentGroup,
    this.startExamsDate,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}
