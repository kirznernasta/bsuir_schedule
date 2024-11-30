class StudentGroupEntity {
  final String name;
  final int educationDegree;
  final String specialityName;
  final int? id;
  final int? course;
  final int? facultyId;
  final String? calendarId;
  final String? facultyAbbrev;
  final String? specialityAbbrev;

  const StudentGroupEntity({
    required this.name,
    required this.specialityName,
    required this.educationDegree,
    this.id,
    this.course,
    this.facultyId,
    this.calendarId,
    this.facultyAbbrev,
    this.specialityAbbrev,
  });
}
