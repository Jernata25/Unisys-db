CREATE TABLE addresses (
    addressId UUID NOT NULL PRIMARY KEY DEFAULT UUID(),
    countryId UUID NOT NULL,
    city VARCHAR(15),
    details VARCHAR(50),
    zipCode CHAR(6),
    CONSTRAINT FK_countryId_address 
    FOREIGN KEY(countryId) REFERENCES countries(countryId)
);