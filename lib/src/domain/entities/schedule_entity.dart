import '../domain.dart';

class ScheduleEntity {
  final EmployeeEntity? employee;
  final StudentGroupEntity? studentGroup;
  final WeekScheduleEntity? schedules;
  final String? startDate;
  final String? endDate;
  final String? startExamsDate;
  final String? endExamsDate;
  final List<ScheduleItemEntity>? exams;

  const ScheduleEntity({
    this.exams,
    this.endDate,
    this.employee,
    this.schedules,
    this.startDate,
    this.endExamsDate,
    this.studentGroup,
    this.startExamsDate,
  });
}
