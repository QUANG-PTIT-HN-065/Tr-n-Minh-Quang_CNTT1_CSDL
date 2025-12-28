-- Bảng Sinh viên
CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,
    FullName  NVARCHAR(100) NOT NULL
);

-- Bảng Môn học
CREATE TABLE Subject (
    SubjectID   VARCHAR(10) PRIMARY KEY,
    SubjectName NVARCHAR(100) NOT NULL,
    Credits     INT NOT NULL CHECK (Credits > 0)
);

-- Bảng KẾT QUẢ HỌC TẬP (Score)
CREATE TABLE Score (
    StudentID   VARCHAR(10) NOT NULL,
    SubjectID   VARCHAR(10) NOT NULL,
    ProcessScore  DECIMAL(4,2) NOT NULL,  
    FinalScore    DECIMAL(4,2) NOT NULL,  
    CONSTRAINT PK_Score PRIMARY KEY (StudentID, SubjectID),
    
    CONSTRAINT CK_Score_Process CHECK (ProcessScore BETWEEN 0 AND 10),
    CONSTRAINT CK_Score_Final   CHECK (FinalScore   BETWEEN 0 AND 10),

    CONSTRAINT FK_Score_Student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Score_Subject
        FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
