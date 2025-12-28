CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,   
    FullName NVARCHAR(100) NOT NULL   
);

CREATE TABLE Subject (
    SubjectID VARCHAR(10) PRIMARY KEY,      
    SubjectName NVARCHAR(100) NOT NULL,     
    Credits INT NOT NULL,                 

    CONSTRAINT CK_Subject_Credits_Positive
        CHECK (Credits > 0)                 
);
