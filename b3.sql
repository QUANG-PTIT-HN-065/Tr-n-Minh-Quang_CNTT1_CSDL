CREATE TABLE Enrollment (
    StudentID  VARCHAR(10) NOT NULL,   
    SubjectID  VARCHAR(10) NOT NULL,   
    EnrollDate DATE NOT NULL,       

    CONSTRAINT PK_Enrollment PRIMARY KEY (StudentID, SubjectID),

    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Enrollment_Subject
        FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
