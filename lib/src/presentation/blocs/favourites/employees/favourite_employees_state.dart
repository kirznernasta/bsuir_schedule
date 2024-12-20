part of './favourite_employees_cubit.dart';

sealed class FavouriteEmployeesState {}

class FavouriteEmployeesInitial extends FavouriteEmployeesState {}

class FavouriteEmployeesInProgress extends FavouriteEmployeesState {}

class FavouriteEmployeesUpdate extends FavouriteEmployeesState {
  final List<int> employeesIds;

  FavouriteEmployeesUpdate({required this.employeesIds});
}
