CREATE TABLE IF NOT EXISTS schedules(
    scheduleId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    subjectId UUID NOT NULL,
    startAt TIME NOT NULL,
    finishedAt TIME NOT NULL,
    CONSTRAINT CHECK_startAt_finishedAt CHECK (startAt < finishedAt),
    CONSTRAINT FK_subjectId_schedules
    FOREIGN KEY (subjectId) REFERENCES subjects(subjectId)
);