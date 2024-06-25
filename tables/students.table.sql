CREATE TABLE IF NOT EXISTS students(
    studentId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    userInformationId UUID NOT NULL,
    studentCard CHAR(8) NOT NULL UNIQUE DEFAULT gen_student_card(),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_userInformationId_students
    FOREIGN KEY(userInformationId) REFERENCES user_information(userInformationId)
);