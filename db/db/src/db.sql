-- Table for Employee
CREATE TABLE employees
(
    id                  SERIAL PRIMARY KEY,
    first_name          VARCHAR(50)  NOT NULL,
    last_name           VARCHAR(50)  NOT NULL,
    middle_name         VARCHAR(50),
    degree              VARCHAR(100),
    rank                VARCHAR(50),
    photo_link          TEXT,
    calendar_id         VARCHAR(255),
    academic_department TEXT[],
    url_id              VARCHAR(100) NOT NULL,
    fio                 VARCHAR(200) NOT NULL
);

-- Table for Faculties
CREATE TABLE faculties
(
    id     SERIAL PRIMARY KEY,
    name   TEXT NOT NULL,
    abbrev TEXT NOT NULL
);

-- Table for Specialities
CREATE TABLE specialities
(
    id         SERIAL PRIMARY KEY,
    name       TEXT        NOT NULL,
    abbrev     TEXT        NOT NULL,
    faculty_id INT REFERENCES faculties (id),
    code       VARCHAR(50) NOT NULL
);

-- Table for Group
CREATE TABLE groups
(
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(50) NOT NULL,
    speciality_id    INT REFERENCES specialities (id),
    course           INT,
    calendar_id      TEXT,
    education_degree INT         NOT NULL
);

-- select groups with all data
SELECT g.name             AS "name",
       f.id               AS "facultyId",
       f.abbrev           AS "facultyAbbrev",
       f.name             AS "facultyName",
       s.name             AS "specialityName",
       s.abbrev           AS "specialityAbbrev",
       g.course           AS "course",
       g.id               AS "id",
       g.calendar_id      AS "calendarId",
       g.education_degree AS "educationDegree"
FROM groups g
         JOIN
     specialities s ON g.speciality_id = s.id
         JOIN
     faculties f ON s.faculty_id = f.id;
ORDER BY
    g.name ASC;

CREATE INDEX idx_group_name ON groups (name);
CREATE INDEX idx_group_speciality_id ON groups (speciality_id);
CREATE INDEX idx_speciality_faculty_id ON specialities (faculty_id);

-- Tables for lesson types
CREATE TABLE lesson_types
(
    id        SERIAL PRIMARY KEY,
    abbrev    VARCHAR(12) NOT NULL,
    full_name VARCHAR(20) NOT NULL
);

-- Inserting values
INSERT INTO lesson_types (id, abbrev, full_name)
VALUES (1, 'ЛК', 'Лекция'),
       (2, 'ЛР', 'Лабораторная работа'),
       (3, 'ПЗ', 'Практическое занятие'),
       (4, 'Экзамен', 'Экзамен'),
       (5, 'Консультация', 'Консультация');

INSERT INTO lesson_types (id, abbrev, full_name)
VALUES (6, '', '');


-- Tables for subjects
CREATE TABLE subjects
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL
);


CREATE TABLE schedule
(
    id                SERIAL PRIMARY KEY,
    auditories        TEXT[],
    start_lesson_time VARCHAR(50) NOT NULL,
    end_lesson_time   VARCHAR(50) NOT NULL,
    subgroup_number   INT CHECK ( subgroup_number BETWEEN 0 AND 2),
    lesson_type_id    INT REFERENCES lesson_types (id),
    subject_id        INT REFERENCES subjects (id),
    week_number       INT[],
    weekday           INT CHECK ( weekday BETWEEN 1 AND 6),
    date_lesson       VARCHAR(50),
    start_lesson_date VARCHAR(50),
    end_lesson_date   VARCHAR(50)
);

ALTER TABLE schedule
    ADD CONSTRAINT unique_schedule
        UNIQUE (auditories, start_lesson_time, end_lesson_time, subgroup_number, lesson_type_id, week_number,
                date_lesson, start_lesson_date, end_lesson_date, weekday, subject_id);


CREATE TABLE schedule_employees
(
    PRIMARY KEY (schedule_id, employee_id),
    schedule_id INT REFERENCES schedule (id) ON DELETE CASCADE,
    employee_id INT REFERENCES employees (id) ON DELETE CASCADE

);

CREATE TABLE schedule_student_groups
(
    PRIMARY KEY (schedule_id, group_id),
    schedule_id INT REFERENCES schedule (id) ON DELETE CASCADE,
    group_id    INT REFERENCES groups (id) ON DELETE CASCADE
);


CREATE OR REPLACE FUNCTION handle_subject_insert()
    RETURNS TRIGGER AS
$$
DECLARE
    subject_id INT;
BEGIN
    SELECT id
    INTO subject_id
    FROM subjects
    WHERE name = NEW.subject_name
      AND full_name = NEW.subject_full_name;

    IF subject_id IS NULL THEN
        INSERT INTO subjects (name, full_name)
        VALUES (NEW.subject_name, NEW.subject_full_name)
        RETURNING id INTO subject_id;
    END IF;

    NEW.subject_id := subject_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_schedule_insert
    BEFORE INSERT
    ON schedule
    FOR EACH ROW
EXECUTE FUNCTION handle_subject_insert();


ALTER TABLE schedule
    ADD COLUMN subject_name VARCHAR(255);

ALTER TABLE schedule
    ADD COLUMN subject_full_name VARCHAR(255);


ALTER TABLE schedule_student_groups
    ADD CONSTRAINT unique_schedule_student_groups
        UNIQUE (group_id, schedule_id);


ALTER TABLE schedule_employees
    ADD CONSTRAINT unique_schedule_employees
        UNIQUE (employee_id, schedule_id);

SELECT g.id               AS "groupId",
       g.name             AS "groupName",
       g.course           AS "course",
       g.calendar_id      AS "calendarId",
       g.education_degree AS "educationDegree",
       s.id               AS "specialityId",
       s.name             AS "specialityName",
       s.abbrev           AS "specialityAbbrev",
       f.id               AS "facultyId",
       f.name             AS "facultyName",
       f.abbrev           AS "facultyAbbrev"
FROM groups g
         JOIN
     specialities s ON g.speciality_id = s.id
         JOIN
     faculties f ON s.faculty_id = f.id
ORDER BY g.name;



SELECT *
FROM employees;


explain analyse  SELECT s.start_lesson_time  AS "startTime",
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
WHERE g.name = '153502'
  AND s.weekday = 1
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

CREATE INDEX idx_schedule_weekday ON schedule (weekday);
CREATE INDEX idx_schedule_start_lesson_time ON schedule (weekday);



CREATE TABLE group_schedule
(
    id               SERIAL PRIMARY KEY,
    start_date       VARCHAR(10),
    end_date         VARCHAR(10),
    start_exams_date VARCHAR(10),
    end_exams_date   VARCHAR(10),
    group_id         int REFERENCES groups (id)
);


ALTER TABLE group_schedule
    ADD CONSTRAINT unique_group_id UNIQUE (group_id);


CREATE TABLE employee_schedule
(
    id               SERIAL PRIMARY KEY,
    start_date       VARCHAR(10),
    end_date         VARCHAR(10),
    start_exams_date VARCHAR(10),
    end_exams_date   VARCHAR(10),
    employee_id      int REFERENCES employees (id)
);

ALTER TABLE employee_schedule
    ADD CONSTRAINT unique_employee_id UNIQUE (employee_id);


SELECT gs.start_date       AS "startDate",
       gs.end_date         AS "endDate",
       gs.start_exams_date AS "startExamsDate",
       gs.end_exams_date   AS "endExamsDate",
       g.id                AS "groupId",
       g.name              AS "groupName"
FROM group_schedule gs
         JOIN
     groups g ON gs.group_id = g.id
WHERE g.name = '153502';



SELECT s.start_lesson_time  AS "startTime",
       s.end_lesson_time    AS "endTime",
       s.auditories         AS "auditories",
       s.week_number        AS "weekNumber",
       s.subgroup_number    AS "subgroupNumber",
       s.date_lesson        AS "dateLesson",
       lt.abbrev            AS "lessonType",
       lt.full_name         AS "lessonTypeName",
       sub.name             AS "subjectName",
       sub.full_name        AS "subjectFullName",
       JSON_AGG(DISTINCT JSONB_BUILD_OBJECT(
               'id', g.id,
               'name', g.name,
               'course', g.course,
               'educationDegree', g.education_degree
                         )) AS "groups"
FROM schedule s
         JOIN
     schedule_employees se ON s.id = se.schedule_id
         JOIN
     employees e ON se.employee_id = e.id
         JOIN
     lesson_types lt ON s.lesson_type_id = lt.id
         JOIN
     subjects sub ON s.subject_id = sub.id
         LEFT JOIN
     schedule_student_groups ssg ON s.id = ssg.schedule_id
         LEFT JOIN
     groups g ON ssg.group_id = g.id
WHERE e.url_id = 'o-duginov'
  AND s.weekday = 3
GROUP BY s.start_lesson_time,
         s.end_lesson_time,
         s.auditories,
         s.subgroup_number,
         s.week_number,
         s.date_lesson,
         lt.abbrev,
         lt.full_name,
         sub.name,
         sub.full_name, s.id
ORDER BY s.start_lesson_time;

CREATE INDEX idx_employee_url_id ON employees (url_id);


SELECT es.start_date       AS "startDate",
       es.end_date         AS "endDate",
       es.start_exams_date AS "startExamsDate",
       es.end_exams_date   AS "endExamsDate",
       e.id                AS "employeeId",
       e.url_id            AS "employeeUrlId"
FROM employee_schedule es
         JOIN
     employees e ON es.employee_id = e.id
WHERE e.url_id = 'o-duginov';


CREATE TABLE users
(
    id            SERIAL PRIMARY KEY,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT                NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_groups
(
    id       SERIAL PRIMARY KEY,
    user_id  INT REFERENCES users (id) ON DELETE CASCADE,
    group_id INT REFERENCES groups (id) ON DELETE CASCADE
);

ALTER TABLE user_groups
    DROP COLUMN id;

ALTER TABLE user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (user_id, group_id);


CREATE TABLE user_employees
(
    id          SERIAL PRIMARY KEY,
    user_id     INT REFERENCES users (id) ON DELETE CASCADE,
    employee_id INT REFERENCES employees (id) ON DELETE CASCADE
);

CREATE TABLE user_logs
(
    id         SERIAL PRIMARY KEY,
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_type TEXT NOT NULL,
    details    TEXT NOT NULL
);

CREATE OR REPLACE FUNCTION log_user_creation()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO user_logs (event_type, details)
    VALUES ('create', 'User with email: ' || NEW.email || ' has been created.');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER after_user_insert
    AFTER INSERT
    ON users
    FOR EACH ROW
EXECUTE FUNCTION log_user_creation();


CREATE OR REPLACE FUNCTION log_add_group_relation()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO user_logs (event_type, details)
    VALUES ('add_relation',
            'Relation has been created: User ' || NEW.user_id || ' -> Group ' || NEW.group_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_add_employee_relation()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO user_logs (event_type, details)
    VALUES ('add_relation',
            'Relation has been created: User ' || NEW.user_id || ' -> Employee ' || NEW.employee_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER after_user_groups_insert
    AFTER INSERT
    ON user_groups
    FOR EACH ROW
EXECUTE FUNCTION log_add_group_relation();

CREATE TRIGGER after_user_employees_insert
    AFTER INSERT
    ON user_employees
    FOR EACH ROW
EXECUTE FUNCTION log_add_employee_relation();


CREATE OR REPLACE FUNCTION log_delete_group_relation()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO user_logs (event_type, details)
    VALUES ('delete_relation',
            'Relation has been deleted: User ' || OLD.user_id || ' -> Group ' || OLD.group_id);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_employee_relation()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO user_logs (event_type, details)
    VALUES ('delete_relation',
            'Relation has been deleted: User ' || OLD.user_id || ' -> Employee ' || OLD.employee_id);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_user_groups_delete
    AFTER DELETE
    ON user_groups
    FOR EACH ROW
EXECUTE FUNCTION log_delete_group_relation();

CREATE TRIGGER after_user_employees_delete
    AFTER DELETE
    ON user_employees
    FOR EACH ROW
EXECUTE FUNCTION log_delete_employee_relation();

INSERT INTO users (email, password_hash)
VALUES ('kirznernasta@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d');

SELECT id
FROM users
WHERE email = 'kirznernasta@gmail.com'
  and password_hash = '7c222fb2927d828af22f592134e8932480637c0d';


INSERT INTO user_groups (user_id, group_id)
SELECT id, 23481 -- Замените на group_id
FROM users
WHERE email = 'kirznernasta@gmail.com'
  AND password_hash = '7c222fb2927d828af22f592134e8932480637c0d';

CREATE OR REPLACE FUNCTION add_user_group_relation(p_email TEXT, p_hash TEXT, p_group_id INT)
    RETURNS VOID AS
$$
DECLARE
    user_id INT;
BEGIN
    SELECT id
    INTO user_id
    FROM users
    WHERE email = p_email
      AND password_hash = p_hash;

    IF user_id IS NULL THEN
        RAISE EXCEPTION 'There is no user with such email and password hash.';
    END IF;

    INSERT INTO user_groups (user_id, group_id)
    VALUES (user_id, p_group_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_user_group_relation(p_email TEXT, p_hash TEXT, p_group_id INT)
    RETURNS VOID AS
$$
DECLARE
    p_user_id INT;
BEGIN
    SELECT id
    INTO p_user_id
    FROM users
    WHERE email = p_email
      AND password_hash = p_hash;

    IF p_user_id IS NULL THEN
        RAISE EXCEPTION 'There is no user with such email and password hash.';
    END IF;

    DELETE
    FROM user_groups
    WHERE user_groups.user_id = p_user_id
      and user_groups.group_id = p_group_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_user_employee_relation(p_email TEXT, p_hash TEXT, p_employee_id INT)
    RETURNS VOID AS
$$
DECLARE
    user_id INT;
BEGIN
    SELECT id
    INTO user_id
    FROM users
    WHERE email = p_email
      AND password_hash = p_hash;

    IF user_id IS NULL THEN
        RAISE EXCEPTION 'There is no user with such email and password hash.';
    END IF;

    INSERT INTO user_employees (user_id, employee_id)
    VALUES (user_id, p_employee_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_user_employee_relation(p_email TEXT, p_hash TEXT, p_employee_id INT)
    RETURNS VOID AS
$$
DECLARE
    p_user_id INT;
BEGIN
    SELECT id
    INTO p_user_id
    FROM users
    WHERE email = p_email
      AND password_hash = p_hash;

    IF p_user_id IS NULL THEN
        RAISE EXCEPTION 'There is no user with such email and password hash.';
    END IF;

    DELETE
    FROM user_employees
    WHERE user_employees.user_id = p_user_id
      and user_employees.employee_id = p_employee_id;
END;
$$ LANGUAGE plpgsql;


SELECT add_user_group_relation('kirznernasta@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 23481);
SELECT add_user_employee_relation('kirznernasta@gmail.com', '7c222fb2927d828af22f592134e8932480637c0d', 505975);

ALTER TABLE user_groups
    ADD CONSTRAINT unique_user_group
        UNIQUE (user_id, group_id);

ALTER TABLE user_employees
    ADD CONSTRAINT unique_user_employee
        UNIQUE (user_id, employee_id);


SELECT ug.group_id
FROM users u
         JOIN user_groups ug ON u.id = ug.user_id
WHERE u.email = 'kirznernasta@gmail.com'
  AND u.password_hash = '7c222fb2927d828af22f592134e8932480637c0d';


SELECT ue.employee_id
FROM users u
         JOIN user_employees ue ON u.id = ue.user_id
WHERE u.email = 'kirznernasta@gmail.com'
  AND u.password_hash = '7c222fb2927d828af22f592134e8932480637c0d';


SET track_io_timing = ON;

