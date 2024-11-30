
import '../domain.dart';

class ScheduleItemEntity {
  final bool isSplit;
  final int subgroupNumber;
  final bool isAnnouncement;
  final String endLessonTime;
  final List<int> weekNumbers;
  final LessonType lessonType;
  final String startLessonTime;
  final String subjectFullName;
  final List<String> auditories;
  final String subjectAbbreviationName;
  final List<StudentGroupEntity> studentGroups;
  final String? note;
  final String? lessonDate;
  final String? endLessonDate;
  final String? startLessonDate;
  final List<EmployeeEntity>? employees;

  const ScheduleItemEntity({
    required this.isSplit,
    required this.auditories,
    required this.lessonType,
    required this.weekNumbers,
    required this.endLessonTime,
    required this.studentGroups,
    required this.subgroupNumber,
    required this.isAnnouncement,
    required this.startLessonTime,
    required this.subjectFullName,
    required this.subjectAbbreviationName,
    this.note,
    this.employees,
    this.lessonDate,
    this.endLessonDate,
    this.startLessonDate,
  });
}
