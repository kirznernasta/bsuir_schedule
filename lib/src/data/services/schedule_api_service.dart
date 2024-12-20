import 'package:dio/dio.dart';
import 'package:postgres/postgres.dart';

import '../data.dart';
import '../models/models.dart';

// ignore_for_file: avoid_print
// ignore_for_file: avoid_dynamic_calls
class ScheduleApiService {
  late final Connection _connection;

  ScheduleApiService(this._connection);

  Future<List<StudentGroupModel>> fetchAllGroups() async {
    final List<StudentGroupModel> groups = [];

    try {
      final result = await _connection.execute('''
        SELECT
    g.id AS "groupId",
    g.name AS "groupName",
    g.course AS "course",
    g.calendar_id AS "calendarId",
    g.education_degree AS "educationDegree",
    s.id AS "specialityId",
    s.name AS "specialityName",
    s.abbrev AS "specialityAbbrev",
    f.id AS "facultyId",
    f.name AS "facultyName",
    f.abbrev AS "facultyAbbrev"
FROM
    groups g
        JOIN
    specialities s ON g.speciality_id = s.id
        JOIN
    faculties f ON s.faculty_id = f.id
ORDER BY
    g.name;
        ''');

      for (final group in result) {
        groups.add(
          StudentGroupModel(
            id: group[0] as int?,
            name: (group[1] ?? '') as String,
            course: group[2] as int?,
            calendarId: group[3] as String?,
            educationDegree: (group[4] ?? 1) as int,
            specialityName: (group[6] ?? '') as String,
            specialityAbbrev: group[7] as String?,
            facultyAbbrev: group[10] as String?,
          ),
        );
      }
    } on Exception catch (e) {
      print('Get student groups error: $e');
    }

    return groups;
  }

  // Future<void> _insertItem(
  //   Connection conn,
  //   StudentGroupModel group,
  //   ScheduleItemModel item,
  //   int weekday,
  // ) async {
  //   final lessonTypeId = switch (item.lessonTypeAbbrev) {
  //     'ЛК' => 1,
  //     'ЛР' => 2,
  //     'ПЗ' => 3,
  //     'Экзамен' => 4,
  //     'Консультация' => 5,
  //     _ => 6,
  //   };
  //
  //   final values =
  //       "(ARRAY[${item.auditories.map((e) => "'$e'").join(',')}], '${item.startLessonTime}', '${item.endLessonTime}', ${item.subgroupNumber}, $lessonTypeId, ARRAY[${item.weekNumbers.map((e) => e).join(',')}], ${item.dateLesson == null ? 'NULL' : "'${item.dateLesson}'"}, ${item.startLessonDate == null ? 'NULL' : "'${item.startLessonDate}'"}, ${item.endLessonDate == null ? 'NULL' : "'${item.endLessonDate}'"}, $weekday, '${item.subjectAbbreviationName}', '${item.subjectFullName}')";
  //
  //   final employees = item.employees;
  //   var employeesSql = '';
  //
  //   if (employees != null) {
  //     final employeeValues = employees.map((e) => '(s_id, ${e.id})').join(',');
  //
  //     employeesSql = '''
  //                     INSERT INTO schedule_employees (schedule_id, employee_id)
  //                         VALUES
  //                         $employeeValues
  //                         ON CONFLICT (schedule_id, employee_id)
  //                         DO NOTHING;
  //                     ''';
  //   }
  //
  //   await conn.execute('''
  //                     DO \$\$
  //                     DECLARE
  //                         s_id INT;
  //                     BEGIN
  //                         INSERT INTO schedule (
  //                             auditories,
  //                             start_lesson_time,
  //                             end_lesson_time,
  //                             subgroup_number,
  //                             lesson_type_id,
  //                             week_number,
  //                             date_lesson,
  //                             start_lesson_date,
  //                             end_lesson_date,
  //                             weekday,
  //                             subject_name,
  //                             subject_full_name
  //                         ) VALUES $values
  //                         ON CONFLICT (auditories, start_lesson_time, end_lesson_time, subgroup_number, lesson_type_id, week_number, date_lesson, start_lesson_date, end_lesson_date, weekday, subject_id, subject_name, subject_full_name)
  //                         DO NOTHING
  //                         RETURNING id INTO s_id;
  //
  //                         INSERT INTO schedule_student_groups (schedule_id, group_id)
  //                         VALUES (s_id, ${group.id})
  //                         ON CONFLICT (schedule_id, group_id)
  //                         DO NOTHING;
  //
  //                         $employeesSql
  //                     END \$\$;
  //                     ''');
  // }

  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final List<EmployeeModel> employees = [];

    try {
      final result = await _connection.execute('''
      SELECT * FROM employees;
      ''');

      for (final employee in result) {
        employees.add(
          EmployeeModel(
            id: (employee[0] ?? 0) as int,
            firstName: (employee[1] ?? '') as String,
            lastName: (employee[2] ?? '') as String,
            middleName: (employee[3] ?? '') as String,
            imageUrl: (employee[6] ?? '') as String,
            calendarId: employee[7] as String?,
            urlId: (employee[9] ?? '') as String,
            fio: employee[10] as String?,
          ),
        );
      }
    } on Exception catch (e) {
      print('Get employees error: $e');
    }

    return employees;
  }

  Future<ScheduleModel?> fetchGroupSchedule(String groupNumber) async {
    ScheduleModel? schedule;

    try {
      final informationResult = await _connection.execute('''
      SELECT
    gs.start_date AS "startDate",
    gs.end_date AS "endDate",
    gs.start_exams_date AS "startExamsDate",
    gs.end_exams_date AS "endExamsDate",
    g.id AS "groupId",
    g.name AS "groupName"
FROM
    group_schedule gs
        JOIN
    groups g ON gs.group_id = g.id
WHERE
    g.name = '$groupNumber';
      ''');
      final exams = <ScheduleItemModel>[];

      final mondayResult = await _fetchWeekDaySchedule(groupNumber, 1);

      final monday = mondayResult.$1;
      exams.addAll(mondayResult.$2);

      final tuesdayResult = await _fetchWeekDaySchedule(groupNumber, 2);

      final tuesday = tuesdayResult.$1;
      exams.addAll(tuesdayResult.$2);

      final wednesdayResult = await _fetchWeekDaySchedule(groupNumber, 3);

      final wednesday = wednesdayResult.$1;
      exams.addAll(wednesdayResult.$2);

      final thursdayResult = await _fetchWeekDaySchedule(groupNumber, 4);

      final thursday = thursdayResult.$1;
      exams.addAll(thursdayResult.$2);

      final fridayResult = await _fetchWeekDaySchedule(groupNumber, 5);

      final friday = fridayResult.$1;
      exams.addAll(fridayResult.$2);

      final saturdayResult = await _fetchWeekDaySchedule(groupNumber, 6);

      final saturday = saturdayResult.$1;
      exams.addAll(saturdayResult.$2);

      schedule = ScheduleModel(
        startDate:
            informationResult.elementAtOrNull(0)?.elementAt(0) as String?,
        endDate: informationResult.elementAtOrNull(0)?.elementAt(1) as String?,
        startExamsDate:
            informationResult.elementAtOrNull(0)?.elementAt(2) as String?,
        endExamsDate:
            informationResult.elementAtOrNull(0)?.elementAt(3) as String?,
        schedules: WeekScheduleModel(
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
        ),
        exams: exams,
      );
    } on DioException catch (e) {
      print('Get student group schedule error: $e');
    }

    return schedule;
  }

  Future<(List<ScheduleItemModel>, List<ScheduleItemModel>)>
      _fetchWeekDaySchedule(
    String searchFilter,
    int weekDay, {
    bool isGroupSchedule = true,
  }) async {
    final weekdaySchedule = <ScheduleItemModel>[];
    final exams = <ScheduleItemModel>[];

    final result = await _connection.execute('''

      SELECT s.start_lesson_time  AS "startTime",
       s.end_lesson_time    AS "endTime",
       s.auditories         AS "auditories",
       s.week_number        AS "week_number",
       s.subgroup_number    AS "subgroupNumber",
       s.date_lesson        AS "date_lesson",
       lt.abbrev            AS "lessonType",
       lt.full_name         AS "lessonTypeName",
       sub.name             AS "subjectName",
       sub.full_name        AS "subjectFullName",
       JSON_AGG(DISTINCT JSONB_BUILD_OBJECT(
               'id', e.id,
               'firstName', e.first_name,
               'lastName', e.last_name,
               'middleName', e.middle_name,
               'degree', e.degree,
               'rank', e.rank,
               'photoLink', e.photo_link,
               'calendarId', e.calendar_id,
               'academicDepartment', e.academic_department,
               'urlId', e.url_id,
               'fio', e.fio
                         )) AS "employees",
       JSON_AGG(DISTINCT JSONB_BUILD_OBJECT(
               'id', g.id,
               'name', g.name,
               'course', g.course,
               'educationDegree', g.education_degree
                         )) AS "groups"
FROM schedule s
         JOIN
     schedule_student_groups ssg ON s.id = ssg.schedule_id
         JOIN
     groups g ON ssg.group_id = g.id
         JOIN
     lesson_types lt ON s.lesson_type_id = lt.id
         JOIN
     subjects sub ON s.subject_id = sub.id
         LEFT JOIN
     schedule_employees se ON s.id = se.schedule_id
         LEFT JOIN
     employees e ON se.employee_id = e.id
WHERE ${isGroupSchedule ? "g.name = " : "e.url_id = "} '$searchFilter'
  AND s.weekday = $weekDay  
GROUP BY s.start_lesson_time,
         s.end_lesson_time,
         s.auditories,
         s.subgroup_number,
         s.week_number,
         s.date_lesson,
         lt.abbrev,
         lt.full_name,
         sub.name,
         sub.full_name
ORDER BY s.start_lesson_time;
      ''');

    for (final item in result) {
      final schedule = _parseGroupScheduleItem(item);

      if (schedule.lessonTypeAbbrev == 'Экзамен' ||
          schedule.lessonTypeAbbrev == 'Консультация') {
        exams.add(schedule);
      } else {
        weekdaySchedule.add(schedule);
      }
    }

    return (weekdaySchedule, exams);
  }

  ScheduleItemModel _parseGroupScheduleItem(ResultRow scheduleItem) {
    return ScheduleItemModel(
      isSplit: false,
      isAnnouncement: false,
      dateLesson: scheduleItem[5] as String?,
      employees: _tryParseEmployees(scheduleItem),
      studentGroups: _tryParseGroups(scheduleItem),
      subgroupNumber: (scheduleItem[4] ?? 0) as int,
      endLessonTime: (scheduleItem[1] ?? '') as String,
      weekNumbers: (scheduleItem[3] ?? []) as List<int>,
      subjectFullName: (scheduleItem[9] ?? '') as String,
      startLessonTime: (scheduleItem[0] ?? '') as String,
      auditories: (scheduleItem[2] ?? []) as List<String>,
      lessonTypeAbbrev: (scheduleItem[6] ?? '') as String,
      subjectAbbreviationName: (scheduleItem[8] ?? '') as String,
    );
  }

  List<EmployeeModel> _tryParseEmployees(ResultRow scheduleItem) {
    final employees = <EmployeeModel>[];
    final employeesInfo = scheduleItem[10] as List<dynamic>?;

    if (employeesInfo == null) return employees;

    for (final employee in employeesInfo) {
      employees.add(
        EmployeeModel(
          id: employee['id'] as int,
          fio: employee['fio'] as String?,
          urlId: employee['urlId'] as String,
          lastName: employee['lastName'] as String,
          imageUrl: employee['photoLink'] as String,
          firstName: employee['firstName'] as String,
          middleName: employee['middleName'] as String?,
          calendarId: employee['calendarId'] as String?,
        ),
      );
    }

    return employees;
  }

  List<StudentGroupModel> _tryParseGroups(ResultRow scheduleItem) {
    final groups = <StudentGroupModel>[];
    final groupsInfo = scheduleItem[11] as List<dynamic>?;

    if (groupsInfo == null) return groups;

    for (final group in groupsInfo) {
      groups.add(
        StudentGroupModel(
          name: group['name'] as String,
          specialityName: '',
          educationDegree: 0,
        ),
      );
    }

    return groups;
  }

  Future<ScheduleModel?> fetchEmployeeSchedule(String urlId) async {
    ScheduleModel? schedule;

    try {
      final informationResult = await _connection.execute('''
      SELECT
    es.start_date AS "startDate",
    es.end_date AS "endDate",
    es.start_exams_date AS "startExamsDate",
    es.end_exams_date AS "endExamsDate",
    e.id AS "employeeId",
    e.url_id AS "employeeUrlId"
FROM
    employee_schedule es
        JOIN
    employees e ON es.employee_id = e.id
WHERE
    e.url_id = '$urlId';
      ''');

      final exams = <ScheduleItemModel>[];

      final mondayResult = await _fetchWeekDaySchedule(
        urlId,
        1,
        isGroupSchedule: false,
      );

      final monday = mondayResult.$1;
      exams.addAll(mondayResult.$2);

      final tuesdayResult = await _fetchWeekDaySchedule(
        urlId,
        2,
        isGroupSchedule: false,
      );

      final tuesday = tuesdayResult.$1;
      exams.addAll(tuesdayResult.$2);

      final wednesdayResult = await _fetchWeekDaySchedule(
        urlId,
        3,
        isGroupSchedule: false,
      );

      final wednesday = wednesdayResult.$1;
      exams.addAll(wednesdayResult.$2);

      final thursdayResult = await _fetchWeekDaySchedule(
        urlId,
        4,
        isGroupSchedule: false,
      );

      final thursday = thursdayResult.$1;
      exams.addAll(thursdayResult.$2);

      final fridayResult = await _fetchWeekDaySchedule(
        urlId,
        5,
        isGroupSchedule: false,
      );

      final friday = fridayResult.$1;
      exams.addAll(fridayResult.$2);

      final saturdayResult = await _fetchWeekDaySchedule(
        urlId,
        6,
        isGroupSchedule: false,
      );

      final saturday = saturdayResult.$1;
      exams.addAll(saturdayResult.$2);

      schedule = ScheduleModel(
        startDate:
            informationResult.elementAtOrNull(0)?.elementAt(0) as String?,
        endDate: informationResult.elementAtOrNull(0)?.elementAt(1) as String?,
        startExamsDate:
            informationResult.elementAtOrNull(0)?.elementAt(2) as String?,
        endExamsDate:
            informationResult.elementAtOrNull(0)?.elementAt(3) as String?,
        schedules: WeekScheduleModel(
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
        ),
        exams: exams,
      );
    } on DioException catch (e) {
      print('Get employee schedule error: $e');
    }

    return schedule;
  }

  Future<bool> createUser({
    required String email,
    required String passwordHash,
  }) async {
    try {
      final result = await _connection.execute('''
      INSERT INTO users (email, password_hash) VALUES ('$email', '$passwordHash');
      ''');

      print('result: $result');

      return true;
    } catch (e) {
      print('error: $e');

      return false;
    }
  }

  Future<bool> findUser({
    required String email,
    required String passwordHash,
  }) async {
    try {
      final result = await _connection.execute('''
      SELECT id FROM users
      WHERE email = '$email' and password_hash = '$passwordHash';
      ''');

      if (result.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      print('error: $e');

      return false;
    }
  }

  Future<List<int>> fetchFavouriteGroupsIds({
    required String email,
    required String passwordHash,
  }) async {
    final groupIds = <int>[];

    try {
      final result = await _connection.execute('''
      SELECT ug.group_id
      FROM users u
               JOIN user_groups ug ON u.id = ug.user_id
      WHERE u.email = '$email'
        AND u.password_hash = '$passwordHash';
      ''');

      print('result: $result');

      for (final id in result) {
        groupIds.add(id[0] as int);
      }
    } catch (e) {
      print('Fetch favourite group ids error: $e');
    }

    return groupIds;
  }

  Future<void> addGroupToFavourite({
    required int id,
    required String email,
    required String passwordHash,
  }) async {
    try {
      await _connection.execute('''
     SELECT add_user_group_relation('$email', '$passwordHash', $id);
      ''');
    } catch (e) {
      print('Add favourite group error: $e');
    }
  }

  Future<void> deleteGroupFromFavourites({
    required int id,
    required String email,
    required String passwordHash,
  }) async {
    try {
      await _connection.execute('''
     SELECT delete_user_group_relation('$email', '$passwordHash', $id);
      ''');
    } catch (e) {
      print('Delete favourite group error: $e');
    }
  }

  Future<List<int>> fetchFavouriteEmployeesIds({
    required String email,
    required String passwordHash,
  }) async {
    final employeesIds = <int>[];

    try {
      final result = await _connection.execute('''
      SELECT ue.employee_id
      FROM users u
            JOIN user_employees ue ON u.id = ue.user_id
      WHERE u.email = '$email'
        AND u.password_hash = '$passwordHash';
      ''');

      print('result: $result');

      for (final id in result) {
        employeesIds.add(id[0] as int);
      }
    } catch (e) {
      print('Fetch favourite employees ids error: $e');
    }

    return employeesIds;
  }

  Future<void> addEmployeeToFavourite({
    required int id,
    required String email,
    required String passwordHash,
  }) async {
    try {
      await _connection.execute('''
     SELECT add_user_employee_relation('$email', '$passwordHash', $id);
      ''');
    } catch (e) {
      print('Add favourite employee error: $e');
    }
  }

  Future<void> deleteEmployeeFromFavourites({
    required int id,
    required String email,
    required String passwordHash,
  }) async {
    try {
      await _connection.execute('''
     SELECT delete_user_employee_relation('$email', '$passwordHash', $id);
      ''');
    } catch (e) {
      print('Delete favourite employee error: $e');
    }
  }
}
