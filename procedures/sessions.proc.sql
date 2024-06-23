DELIMITER $$

CREATE OR REPLACE PROCEDURE create_or_update_session(
    IN _sessionId UUID,
    IN _userId UUID,
    IN _ipAddress CHAR(21),
    IN _device VARCHAR(30),
    IN _accessToken VARCHAR(512),
    IN _refreshToken VARCHAR(512),
    IN _cratedAt DATETIME 
)
BEGIN
    INSERT INTO sessions(
        sessionId,
        userId,
        ipAddress,
        device,
        accessToken,
        refreshToken,
        cratedAt 
    ) 
    VALUES (
        _sessionId,
        _userId,
        _ipAddress,
        _device,en,
        _accessToken,
        _refreshToken,ken,
        _cratedAt 
     )
     ON DUPLICATE KEY UPDATE
        ipAddress = VALUES(ipAddress),
        accessToken = VALUES(accessToken),
        updatedAt = CURRENT_TIMESTAMP(); 
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_sessions_by_id_or_user(
    IN _sessionId UUID,
    IN _userId UUID,
    IN _nickname VARCHAR(50)
)
BEGIN
    SELECT s.* FROM sessions s
    INNER JOIN users u ON s.userId = u.userId
    WHERE s.sessionId = _sessionId OR s.userId = _userId OR u.nickname = _nickname;
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