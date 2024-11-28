import 'package:json_annotation/json_annotation.dart';

part 'student_group_model.g.dart';

@JsonSerializable(createToJson: false)
class StudentGroupModel {
  final int id;
  final int? course;
  final String name;
  final int facultyId;
  final String calendarId;
  final int educationDegree;
  final String facultyAbbrev;
  final String specialityName;
  final String specialityAbbrev;

  const StudentGroupModel({
    required this.id,
    required this.name,
    required this.facultyId,
    required this.calendarId,
    required this.facultyAbbrev,
    required this.specialityName,
    required this.educationDegree,
    required this.specialityAbbrev,
    this.course,
  });

  factory StudentGroupModel.fromJson(Map<String, dynamic> json) =>
      _$StudentGroupModelFromJson(json);
}
