
CREATE TABLE Score (
    student_id  VARCHAR(10) NOT NULL,
    subject_id  VARCHAR(10) NOT NULL,
    mid_score   DECIMAL(4,2) NOT NULL,
    final_score DECIMAL(4,2) NOT NULL,

    CONSTRAINT PK_Score PRIMARY KEY (student_id, subject_id),

    CONSTRAINT CK_Score_Mid   CHECK (mid_score   BETWEEN 0 AND 10),
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
WHERE student_id = 'S002'
  AND subject_id = 'SUB01';

SELECT *
FROM Score;

SELECT *
FROM Score
WHERE final_score >= 8;

