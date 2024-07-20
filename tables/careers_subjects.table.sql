CREATE TABLE IF NOT EXISTS careers_subjects(
    careerSubjectId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    careerId UUID NOT NULL,
    subjectId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_careerId_careers_subjects
    FOREIGN KEY (careerId) REFERENCES careers(careerId),
    CONSTRAINT FK_subjectId_careers_subjects
    FOREIGN KEY (subjectId) REFERENCES subjects(subjectId)
);