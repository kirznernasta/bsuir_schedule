abstract class FavouritesRepository {
  Future<List<int>> fetchFavourites({required bool areGroups});

  Future<void> addToFavourites(int id, {required bool areGroups});

  Future<void> deleteFromFavourites(int id, {required bool areGroups});
}
