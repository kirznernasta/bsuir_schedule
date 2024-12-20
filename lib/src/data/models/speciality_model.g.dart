// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialityModel _$SpecialityModelFromJson(Map<String, dynamic> json) =>
    SpecialityModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      abbrev: json['abbrev'] as String,
      facultyId: (json['facultyId'] as num).toInt(),
      code: json['code'] as String,
    );
