import '../../domain/domain.dart';
import '../data.dart';

class WeekScheduleMapper {
  const WeekScheduleMapper._();

  static WeekScheduleEntity fromModel(WeekScheduleModel model) {
    return WeekScheduleEntity(
      friday: ScheduleItemMapper.fromModels(model.friday),
      monday: ScheduleItemMapper.fromModels(model.monday),
      tuesday: ScheduleItemMapper.fromModels(model.tuesday),
      saturday: ScheduleItemMapper.fromModels(model.saturday),
      thursday: ScheduleItemMapper.fromModels(model.thursday),
      wednesday: ScheduleItemMapper.fromModels(model.wednesday),
    );
  }
}
