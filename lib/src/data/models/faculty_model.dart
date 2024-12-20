import 'package:json_annotation/json_annotation.dart';

part 'faculty_model.g.dart';

@JsonSerializable(createToJson: false)
class FacultyModel {
  final int id;
  final String name;
  final String abbrev;

  const FacultyModel({
    required this.id,
    required this.name,
    required this.abbrev,
  });


  factory FacultyModel.fromJson(Map<String, dynamic> json) =>
      _$FacultyModelFromJson(json);
}
