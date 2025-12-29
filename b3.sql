DROP DATABASE IF EXISTS StudentDB;
CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Student (
    student_id   VARCHAR(10) PRIMARY KEY,
    full_name    NVARCHAR(100) NOT NULL
);

INSERT INTO Student (student_id, full_name)
VALUES
('S001', N'Nguyễn Văn A'),
('S002', N'Trần Thị B'),
('S003', N'Lê Văn C');

CREATE TABLE Subject (
    subject_id   VARCHAR(10) PRIMARY KEY,
    subject_name NVARCHAR(100) NOT NULL,
    credit       INT NOT NULL,
    CONSTRAINT CK_Subject_Credit_Positive CHECK (credit > 0)
);

INSERT INTO Subject (subject_id, subject_name, credit)
VALUES
('SUB01', N'Cơ sở dữ liệu', 3),
('SUB02', N'Lập trình Java', 4),
('SUB03', N'Toán rời rạc', 3);

UPDATE Subject
SET credit = 5
WHERE subject_id = 'SUB02';

UPDATE Subject
SET subject_name = N'Toán rời rạc nâng cao'
WHERE subject_id = 'SUB03';

CREATE TABLE Score (
    student_id   VARCHAR(10) NOT NULL,
    subject_id   VARCHAR(10) NOT NULL,
    mid_score    DECIMAL(4,2) NOT NULL,
    final_score  DECIMAL(4,2) NOT NULL,

    CONSTRAINT PK_Score PRIMARY KEY (student_id, subject_id),

    CONSTRAINT CK_Score_Mid   CHECK (mid_score BETWEEN 0 AND 10),
    CONSTRAINT CK_Score_Final CHECK (final_score BETWEEN 0 AND 10),

    CONSTRAINT FK_Score_Student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    CONSTRAINT FK_Score_Subject
        FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
);

INSERT INTO Score (student_id, subject_id, mid_score, final_score)
VALUES
('S001', 'SUB01', 7.5, 8.0),
('S002', 'SUB01', 6.0, 7.2),
('S001', 'SUB02', 8.5, 9.0);

UPDATE Score
SET final_score = 8.3
WHERE student_id = 'S002' AND subject_id = 'SUB01';


SELECT * FROM Student;
SELECT * FROM Subject;
SELECT * FROM Score;

SELECT *
FROM Score
WHERE final_score >= 8;
