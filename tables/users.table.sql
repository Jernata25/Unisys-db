CREATE TABLE user_information(
    userInformationId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    names VARCHAR(50) NOT NULL,
    surnames VARCHAR(50) NOT NULL,
    gender ENUM('M','F', 'OTRO') NOT NULL,
    dateOfBirth DATETIME NOT NULL,
    email VARCHAR(60),
    phoneNumber VARCHAR(16)
);

CREATE TABLE users (
    userId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    userInformationId UUID NOT NULL,
    nickname VARCHAR(50) NOT NULL UNIQUE,
    passwd VARCHAR(72) NOT NULL,
    userRole ENUM('REGISTRO','ADMIN') NOT NULL DEFAULT 'REGISTRO',
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_userInformationId_users
    FOREIGN KEY (userInformationId)
    REFERENCES user_information(userInformationId)
);