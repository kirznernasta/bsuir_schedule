// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      endDate: json['endDate'] as String?,
      employee: json['employeeDto'] == null
          ? null
          : EmployeeModel.fromJson(json['employeeDto'] as Map<String, dynamic>),
      schedules: json['schedules'] == null
          ? null
          : WeekScheduleModel.fromJson(
              json['schedules'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      endExamsDate: json['endExamsDate'] as String?,
      studentGroup: json['studentGroupDto'] == null
          ? null
          : StudentGroupModel.fromJson(
              json['studentGroupDto'] as Map<String, dynamic>),
      startExamsDate: json['startExamsDate'] as String?,
    );
