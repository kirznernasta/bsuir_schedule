
import '../domain.dart';

class ScheduleItemEntity {
  final bool isSplit;
  final int subgroupNumber;
  final bool isAnnouncement;
  final String endLessonTime;
  final String endLessonDate;
  final List<int> weekNumbers;
  final String startLessonTime;
  final String subjectFullName;
  final String startLessonDate;
  final List<String> auditories;
  final String lessonTypeAbbrev;
  final List<EmployeeEntity> employees;
  final String subjectAbbreviationName;
  final List<StudentGroupEntity> studentGroups;
  final String? note;

  const ScheduleItemEntity({
    required this.isSplit,
    required this.employees,
    required this.auditories,
    required this.weekNumbers,
    required this.endLessonDate,
    required this.endLessonTime,
    required this.studentGroups,
    required this.subgroupNumber,
    required this.isAnnouncement,
    required this.startLessonDate,
    required this.startLessonTime,
    required this.subjectFullName,
    required this.lessonTypeAbbrev,
    required this.subjectAbbreviationName,
    this.note,
  });
}
