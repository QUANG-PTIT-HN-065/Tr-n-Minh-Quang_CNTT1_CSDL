CREATE TABLE Student (
    student_id   VARCHAR(10) PRIMARY KEY,     
    full_name    NVARCHAR(100) NOT NULL,       
    date_of_birth DATE NULL,
    email        VARCHAR(100) NOT NULL,

    CONSTRAINT UQ_Student_Email UNIQUE (email)
);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES 
('S001', N'Nguyễn Văn A', '2004-05-10', 'a.nguyen@example.com'),
('S002', N'Trần Thị B',   '2005-02-18', 'b.tran@example.com'),
('S003', N'Lê Minh C',    '2003-11-25', 'c.le@example.com');

SELECT * FROM Student;

SELECT student_id, full_name
FROM Student;
