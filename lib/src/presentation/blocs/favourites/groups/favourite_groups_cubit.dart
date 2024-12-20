import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/domain.dart';

part './favourite_groups_state.dart';

@lazySingleton
class FavouriteGroupsCubit extends Cubit<FavouriteGroupsState> {
  final FavouritesRepository _favouritesRepository;

  FavouriteGroupsCubit(this._favouritesRepository)
      : super(FavouriteGroupsInitial());

  Future<void> fetchFavouriteGroups() async {
    emit(FavouriteGroupsInProgress());

    final groupsIds = await _favouritesRepository.fetchFavourites(
      areGroups: true,
    );

    if (isClosed) return;

    emit(FavouriteGroupsUpdate(groupsIds: groupsIds));
  }

  Future<void> addFavouriteGroup(int id) async {
    emit(FavouriteGroupsInProgress());

    await _favouritesRepository.addToFavourites(id, areGroups: true);

    final groupsIds = await _favouritesRepository.fetchFavourites(
      areGroups: true,
    );

    if (isClosed) return;

    emit(FavouriteGroupsUpdate(groupsIds: groupsIds));
  }

  Future<void> deleteFavouriteGroup(int id) async {
    emit(FavouriteGroupsInProgress());

    await _favouritesRepository.deleteFromFavourites(id, areGroups: true);

    final groupsIds = await _favouritesRepository.fetchFavourites(
      areGroups: true,
    );

    if (isClosed) return;

    emit(FavouriteGroupsUpdate(groupsIds: groupsIds));
  }
}
