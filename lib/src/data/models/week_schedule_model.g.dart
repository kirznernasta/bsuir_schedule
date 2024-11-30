// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekScheduleModel _$WeekScheduleModelFromJson(Map<String, dynamic> json) =>
    WeekScheduleModel(
      friday: (json['Пятница'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      monday: (json['Понедельник'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['Вторник'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['Суббота'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['Четверг'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['Среда'] as List<dynamic>?)
          ?.map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
