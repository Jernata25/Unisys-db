DELIMITER $$

CREATE OR REPLACE PROCEDURE create_or_update_enrollment(
    IN _studentEnrollmentId UUID,
    IN _studentId UUID,
    IN _addressId UUID,
    IN _careerId UUID,
    IN _universityHeadquartersId UUID,
    IN _studentEnrollmentCode CHAR(14),
    IN _academicRegime VARCHAR(50),
    IN _studyPlan VARCHAR(50), 
    IN _paymentNumber VARCHAR(20),
    IN _enrollmentNumber VARCHAR(20),
    IN _civilStatus VARCHAR(20),
    IN _dni VARCHAR(20),
    IN _nativeLanguage VARCHAR(30),
    IN _ethnicity VARCHAR(20), 
    IN _modality VARCHAR(20),
    IN _shift VARCHAR(20),
    IN _levelOfEducation VARCHAR(50),
    IN _uniqueStudentCode VARCHAR(20),
    IN _professionalActivity VARCHAR(50),
    IN _createdAt DATETIME,
    IN _updatedAt DATETIME
)
BEGIN
    INSERT INTO student_enrollments(
        studentEnrollmentId,
        studentId,
        addressId,
        careerId,
        universityHeadquartersId,
        studentEnrollmentCode,
        academicRegime,
        studyPlan,
        paymentNumber,
        enrollmentNumber,
        civilStatus,
        dni,
        nativeLanguage,
        ethnicity, 
        modality,
        shift,
        levelOfEducation,
        uniqueStudentCode,
        professionalActivity,
        createdAt
    )
    VALUES (
        _studentEnrollmentId,
        _studentId,
        _addressId,
        _careerId,
        _universityHeadquartersId,
        IF(_studentEnrollmentCode IS NULL, gen_student_enrollment(), _studentEnrollmentCode),
        _academicRegime,
        _studyPlan,
        _paymentNumber,
        _enrollmentNumber,
        _civilStatus,
        _dni,
        _nativeLanguage,
        _ethnicity, 
        _modality,
        _shift,
        _levelOfEducation,
        _uniqueStudentCode,
        _professionalActivity,
        _createdAt
    )
    ON DUPLICATE KEY UPDATE
        studentId = VALUES(studentId),
        addressId = VALUES(addressId),
        careerId = VALUES(careerId),
        universityHeadquartersId = VALUES(universityHeadquartersId),
        studentEnrollmentCode = VALUES(studentEnrollmentCode),
        academicRegime = VALUES(academicRegime),
        studyPlan = VALUES(studyPlan),
        paymentNumber = VALUES(paymentNumber),
        enrollmentNumber = VALUES(enrollmentNumber),
        civilStatus = VALUES(civilStatus),
        dni = VALUES(dni),
        nativeLanguage = VALUES(nativeLanguage),
        ethnicity = VALUES(ethnicity), 
        modality = VALUES(modality),
        shift = VALUES(shift),
        levelOfEducation = VALUES(levelOfEducation),
        uniqueStudentCode = VALUES(uniqueStudentCode),
        professionalActivity = VALUES(professionalActivity)
        updatedAt = IF(_updatedAt IS NULL, CURRENT_TIMESTAMP(), _updatedAt);
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_student_enrollment_by_id(
    IN _studentEnrollmentId UUID
)
BEGIN
    SELECT * FROM student_enrollments
    WHERE student_enrollments.studentEnrollmentId = _studentEnrollmentId;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_student_enrollments_by_student_id(
    IN _studentId UUID
)
BEGIN
    SELECT * FROM student_enrollments
    WHERE student_enrollments.studentId = _studentId;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_student_enrollment_by_enrollment_code(
    IN _studentEnrollmentCode CHAR(14)
)
BEGIN
    SELECT * FROM student_enrollments
    WHERE student_enrollments.studentEnrollmentCode = _studentEnrollmentCode;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE delete_student_enrollment_by_id(
    IN _studentEnrollmentId UUID
)
BEGIN
    DELETE FROM student_enrollments
    WHERE student_enrollments.studentEnrollmentId = _studentEnrollmentId;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE delete_student_enrollment_by_code(
    IN _studentEnrollmentCode UUID
)
BEGIN
    DELETE FROM student_enrollments
    WHERE student_enrollments.studentEnrollmentCode = _studentEnrollmentCode;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE search_student_enrollments(
    IN _queryLike VARCHAR(50),
    IN _limit INT UNSIGNED,
    IN _offset INT UNSIGNED,
    IN _order TEXT
)
BEGIN
    DECLARE dynamicQuery TEXT DEFAULT '
    SELECT sr.*, ui.names, ui.surnames, ui.studentCard FROM student_enrollments sr 
    INNER JOIN students s ON sr.studentId = s.studentId
    LEFT JOIN user_information ui ON s.userInformationId = ui.userInformationId
    WHERE ui.names LIKE ? OR ui.surnames LIKE ? OR s.studentCard LIKE ?
    ORDER BY ui.names ';

    IF validate_order(_order) THEN
        SET dynamicQuery = CONCAT(dynamicQuery, _order, ' LIMIT ? OFFSET ?');
        
        PREPARE stmt FROM dynamicQuery;
        SET @queryLike = CONCAT('%', _queryLike, '%');
        EXECUTE stmt USING @queryLike, @queryLike, @queryLike, _limit, _offset;
        DEALLOCATE PREPARE stmt;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid order parameter';
    END IF;
END;
$$

DELIMITER ;
