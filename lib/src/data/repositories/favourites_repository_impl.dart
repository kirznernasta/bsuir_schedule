import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../data.dart';

@LazySingleton(as: FavouritesRepository)
class FavouritesRepositoryImpl implements FavouritesRepository {
  final ScheduleDataSource _scheduleDataSource;
  final AppSettingsLocalDataSource _appSettingsLocalDataSource;

  const FavouritesRepositoryImpl(
    this._scheduleDataSource,
    this._appSettingsLocalDataSource,
  );

  @override
  Future<List<int>> fetchFavourites({required bool areGroups}) async {
    final email = _appSettingsLocalDataSource.email;
    final passwordHash = _appSettingsLocalDataSource.passwordHash;

    if (email == null || passwordHash == null) return [];

    if (areGroups) {
      return _scheduleDataSource.fetchFavouriteGroupsIds(
        email: email,
        passwordHash: passwordHash,
      );
    }

    return _scheduleDataSource.fetchFavouriteEmployeeIds(
      email: email,
      passwordHash: passwordHash,
    );
  }

  @override
  Future<void> addToFavourites(int id, {required bool areGroups}) async {
    final email = _appSettingsLocalDataSource.email;
    final passwordHash = _appSettingsLocalDataSource.passwordHash;

    if (email == null || passwordHash == null) return;

    if (areGroups) {
      return _scheduleDataSource.addGroupToFavourite(
        id: id,
        email: email,
        passwordHash: passwordHash,
      );
    }

    return _scheduleDataSource.addEmployeeToFavourite(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }

  @override
  Future<void> deleteFromFavourites(int id, {required bool areGroups}) async {
    final email = _appSettingsLocalDataSource.email;
    final passwordHash = _appSettingsLocalDataSource.passwordHash;

    if (email == null || passwordHash == null) return;

    if (areGroups) {
      return _scheduleDataSource.deleteGroupFromFavourites(
        id: id,
        email: email,
        passwordHash: passwordHash,
      );
    }

    return _scheduleDataSource.deleteEmployeeFromFavourites(
      id: id,
      email: email,
      passwordHash: passwordHash,
    );
  }
}
