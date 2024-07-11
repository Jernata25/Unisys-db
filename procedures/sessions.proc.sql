DELIMITER $$

CREATE OR REPLACE PROCEDURE create_or_update_session(
    IN _sessionId UUID,
    IN _userId UUID,
    IN _ipAddress CHAR(23),
    IN _agent VARCHAR(800),
    IN _accessToken VARCHAR(1500),
    IN _refreshToken VARCHAR(1500),
    IN _cratedAt DATETIME,
    IN _updatedAt DATETIME
)
BEGIN
    INSERT INTO sessions(
        sessionId,
        userId,
        ipAddress,
        agent,
        accessToken,
        refreshToken,
        cratedAt 
    ) 
    VALUES (
        _sessionId,
        _userId,
        _ipAddress,
        _agent,
        _accessToken,
        _refreshToken,
        _cratedAt 
     )
     ON DUPLICATE KEY UPDATE
        ipAddress = VALUES(ipAddress),
        accessToken = VALUES(accessToken),
        updatedAt = IF(_updatedAt IS NULL, CURRENT_TIMESTAMP(), _updatedAt);
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_sessions_by_user(
    IN _userId UUID,
    IN _nickname VARCHAR(50)
)
BEGIN
    SELECT s.* FROM sessions s
    INNER JOIN users u ON s.userId = u.userId
    WHERE s.userId = _userId OR u.nickname = _nickname;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_session_by_id(
    IN _sessionId UUID
)
BEGIN
    SELECT * FROM sessions
    WHERE sessions.sessionId = _sessionId;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_sessions_by_ip(
    _ipAddress VARCHAR(21)
)
BEGIN
    SELECT * FROM sessions
    WHERE sessions.ipAddress = _ipAddress;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE delete_session_by_id(
    _sessionId UUID
)
BEGIN
    DELETE FROM sessions
    WHERE sessions.sessionId = _sessionId;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE delete_session_by_token(
    _token VARCHAR(1500)
)
BEGIN
    DELETE FROM sessions
    WHERE sessions.accessToken = _token OR sessions.refreshToken = _token;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE clear_sessions_by_user_id(
    _userId VARCHAR(512)
)
BEGIN
    DELETE FROM sessions
    WHERE sessions.userId = _userId;
END$$

DELIMITER ;