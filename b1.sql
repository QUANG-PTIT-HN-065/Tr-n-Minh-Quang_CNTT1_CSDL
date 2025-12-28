CREATE TABLE Class (
    ClassID VARCHAR(10) PRIMARY KEY,   
    ClassName NVARCHAR(100) NOT NULL, 
    SchoolYear INT NOT NULL          
);

CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,      
    FullName NVARCHAR(100) NOT NULL,        
    BirthDate DATE NOT NULL,                
    ClassID VARCHAR(10) NOT NULL,           

    CONSTRAINT FK_Student_Class
        FOREIGN KEY (ClassID)
        REFERENCES Class(ClassID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

INSERT INTO Class (ClassID, ClassName, SchoolYear)
VALUES ('C01', 'CNTT 1', 2025);

INSERT INTO Student (StudentID, FullName, BirthDate, ClassID)
VALUES ('S001', N'Nguyễn Văn A', '2005-05-10', 'C01');
