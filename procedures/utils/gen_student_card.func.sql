DELIMITER $$

CREATE OR REPLACE FUNCTION gen_student_card() RETURNS CHAR(8)
BEGIN
    DECLARE cardLen INT DEFAULT 8;
    DECLARE newStudentCard CHAR(8);

    SET newStudentCard = '';
    SET @i = 0;

    WHILE @i < cardLen DO
        SET newStudentCard = CONCAT(
            newStudentCard, 
            IF(@i = cardLen - 2, '-', CAST(FLOOR(RAND() * 10) AS CHAR(1)))
        );
        SET @i = @i + 1;
    END WHILE;
    RETURN newStudentCard;
END$$

DELIMITER ;