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
      print('Get employees error: $e');
    }

    return employees;
  }

  Future<ScheduleModel?> fetchGroupSchedule(String groupNumber) async {
    ScheduleModel? schedule;

    try {
      final response = await _dio.get('schedule?studentGroup=$groupNumber');

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data;

        schedule = ScheduleModel.fromJson(responseData as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      print('Get student group schedule error: $e');
    }

    return schedule;
  }

  Future<ScheduleModel?> fetchEmployeeSchedule(String urlId) async {
    ScheduleModel? schedule;

    try {
      final response = await _dio.get('schedule/$urlId');

      if (response.statusCode == HttpStatus.ok) {
        final responseData = response.data;

        schedule = ScheduleModel.fromJson(responseData as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      print('Get employee schedule error: $e');
    }

    return schedule;
  }
}
