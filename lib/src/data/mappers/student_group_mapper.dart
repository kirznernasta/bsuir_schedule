import '../../domain/domain.dart';
import '../data.dart';

class StudentGroupMapper {
  const StudentGroupMapper._();

  static StudentGroupEntity fromModel(StudentGroupModel model) {
    return StudentGroupEntity(
      id: model.id,
      name: model.name,
      course: model.course,
      facultyId: model.facultyId,
      calendarId: model.calendarId,
      facultyAbbrev: model.facultyAbbrev,
      specialityName: model.specialityName,
      educationDegree: model.educationDegree,
      specialityAbbrev: model.specialityAbbrev,
    );
  }

  static List<StudentGroupEntity> fromModels(List<StudentGroupModel> models) {
    return models.map((model) => fromModel(model)).toList();
  }
}
