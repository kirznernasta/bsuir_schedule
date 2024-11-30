import '../../domain/domain.dart';
import '../data.dart';

class EmployeeMapper {
  const EmployeeMapper._();

  static EmployeeEntity fromModel(EmployeeModel model) {
    return EmployeeEntity(
      id: model.id,
      urlId: model.urlId,
      email: model.email,
      lastName: model.lastName,
      imageUrl: model.imageUrl,
      firstName: model.firstName,
      middleName: model.middleName,
      calendarId: model.calendarId,
    );
  }

  static List<EmployeeEntity>? fromModels(List<EmployeeModel>? models) {
    if (models == null){
      return null;
    }

    return models.map((model) => fromModel(model)).toList();
  }
}
