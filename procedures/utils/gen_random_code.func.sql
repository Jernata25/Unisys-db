DELIMITER $$

CREATE OR REPLACE FUNCTION gen_random_code() RETURNS CHAR(7)
BEGIN
    DECLARE randomNumbersLen INT DEFAULT 4;
    DECLARE newRandomCode CHAR(7);
    DECLARE prefixRandomCode CHAR(3) DEFAULT 'UNS'; 

    SET newRandomCode = '';
    SET @i = 0;

    WHILE @i < randomNumbersLen DO
        SET newRandomCode = CONCAT(
            newRandomCode, 
            CAST(FLOOR(RAND() * 10) AS CHAR(1))
        );
        SET @i = @i + 1;
    END WHILE;

    SET newRandomCode = CONCAT(
        prefixRandomCode,
        newRandomCode
    );

    RETURN newRandomCode;
END$$

DELIMITER ;