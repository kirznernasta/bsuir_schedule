// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleItemModel _$ScheduleItemModelFromJson(Map<String, dynamic> json) =>
    ScheduleItemModel(
      isSplit: json['split'] as bool,
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      auditories: (json['auditories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      weekNumbers: (json['weekNumber'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      endLessonDate: json['endLessonDate'] as String,
      endLessonTime: json['endLessonTime'] as String,
      studentGroups: (json['studentGroups'] as List<dynamic>)
          .map((e) => StudentGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subgroupNumber: (json['numSubgroup'] as num).toInt(),
      isAnnouncement: json['announcement'] as bool,
      startLessonDate: json['startLessonDate'] as String,
      startLessonTime: json['startLessonTime'] as String,
      subjectFullName: json['subjectFullName'] as String,
      lessonTypeAbbrev: json['lessonTypeAbbrev'] as String,
      subjectAbbreviationName: json['subject'] as String,
      note: json['note'] as String?,
    );
