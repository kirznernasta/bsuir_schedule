import 'package:injectable/injectable.dart';

import '../../data.dart';

@lazySingleton
class ScheduleDataSource {
  final ScheduleApiService _scheduleApiService;

  const ScheduleDataSource(this._scheduleApiService);

  Future<List<StudentGroupModel>> fetchAllGroups() {
    return _scheduleApiService.fetchAllGroups();
  }

  Future<List<EmployeeModel>> fetchAllEmployees() {
    return _scheduleApiService.fetchAllEmployees();
  }
}
