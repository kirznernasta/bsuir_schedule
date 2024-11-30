part of './schedule_cubit.dart';

sealed class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleInProgress extends ScheduleState {}

class ScheduleUpdate extends ScheduleState {
  final ScheduleEntity? schedule;

  ScheduleUpdate({this.schedule});
}
