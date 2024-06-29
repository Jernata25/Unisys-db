DELIMITER $$

CREATE OR REPLACE PROCEDURE create_or_update_user(
    IN _userId UUID,
    IN _nickname VARCHAR(50),
    IN _passwd VARCHAR(72),
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
    DECLARE informationId UUID;
    DECLARE storedInformationId UUID;

    SELECT userInformationId INTO storedInformationId 
    FROM users WHERE users.userId = _userId; 

    IF storedInformationId IS NOT NULL THEN
        SET informationId = storedInformationId;
    ELSE 
        SET informationId = UUID();
    END IF;

    INSERT INTO user_information(
        userInformationId,
        names,
        surnames,
        gender,
        dateOfBirth,
        email,
        phoneNumber 
    )
    VALUES(
        informationId,
        _names,
        _surnames,
        _gender
        _dateOfBirth,
        _email,
        _phoneNumber 
    )
    ON DUPLICATE KEY UPDATE
    names = VALUES(names),
    surnames = VALUES(surnames),
    gender = VALUES(gender),
    dateOfBirth = VALUES(dateOfBirth),
    email = VALUES(email),
    phoneNumber = VALUES(phoneNumber);

    INSERT INTO users(
        userId,
        passwd,
        userInformationId,
        nickname,
        userRole,
        createdAt
    )
    VALUES (
        _userId,
        _passwd,
        informationId,
        _nickname,
        _userRole,
        _createdAt
    ) 
    ON DUPLICATE KEY UPDATE
    nickname = VALUES(nickname),
    passwd = VALUES(nickname),
    userRole = VALUES(userRole),
    createdAt = CURRENT_TIMESTAMP();
END$$

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
    _withUserInfo BOOLEAN,
    _order TEXT
)
BEGIN
    DECLARE dynamicQuery TEXT DEFAULT 'SELECT u.*' ;
    IF validate_order(_order) THEN
        SET dynamicQuery = CONCAT(
            dynamicQuery,
            IF(_withUserInfo, ', i.* FROM users u INNER JOIN user_information i ON u.userInformationId = i.userInformationId', ' FROM users u'),
            ' WHERE nickname LIKE ? ORDER BY nickname ',
            _order
        );
        EXECUTE IMMEDIATE dynamicQuery USING CONCAT('%', _nicknameLike, '%');
     ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid order parameter';
    END IF;
END;
$$

DELIMITER ;