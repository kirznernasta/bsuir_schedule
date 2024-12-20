import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/domain.dart';

part './employees_state.dart';

@injectable
class EmployeesCubit extends Cubit<EmployeesState> {
  final ScheduleRepository _scheduleRepository;

  var _employees = <EmployeeEntity>[];

  EmployeesCubit(this._scheduleRepository) : super(EmployeesInitial());

  Future<void> fetchAllEmployees() async {
    emit(EmployeesInProgress());

    final employees = (await _scheduleRepository.fetchAllEmployees() ?? [])
      ..sort((a, b) => a.lastName.compareTo(b.lastName));
    _employees = employees;

    if (isClosed) return;

    emit(
      EmployeesUpdate(
        allEmployees: employees,
        filteredEmployees: employees,
      ),
    );
  }

  void filterEmployees(String searchInput) {
    final employees = _employees.where((employee) {
      final fullName = [
        employee.lastName,
        employee.firstName,
        if (employee.middleName != null) employee.middleName,
      ].join(' ').toLowerCase();

      return fullName.contains(searchInput.toLowerCase());
    });

    emit(
      EmployeesUpdate(
        allEmployees: _employees,
        filteredEmployees: employees.toList(),
      ),
    );
  }
}
