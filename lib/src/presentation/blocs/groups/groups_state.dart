part of './groups_cubit.dart';

sealed class GroupsState {}

class GroupsInitial extends GroupsState {}

class GroupsInProgress extends GroupsState {}

class GroupsUpdate extends GroupsState {
  final List<StudentGroupEntity> allGroups;
  final List<StudentGroupEntity> filteredGroups;

  GroupsUpdate({required this.allGroups, required this.filteredGroups});
}
