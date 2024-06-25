CREATE TABLE IF NOT EXISTS teachers_subjects(
    teacherSubjectId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    teacherId UUID NOT NULL,
    subjectId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_teacherId_teachers_subjects
    FOREIGN KEY (teacherId) REFERENCES teachers(teacherId),
    CONSTRAINT FK_subjectId_teachers_subjects
    FOREIGN KEY (subjectId) REFERENCES subjects(subjectId)
);