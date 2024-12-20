part of './employees_cubit.dart';

sealed class EmployeesState {}

class EmployeesInitial extends EmployeesState {}

class EmployeesInProgress extends EmployeesState {}

class EmployeesUpdate extends EmployeesState {
  final List<EmployeeEntity> allEmployees;
  final List<EmployeeEntity> filteredEmployees;

  EmployeesUpdate({
    required this.allEmployees,
    required this.filteredEmployees,
  });
}
