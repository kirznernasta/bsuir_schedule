import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/domain.dart';

part './favourite_employees_state.dart';

@lazySingleton
class FavouriteEmployeesCubit extends Cubit<FavouriteEmployeesState> {
  final FavouritesRepository _favouritesRepository;

  FavouriteEmployeesCubit(this._favouritesRepository)
      : super(FavouriteEmployeesInitial());

  Future<void> fetchFavouriteEmployees() async {
    emit(FavouriteEmployeesInProgress());

    final employeesIds = await _favouritesRepository.fetchFavourites(
      areGroups: false,
    );

    if (isClosed) return;

    emit(FavouriteEmployeesUpdate(employeesIds: employeesIds));
  }

  Future<void> addFavouriteEmployee(int id) async {
    emit(FavouriteEmployeesInProgress());

    await _favouritesRepository.addToFavourites(id, areGroups: false);

    final employeesIds = await _favouritesRepository.fetchFavourites(
      areGroups: false,
    );

    if (isClosed) return;

    emit(FavouriteEmployeesUpdate(employeesIds: employeesIds));
  }

  Future<void> deleteFavouriteEmployee(int id) async {
    emit(FavouriteEmployeesInProgress());

    await _favouritesRepository.deleteFromFavourites(id, areGroups: false);

    final employeesIds = await _favouritesRepository.fetchFavourites(
      areGroups: false,
    );

    if (isClosed) return;

    emit(FavouriteEmployeesUpdate(employeesIds: employeesIds));
  }
}
