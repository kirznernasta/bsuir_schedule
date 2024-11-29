import '../../domain/domain.dart';
import '../data.dart';

class ScheduleMapper {
  const ScheduleMapper._();

  static ScheduleEntity fromModel(ScheduleModel model) {
    return ScheduleEntity(
      employee: model.employee == null
          ? null
          : EmployeeMapper.fromModel(model.employee!),
      schedules: model.schedules == null
          ? null
          : WeekScheduleMapper.fromModel(model.schedules!),
      startDate: model.startDate,
      endDate: model.endDate,
      startExamsDate: model.startExamsDate,
      endExamsDate: model.endExamsDate,
      studentGroup: model.studentGroup == null
          ? null
          : StudentGroupMapper.fromModel(model.studentGroup!),
    );
  }
}
