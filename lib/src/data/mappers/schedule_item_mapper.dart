import 'package:collection/collection.dart';

import '../../domain/domain.dart';
import '../data.dart';

class ScheduleItemMapper {
  const ScheduleItemMapper._();

  static ScheduleItemEntity fromModel(ScheduleItemModel model) {
    return ScheduleItemEntity(
      note: model.note,
      isSplit: model.isSplit,
      lessonDate: model.dateLesson,
      auditories: model.auditories,
      weekNumbers: model.weekNumbers,
      endLessonDate: model.endLessonDate,
      endLessonTime: model.endLessonTime,
      subgroupNumber: model.subgroupNumber,
      isAnnouncement: model.isAnnouncement,
      startLessonDate: model.startLessonDate,
      startLessonTime: model.startLessonTime,
      subjectFullName: model.subjectFullName,
      subjectAbbreviationName: model.subjectAbbreviationName,
      employees: EmployeeMapper.fromModels(model.employees),
      lessonType: _mapAbbreviationToLessonType(model.lessonTypeAbbrev),
      studentGroups: StudentGroupMapper.fromModels(model.studentGroups),
    );
  }

  static List<ScheduleItemEntity>? fromModels(List<ScheduleItemModel>? models) {
    return models
        ?.map((model) => fromModel(model))
        .sorted(
          (a, b) => DateTime.parse('2000-01-01T${a.startLessonTime}').compareTo(
            DateTime.parse('2000-01-01T${b.endLessonTime}'),
          ),
        )
        .toList();
  }

  static LessonType _mapAbbreviationToLessonType(String abbreviation) {
    return switch (abbreviation) {
      'ЛК' => LessonType.lecture,
      'ПЗ' => LessonType.practical,
      'ЛР' => LessonType.lab,
      'Экзамен' => LessonType.exam,
      'Консультация' => LessonType.consultation,
      _ => LessonType.unknown,
    };
  }
}
