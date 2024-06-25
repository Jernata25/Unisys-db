CREATE TABLE IF NOT EXISTS subjects_rooms(
    subjectRoomId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    subjectId UUID NOT NULL,
    roomId UUID NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT FK_subjectId_subjects_rooms
    FOREIGN KEY (subjectId) REFERENCES subjects(subjectId),
    CONSTRAINT FK_roomId_subjects_rooms
    FOREIGN KEY (roomId) REFERENCES rooms(roomId)
);