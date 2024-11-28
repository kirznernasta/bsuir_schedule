class EmployeeEntity {
  final int id;
  final String urlId;
  final String imageUrl;
  final String lastName;
  final String firstName;
  final String? email;
  final String? middleName;
  final String? calendarId;

  const EmployeeEntity({
    required this.id,
    required this.urlId,
    required this.lastName,
    required this.imageUrl,
    required this.firstName,
    this.email,
    this.middleName,
    this.calendarId,
  });
}
