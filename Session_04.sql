DROP DATABASE IF EXISTS OnlineLearningDB;
CREATE DATABASE OnlineLearningDB;
USE OnlineLearningDB;

-- BẢNG STUDENT
CREATE TABLE Student (
    student_id   VARCHAR(10) PRIMARY KEY,
    full_name    NVARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email        VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Student_Email UNIQUE (email)
);

-- Thêm sinh viên
INSERT INTO Student VALUES
('S001', N'Nguyễn Văn A', '2004-05-10', 'a.nguyen@example.com'),
('S002', N'Trần Thị B',   '2005-02-18', 'b.tran@example.com'),
('S003', N'Lê Minh C',    '2003-11-25', 'c.le@example.com');

-- Cập nhật email sinh viên
UPDATE Student
SET email = 'new_email@example.com'
WHERE student_id = 'S003';

-- Xóa sinh viên (ví dụ)
DELETE FROM Student
WHERE student_id = 'S999';

-- Kiểm tra
SELECT * FROM Student;

-- BẢNG TEACHER

CREATE TABLE Teacher (
    teacher_id   VARCHAR(10) PRIMARY KEY,
    full_name    NVARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Teacher_Email UNIQUE (email)
);

-- Thêm giảng viên
INSERT INTO Teacher VALUES
('T01', N'Phạm Văn D', 'd.pham@example.com'),
('T02', N'Lý Thu E',   'e.ly@example.com');

-- Cập nhật tên giảng viên
UPDATE Teacher
SET full_name = N'Phạm Văn D (PhD)'
WHERE teacher_id = 'T01';

-- Xóa giảng viên (ví dụ)
DELETE FROM Teacher
WHERE teacher_id = 'T99';

SELECT * FROM Teacher;

-- BẢNG COURSE
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

-- Thêm khóa học
INSERT INTO Course VALUES
('C001', N'Lập trình SQL', N'Khóa học cơ bản', 20, 'T01'),
('C002', N'Phân tích dữ liệu', N'Khóa học nâng cao', 25, 'T02');

-- Cập nhật số buổi học
UPDATE Course
SET session_count = 30
WHERE course_id = 'C002';

-- Đổi tên khóa học
UPDATE Course
SET course_name = N'Lập trình SQL nâng cao'
WHERE course_id = 'C001';

SELECT * FROM Course;

-- BẢNG ENROLLMENT
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

-- Thêm đăng ký học
INSERT INTO Enrollment VALUES
('S001', 'C001', '2025-01-10'),
('S002', 'C001', '2025-01-12'),
('S001', 'C002', '2025-01-15');

-- Cập nhật ngày đăng ký
UPDATE Enrollment
SET enroll_date = '2025-02-01'
WHERE student_id = 'S001' AND course_id = 'C002';

-- Xóa đăng ký
DELETE FROM Enrollment
WHERE student_id = 'S002' AND course_id = 'C001';

SELECT * FROM Enrollment;

-- BẢNG SCORE
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

-- Thêm điểm
INSERT INTO Score VALUES
('S001', 'C001', 8.0, 9.0),
('S002', 'C001', 6.5, 7.2),
('S001', 'C002', 7.5, 8.2);

-- Cập nhật điểm cuối kỳ
UPDATE Score
SET final_score = 9.3
WHERE student_id = 'S001' AND course_id = 'C001';

-- Xóa điểm (ví dụ)
DELETE FROM Score
WHERE student_id = 'S002' AND course_id = 'C001';

-- Truy vấn kiểm tra
SELECT * FROM Score;
SELECT * FROM Score WHERE final_score >= 8;
