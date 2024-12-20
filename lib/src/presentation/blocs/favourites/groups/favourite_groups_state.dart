part of './favourite_groups_cubit.dart';

sealed class FavouriteGroupsState {}

class FavouriteGroupsInitial extends FavouriteGroupsState {}

class FavouriteGroupsInProgress extends FavouriteGroupsState {}

class FavouriteGroupsUpdate extends FavouriteGroupsState {
  final List<int> groupsIds;

  FavouriteGroupsUpdate({required this.groupsIds});
}
