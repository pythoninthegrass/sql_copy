CREATE DATABASE testdb;
GO

USE testdb;
GO

CREATE TABLE fake_users (
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    occupation NVARCHAR(100),
    dob DATE,
    country NVARCHAR(100)
);
GO
