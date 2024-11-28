import 'dart:io';

import 'package:dio/dio.dart';

import '../data.dart';

// ignore_for_file: avoid_print
class ScheduleApiService {
  final Dio _dio;

  const ScheduleApiService(this._dio);

  Future<List<StudentGroupModel>> fetchAllGroups() async {
    List<StudentGroupModel> groups = [];

    try {
      final response = await _dio.get('/student-groups');

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data as List<dynamic>;

        groups = responseData
            .map(
              (json) =>
                  StudentGroupModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } on DioException catch (e) {
      print('Get student groups error: $e');
    }

    return groups;
  }

  Future<List<EmployeeModel>> fetchAllEmployees() async {
    List<EmployeeModel> employees = [];

    try {
      final response = await _dio.get('/employees/all');

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data as List<dynamic>;

        employees = responseData
            .map(
              (json) => EmployeeModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } on DioException catch (e) {
      print('Get student groups error: $e');
    }

    return employees;
  }
}
