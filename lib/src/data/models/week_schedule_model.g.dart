// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekScheduleModel _$WeekScheduleModelFromJson(Map<String, dynamic> json) =>
    WeekScheduleModel(
      friday: (json['friday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      monday: (json['monday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['tuesday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['saturday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['thursday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['wednesday'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
