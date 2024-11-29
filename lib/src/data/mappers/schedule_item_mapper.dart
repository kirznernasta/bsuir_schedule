import '../../domain/domain.dart';
import '../data.dart';

class ScheduleItemMapper {
  const ScheduleItemMapper._();

  static ScheduleItemEntity fromModel(ScheduleItemModel model) {
    return ScheduleItemEntity(
      isSplit: model.isSplit,
      employees: EmployeeMapper.fromModels(model.employees),
      auditories: model.auditories,
      weekNumbers: model.weekNumbers,
      endLessonDate: model.endLessonDate,
      endLessonTime: model.endLessonTime,
      studentGroups: StudentGroupMapper.fromModels(model.studentGroups),
      subgroupNumber: model.subgroupNumber,
      isAnnouncement: model.isAnnouncement,
      startLessonDate: model.startLessonDate,
      startLessonTime: model.startLessonTime,
      subjectFullName: model.subjectFullName,
      lessonTypeAbbrev: model.lessonTypeAbbrev,
      subjectAbbreviationName: model.subjectAbbreviationName,
      note: model.note,
    );
  }

  static List<ScheduleItemEntity> fromModels(List<ScheduleItemModel> models) {
    return models.map((model) => fromModel(model)).toList();
  }
}
