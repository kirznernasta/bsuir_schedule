import 'package:json_annotation/json_annotation.dart';

import '../data.dart';

part 'schedule_item_model.g.dart';

@JsonSerializable(createToJson: false)
class ScheduleItemModel {
  @JsonKey(name: 'split')
  final bool isSplit;
  @JsonKey(name: 'numSubgroup')
  final int subgroupNumber;
  @JsonKey(name: 'announcement')
  final bool isAnnouncement;
  final String endLessonTime;
  final String endLessonDate;
  @JsonKey(name: 'weekNumber')
  final List<int> weekNumbers;
  final String startLessonTime;
  final String subjectFullName;
  final String startLessonDate;
  final List<String> auditories;
  final String lessonTypeAbbrev;
  final List<EmployeeModel> employees;
  @JsonKey(name: 'subject')
  final String subjectAbbreviationName;
  final List<StudentGroupModel> studentGroups;
  final String? note;

  const ScheduleItemModel({
    required this.isSplit,
    required this.employees,
    required this.auditories,
    required this.weekNumbers,
    required this.endLessonDate,
    required this.endLessonTime,
    required this.studentGroups,
    required this.subgroupNumber,
    required this.isAnnouncement,
    required this.startLessonDate,
    required this.startLessonTime,
    required this.subjectFullName,
    required this.lessonTypeAbbrev,
    required this.subjectAbbreviationName,
    this.note,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemModelFromJson(json);
}
