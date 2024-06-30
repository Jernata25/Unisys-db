CREATE TABLE sessions (
    sessionId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    userId UUID NOT NULL,
    ipAddress CHAR(21) NOT NULL,
    device VARCHAR(30) NOT NULL DEFAULT 'UNKNOWN',
    accessToken VARCHAR(1500) NOT NULL,
    refreshToken VARCHAR(1500) NOT NULL,
    cratedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_userId_sessions 
    FOREIGN KEY(userId) REFERENCES users(userId)
    ON DELETE CASCADE
);

CREATE TABLE session_blacklist (
    sessionBlacklistId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    sessionId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_sessionId_session_blacklist
    FOREIGN KEY (sessionId) REFERENCES sessions(sessionId)
    ON DELETE CASCADE
);