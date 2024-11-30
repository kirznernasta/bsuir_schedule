// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentGroupModel _$StudentGroupModelFromJson(Map<String, dynamic> json) =>
    StudentGroupModel(
      name: json['name'] as String,
      specialityName: json['specialityName'] as String,
      educationDegree: (json['educationDegree'] as num).toInt(),
      id: (json['id'] as num?)?.toInt(),
      course: (json['course'] as num?)?.toInt(),
      facultyId: (json['facultyId'] as num?)?.toInt(),
      calendarId: json['calendarId'] as String?,
      facultyAbbrev: json['facultyAbbrev'] as String?,
      specialityAbbrev: json['specialityAbbrev'] as String?,
    );
