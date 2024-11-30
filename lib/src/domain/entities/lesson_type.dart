enum LessonType {
  lab(true),
  exam(false),
  lecture(true),
  practical(true),
  consultation(false),
  unknown(false);

  final bool isRegularType;

  const LessonType(this.isRegularType);
}
