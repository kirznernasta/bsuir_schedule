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

  Future<ScheduleModel?> fetchGroupSchedule(String groupNumber) {
    return _scheduleApiService.fetchGroupSchedule(groupNumber);
  }

  Future<ScheduleModel?> fetchEmployeeSchedule(String urlId) {
    return _scheduleApiService.fetchEmployeeSchedule(urlId);
  }

  Future<bool> createUser({
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.createUser(
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<bool> findUser({
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.findUser(
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<List<int>> fetchFavouriteGroupsIds({
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.fetchFavouriteGroupsIds(
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<void> addGroupToFavourite({
    required int id,
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.addGroupToFavourite(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<void> deleteGroupFromFavourites({
    required int id,
    required String email,
    required String passwordHash,
  }){
    return _scheduleApiService.deleteGroupFromFavourites(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<List<int>> fetchFavouriteEmployeeIds({
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.fetchFavouriteEmployeesIds(
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<void> addEmployeeToFavourite({
    required int id,
    required String email,
    required String passwordHash,
  }) {
    return _scheduleApiService.addEmployeeToFavourite(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }

  Future<void> deleteEmployeeFromFavourites({
    required int id,
    required String email,
    required String passwordHash,
  }){
    return _scheduleApiService.deleteEmployeeFromFavourites(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }
}
