DELIMITER $$
CREATE OR REPLACE PROCEDURE create_or_update_user(
    IN _userId UUID,
    IN _nickname VARCHAR(50),
    IN _userRole CHAR(20),
    IN _createdAt DATETIME,
    IN _names VARCHAR(50),
    IN _surnames VARCHAR(50),
    IN _dateOfBirth DATETIME,
    IN _gender CHAR(20),
    IN _email VARCHAR(60),
    IN _phoneNumber VARCHAR(16)
)
BEGIN
    INSERT INTO users(
        userId,
        nickname,
        userRole,
        createdAt,
        names,
        surnames,
        dateOfBirth,
        gender,
        email,
        phoneNumbe
    )
    VALUES (
        _userId,
        _nickname,
        _userRole,
        _createdAt,
        _names,
        _surnames,
        _dateOfBirth,
        _gender,
        _email,
        _phoneNumber
    ) 
    ON DUPLICATE KEY UPDATE
    nickname = VALUES(nickname),
    userRole = VALUES(userRole),
    names = VALUES(names),
    surnames = VALUES(surnames),
    dateOfBirth = VALUES(dateOfBirth),
    gender = VALUES(gender),
    email = VALUES(email),
    phoneNumber = VALUES(phoneNumber);
    updatedAt = CURRENT_TIMESTAMP();
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE delete_user_by_id(
    _userId UUID
)
BEGIN
    DELETE FROM users WHERE users.userId = _userId;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_user_by_id_or_nick(
    _userId UUID,
    _nickname VARCHAR(50)
) 
BEGIN
    SELECT * FROM users 
    WHERE users.userId = _userId OR users.nickname = _nickname;
END;
$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE search_user_by_name(
    _nicknameLike VARCHAR(50),
    _order TEXT
)
BEGIN
    DECLARE dynamicQuery TEXT;
    IF validate_order(_order) THEN
        SET dynamicQuery =  CONCAT('SELECT * FROM users WHERE nickname LIKE ? ORDER BY nickname ', _order);
        PREPARE stmt FROM dynamicQuery;
        EXECUTE stmt USING CONCAT('%', _nicknameLike, '%');
        DEALLOCATE PREPARE stmt;
     ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid order parameter';
    END IF;
END;
$$

DELIMITER ;