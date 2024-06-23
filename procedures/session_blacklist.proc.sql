DELIMITER $$

CREATE OR REPLACE PROCEDURE create_banned_session(
    IN _sessionId UUID,
    IN _createdAt DATETIME
)
BEGIN
    INSERT INTO session_blacklist(sessionId, createdAt)
    VALUES (_sessionId, _createdAt);
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_banned_session_by_id(
    IN _sessionId UUID
)
BEGIN
    SELECT * FROM session_blacklist 
    WHERE session_blacklist.sessionId = _sessionId;
END$$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE PROCEDURE get_banned_session_by_token(
    IN _token VARCHAR(512)
)
BEGIN
    SELECT s.* FROM session_blacklist sb
    INNER JOIN sessions s
    ON sb.sessionId = s.sessionId
    WHERE s.accessToken = _token OR s.refreshToken = _token;
END$$

DELIMITER ;