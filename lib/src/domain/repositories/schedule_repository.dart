import '../domain.dart';

abstract class ScheduleRepository {
  Future<List<StudentGroupEntity>> fetchAllGroups();

  Future<List<EmployeeEntity>> fetchAllEmployees();

  Future<ScheduleEntity?> fetchGroupSchedule(String groupNumber);

  Future<ScheduleEntity?> fetchEmployeeSchedule(String urlId);
}
