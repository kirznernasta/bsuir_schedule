// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentGroupModel _$StudentGroupModelFromJson(Map<String, dynamic> json) =>
    StudentGroupModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      facultyId: (json['facultyId'] as num).toInt(),
      calendarId: json['calendarId'] as String,
      facultyAbbrev: json['facultyAbbrev'] as String,
      specialityName: json['specialityName'] as String,
      educationDegree: (json['educationDegree'] as num).toInt(),
      specialityAbbrev: json['specialityAbbrev'] as String,
      course: (json['course'] as num?)?.toInt(),
    );
