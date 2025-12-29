CREATE TABLE Enrollment (
    student_id  VARCHAR(10) NOT NULL,
    subject_id  VARCHAR(10) NOT NULL,
    enroll_date DATE NOT NULL,

    CONSTRAINT PK_Enrollment PRIMARY KEY (student_id, subject_id),

    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Enrollment_Subject
        FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Enrollment (student_id, subject_id, enroll_date)
VALUES
('S001', 'SUB01', '2025-01-10'),
('S001', 'SUB02', '2025-01-11'),
('S002', 'SUB01', '2025-01-12');

SELECT *
FROM Enrollment;

SELECT *
FROM Enrollment
WHERE student_id = 'S001';
