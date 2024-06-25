CREATE TABLE IF NOT EXISTS teachers(
    teacherId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    userInformationId UUID NOT NULL,
    addressId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_userInformationId_teachers
    FOREIGN KEY(userInformationId) REFERENCES user_information(userInformationId),
    CONSTRAINT FK_addressId_teachers
    FOREIGN KEY(addressId) REFERENCES addresses(addressId)
    
);