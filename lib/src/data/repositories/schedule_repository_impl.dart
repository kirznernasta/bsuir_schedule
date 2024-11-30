import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../data.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource _scheduleDataSource;

  const ScheduleRepositoryImpl(this._scheduleDataSource);

  @override
  Future<List<StudentGroupEntity>> fetchAllGroups() async {
    final groupModels = await _scheduleDataSource.fetchAllGroups();

    return StudentGroupMapper.fromModels(groupModels);
  }

  @override
  Future<List<EmployeeEntity>?> fetchAllEmployees() async {
    final employeeModels = await _scheduleDataSource.fetchAllEmployees();

    return EmployeeMapper.fromModels(employeeModels);
  }

  @override
  Future<ScheduleEntity?> fetchEmployeeSchedule(String urlId) async {
    final model = await _scheduleDataSource.fetchEmployeeSchedule(urlId);

    if (model == null) return null;

    return ScheduleMapper.fromModel(model);
  }

  @override
  Future<ScheduleEntity?> fetchGroupSchedule(String groupNumber) async {
    final model = await _scheduleDataSource.fetchGroupSchedule(groupNumber);

    if (model == null) return null;

    return ScheduleMapper.fromModel(model);
  }
}
