CREATE TABLE IF NOT EXISTS student_subscriptions(
    studentSubscriptionId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    studentId UUID NOT NULL,
    careerId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_studentId_student_subscriptions
    FOREIGN KEY(studentId) REFERENCES students(studentId),
    CONSTRAINT FK_careerId_student_subscriptions
    FOREIGN KEY(careerId) REFERENCES careers(careerId)
);

CREATE TABLE IF NOT EXISTS student_subscriptions_subjects(
    studentSubscriptionSubjectId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    studentSubscriptionId UUID NOT NULL,
    subjectId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_studentSubscriptionId_student_subscriptions_subjects
    FOREIGN KEY(studentSubscriptionId) REFERENCES student_subscriptions(studentSubscriptionId),
    CONSTRAINT FK_subjectId_student_subscriptions_subjects
    FOREIGN KEY(subjectId) REFERENCES subjects(subjectId)
);