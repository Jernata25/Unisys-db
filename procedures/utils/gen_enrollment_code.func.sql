DELIMITER $$

CREATE OR REPLACE FUNCTION gen_enrollment_code() RETURNS CHAR(14)
BEGIN
    DECLARE randomNumbersLen INT DEFAULT 5;
    DECLARE newEnrollmentCode CHAR(14);
    DECLARE prefixEnrollmentCode CHAR(9) DEFAULT CONCAT(
        'UNS', 
        DATE_FORMAT(CURRENT_TIMESTAMP(),'%d%m%y'
    ));

    SET newEnrollmentCode = '';
    SET @i = 0;

    WHILE @i < randomNumbersLen DO
        SET newEnrollmentCode = CONCAT(
            newEnrollmentCode, 
            CAST(FLOOR(RAND() * 10) AS CHAR(1))
        );
        SET @i = @i + 1;
    END WHILE;

    SET newEnrollmentCode = CONCAT(
        prefixEnrollmentCode,
        newEnrollmentCode
    );

    RETURN newEnrollmentCode;
END$$

DELIMITER ;