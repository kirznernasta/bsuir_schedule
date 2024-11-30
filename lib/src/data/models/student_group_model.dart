import 'package:json_annotation/json_annotation.dart';

part 'student_group_model.g.dart';

@JsonSerializable(createToJson: false)
class StudentGroupModel {
  final String name;
  final int educationDegree;
  final String specialityName;
  final int? id;
  final int? course;
  final int? facultyId;
  final String? calendarId;
  final String? facultyAbbrev;
  final String? specialityAbbrev;

  const StudentGroupModel({
    required this.name,
    required this.specialityName,
    required this.educationDegree,
    this.id,
    this.course,
    this.facultyId,
    this.calendarId,
    this.facultyAbbrev,
    this.specialityAbbrev,
  });

  factory StudentGroupModel.fromJson(Map<String, dynamic> json) =>
      _$StudentGroupModelFromJson(json);
}
