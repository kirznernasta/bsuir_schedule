import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable(createToJson: false)
class EmployeeModel {
  final int id;
  final String urlId;
  @JsonKey(name: 'photoLink')
  final String imageUrl;
  final String lastName;
  final String firstName;
  final String? email;
  final String? middleName;
  final String? calendarId;

  const EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.urlId,
    required this.id,
    this.email,
    this.middleName,
    this.calendarId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}
