import '../domain.dart';

abstract class ScheduleRepository {
  Future<List<StudentGroupEntity>> fetchAllGroups();

  Future<List<EmployeeEntity>> fetchAllEmployees();
}
