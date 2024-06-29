CREATE TABLE IF NOT EXISTS careers(
    careerId UUID NOT NULL UUID(),
    careerCode CHAR(7) NOT NULL UNIQUE DEFAULT gen_random_code(),
    careerName VARCHAR(80) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updateAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
);  