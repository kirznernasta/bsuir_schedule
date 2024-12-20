import 'package:json_annotation/json_annotation.dart';

part 'speciality_model.g.dart';

@JsonSerializable(createToJson: false)
class SpecialityModel {
  final int id;
  final String name;
  final String abbrev;
  final int facultyId;
  final String code;

  const SpecialityModel({
    required this.id,
    required this.name,
    required this.abbrev,
    required this.facultyId,
    required this.code,
  });

  factory SpecialityModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialityModelFromJson(json);
}
