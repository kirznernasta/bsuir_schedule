import '../domain.dart';

class WeekScheduleEntity {
  final List<ScheduleItemEntity> friday;
  final List<ScheduleItemEntity> monday;
  final List<ScheduleItemEntity> tuesday;
  final List<ScheduleItemEntity> thursday;
  final List<ScheduleItemEntity> saturday;
  final List<ScheduleItemEntity> wednesday;

  const WeekScheduleEntity({
    required this.friday,
    required this.monday,
    required this.tuesday,
    required this.saturday,
    required this.thursday,
    required this.wednesday,
  });
}
