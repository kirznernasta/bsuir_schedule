part of './groups_cubit.dart';

sealed class GroupsState {}

class GroupsInitial extends GroupsState {}

class GroupsInProgress extends GroupsState {}

class GroupsUpdate extends GroupsState {
  final List<StudentGroupEntity> groups;

  GroupsUpdate({required this.groups});
}
