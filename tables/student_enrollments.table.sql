CREATE TABLE IF NOT EXISTS student_enrollments(
    studentEnrollmentId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    studentId UUID NOT NULL,
    addressId UUID NOT NULL,
    careerId UUID NOT NULL,
    universityHeadquartersId UUID NOT NULL,
    studentEnrollmentCode CHAR(14) NOT NULL UNIQUE,
    academicRegime VARCHAR(50) NOT NULL,
    studyPlan VARCHAR(50) NOT NULL, 
    paymentNumber VARCHAR(20) DEFAULT 'DESCONOCIDO',
    enrollmentNumber VARCHAR(20) DEFAULT 'DESCONOCIDO',
    civilStatus ENUM('SOLTER@', 'CASAD@', 'VIUD@', 'OTRO') NOT NULL,
    dni VARCHAR(20) NOT NULL,
    nativeLanguage VARCHAR(30) DEFAULT 'DESCONOCIDO',
    ethnicity VARCHAR(20) DEFAULT 'DESCONOCIDO', 
    modality ENUM('PRESENCIAL', 'BIMODAL', 'VIRTUAL') NOT NULL,
    shift ENUM('MATUTINO', 'VESPERTINO') NOT NULL,
    levelOfEducation VARCHAR(50) NOT NULL,
    uniqueStudentCode VARCHAR(20) UNIQUE,
    professionalActivity VARCHAR(50) DEFAULT 'DESCONOCIDO',
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_studentId_student_enrollments 
    FOREIGN KEY(studentId) REFERENCES students(studentId),
    CONSTRAINT FK_addressId_student_enrollments 
    FOREIGN KEY(addressId) REFERENCES addresses(addressId),
    CONSTRAINT FK_careerId_student_enrollments
    FOREIGN KEY(careerId) REFERENCES careers(careerId),
    CONSTRAINT FK_universityHeadquartersId_student_enrollments
    FOREIGN KEY(universityHeadquartersId) REFERENCES headquarters(universityHeadquartersId)
);

CREATE TABLE IF NOT EXISTS student_enrollments_school_data(
    studentEnrollmentsSchoolDataId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    addressId UUID,
    highSchoolGraduationYear YEAR NOT NULL,
    nameOfSecondarySchool VARCHAR(50) NOT NULL,
    privateStudyCenter BOOLEAN NOT NULL,
    CONSTRAINT FK_addressId_student_enrollments_school_data 
    FOREIGN KEY(addressId) REFERENCES addresses(addressId)
);

CREATE TABLE IF NOT EXISTS student_enrollments_meta_data (
    studentEnrollmentsMetaDataId UUID NOT NULL PRIMARY KEY DEFAULT (UUID()),
    fatherAddressId UUID,
    motherAddressId UUID,
    fatherInformationId UUID,
    motherInformationId UUID,
    spouseInformationId UUID,
    numberOfChildren INT UNSIGNED,
    dominantHand ENUM('DERECHA', 'IZQUIERDA'),
    healthIssuesDescription VARCHAR(250),
    CONSTRAINT FK_fatherAddressId_student_enrollments_meta_data 
    FOREIGN KEY (fatherAddressId) REFERENCES addresses(addressId),
    CONSTRAINT FK_motherAddressId_student_enrollments_meta_data 
    FOREIGN KEY (motherAddressId) REFERENCES addresses(addressId),
    CONSTRAINT FK_fatherInformationId_student_enrollments_meta_data 
    FOREIGN KEY (fatherInformationId) REFERENCES user_information(userInformationId),
    CONSTRAINT FK_motherInformationId_student_enrollments_meta_data 
    FOREIGN KEY (motherInformationId) REFERENCES user_information(userInformationId),
    CONSTRAINT FK_spouseInformationId_student_enrollments_meta_data 
    FOREIGN KEY (spouseInformationId) REFERENCES user_information(userInformationId)
);