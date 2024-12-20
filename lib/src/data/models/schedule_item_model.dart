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
  @JsonKey(name: 'weekNumber')
  final List<int> weekNumbers;
  final String startLessonTime;
  final String subjectFullName;
  final List<String> auditories;
  final String lessonTypeAbbrev;
  @JsonKey(name: 'subject')
  final String subjectAbbreviationName;
  final List<StudentGroupModel> studentGroups;
  final String? note;
  final String? dateLesson;
  final String? endLessonDate;
  final String? startLessonDate;
  final List<EmployeeModel>? employees;

  ScheduleItemModel({
    required this.isSplit,
    required this.auditories,
    required this.endLessonTime,
    required this.studentGroups,
    required this.subgroupNumber,
    required this.isAnnouncement,
    required this.startLessonTime,
    this.subjectFullName = '',
    this.lessonTypeAbbrev = '',
    this.subjectAbbreviationName = '',
    this.weekNumbers = const [],
    this.note,
    this.dateLesson,
    this.employees,
    this.endLessonDate,
    this.startLessonDate,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemModelFromJson(json);

  @override
  String toString() {
    return 'subgroupNumber: $subgroupNumber, auditories: $auditories, weekNumbers: $weekNumbers, $startLessonTime-$endLessonTime, $startLessonDate-$endLessonDate, $subjectFullName, ${employees?.map((e) => e.fio)} ';
  }
}
