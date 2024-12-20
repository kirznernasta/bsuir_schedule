// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['photoLink'] as String,
      urlId: json['urlId'] as String,
      id: (json['id'] as num).toInt(),
      fio: json['fio'] as String?,
      email: json['email'] as String?,
      middleName: json['middleName'] as String?,
      calendarId: json['calendarId'] as String?,
    );
