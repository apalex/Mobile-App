CREATE TABLE User_Info (
    User_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    First_Name TEXT NOT NULL,
    Last_Name TEXT NOT NULL,
    Username TEXT NOT NULL UNIQUE,
    Email TEXT NOT NULL UNIQUE,
    Password TEXT NOT NULL,
    Phone_Number TEXT NOT NULL
);

CREATE TABLE User_Address (
    User_ID INTEGER PRIMARY KEY,
    Address1 TEXT NOT NULL,
    Address2 TEXT,
    Country TEXT NOT NULL,
    Province TEXT NOT NULL,
    City TEXT NOT NULL,
    Zip_Code TEXT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User_Info(User_ID)
);

CREATE TABLE User_Portfolio (
    User_ID INTEGER,
    Overall_Balance REAL DEFAULT 0,
    Funding_Balance REAL DEFAULT 0,
    Trading_Balance REAL DEFAULT 0,
    Margins_Balance REAL DEFAULT 0,
    Futures_Balance REAL DEFAULT 0,
    Bot_Balance REAL DEFAULT 0,
    Finance_Balance REAL DEFAULT 0,
    FOREIGN KEY (User_ID) REFERENCES User_Info(User_ID)
);

CREATE TABLE User_Activity (
    User_ID INTEGER,
    ActivityTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES User_Info(User_ID)
);