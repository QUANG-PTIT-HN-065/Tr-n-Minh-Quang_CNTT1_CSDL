DROP DATABASE IF EXISTS OnlineLearningDB;
CREATE DATABASE OnlineLearningDB;
USE OnlineLearningDB;


CREATE TABLE Student (
    student_id   VARCHAR(10) PRIMARY KEY,
    full_name    NVARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email        VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Student_Email UNIQUE (email)
);


INSERT INTO Student VALUES
('S001', N'Nguyễn Văn A', '2004-05-10', 'a.nguyen@example.com'),
('S002', N'Trần Thị B',   '2005-02-18', 'b.tran@example.com'),
('S003', N'Lê Minh C',    '2003-11-25', 'c.le@example.com');

UPDATE Student
SET email = 'new_email@example.com'
WHERE student_id = 'S003';

DELETE FROM Student
WHERE student_id = 'S999';

SELECT * FROM Student;

CREATE TABLE Teacher (
    teacher_id   VARCHAR(10) PRIMARY KEY,
    full_name    NVARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Teacher_Email UNIQUE (email)
);

INSERT INTO Teacher VALUES
('T01', N'Phạm Văn D', 'd.pham@example.com'),
('T02', N'Lý Thu E',   'e.ly@example.com');

UPDATE Teacher
SET full_name = N'Phạm Văn D (PhD)'
WHERE teacher_id = 'T01';

DELETE FROM Teacher
WHERE teacher_id = 'T99';

SELECT * FROM Teacher;

CREATE TABLE Course (
    course_id     VARCHAR(10) PRIMARY KEY,
    course_name   NVARCHAR(100) NOT NULL,
    description   NVARCHAR(255),
    session_count INT NOT NULL,
    teacher_id    VARCHAR(10),
    CONSTRAINT CK_Course_Session_Positive CHECK (session_count > 0),
    CONSTRAINT FK_Course_Teacher FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
);

INSERT INTO Course VALUES
('C001', N'Lập trình SQL', N'Khóa học cơ bản', 20, 'T01'),
('C002', N'Phân tích dữ liệu', N'Khóa học nâng cao', 25, 'T02');

UPDATE Course
SET session_count = 30
WHERE course_id = 'C002';

UPDATE Course
SET course_name = N'Lập trình SQL nâng cao'
WHERE course_id = 'C001';

SELECT * FROM Course;

CREATE TABLE Enrollment (
    student_id  VARCHAR(10) NOT NULL,
    course_id   VARCHAR(10) NOT NULL,
    enroll_date DATE NOT NULL,
    CONSTRAINT PK_Enrollment PRIMARY KEY (student_id, course_id),
    CONSTRAINT FK_Enroll_Student FOREIGN KEY (student_id)
        REFERENCES Student(student_id),
    CONSTRAINT FK_Enroll_Course FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);

INSERT INTO Enrollment VALUES
('S001', 'C001', '2025-01-10'),
('S002', 'C001', '2025-01-12'),
('S001', 'C002', '2025-01-15');

UPDATE Enrollment
SET enroll_date = '2025-02-01'
WHERE student_id = 'S001' AND course_id = 'C002';

DELETE FROM Enrollment
WHERE student_id = 'S002' AND course_id = 'C001';

SELECT * FROM Enrollment;

CREATE TABLE Score (
    student_id  VARCHAR(10) NOT NULL,
    course_id   VARCHAR(10) NOT NULL,
    mid_score   DECIMAL(4,2) NOT NULL,
    final_score DECIMAL(4,2) NOT NULL,
    CONSTRAINT PK_Score PRIMARY KEY (student_id, course_id),
    CONSTRAINT CK_Score_Mid CHECK (mid_score BETWEEN 0 AND 10),
    CONSTRAINT CK_Score_Final CHECK (final_score BETWEEN 0 AND 10),
    CONSTRAINT FK_Score_Student FOREIGN KEY (student_id)
        REFERENCES Student(student_id),
    CONSTRAINT FK_Score_Course FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);

INSERT INTO Score VALUES
('S001', 'C001', 8.0, 9.0),
('S002', 'C001', 6.5, 7.2),
('S001', 'C002', 7.5, 8.2);

UPDATE Score
SET final_score = 9.3
WHERE student_id = 'S001' AND course_id = 'C001';

DELETE FROM Score
WHERE student_id = 'S002' AND course_id = 'C001';

SELECT * FROM Score;
SELECT * FROM Score WHERE final_score >= 8;
