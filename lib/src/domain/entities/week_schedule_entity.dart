import '../domain.dart';

class WeekScheduleEntity {
  final List<ScheduleItemEntity>? friday;
  final List<ScheduleItemEntity>? monday;
  final List<ScheduleItemEntity>? tuesday;
  final List<ScheduleItemEntity>? thursday;
  final List<ScheduleItemEntity>? saturday;
  final List<ScheduleItemEntity>? wednesday;

  const WeekScheduleEntity({
    this.friday,
    this.monday,
    this.tuesday,
    this.saturday,
    this.thursday,
    this.wednesday,
  });
}
