-- CREATE TABLES

CREATE TABLE RestaurantsMain(
    RID INTEGER PRIMARY KEY,
    RName CHAR(32),
    Branch CHAR(32),
    RLocation CHAR(32),
    UNIQUE(RName, Branch, RLocation)
);

CREATE TABLE RestaurantsName(
    Cuisine CHAR(32),
    RName CHAR(32) PRIMARY KEY
);

CREATE TABLE MenusOffered(
    MID INTEGER PRIMARY KEY,
    MType CHAR(32),
    RID INTEGER NOT NULL,
    FOREIGN KEY (RID) REFERENCES RestaurantsMain(RID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE Suppliers(
    SID INTEGER PRIMARY KEY,
    SName CHAR(32),
    SLocation CHAR(32)
    UNIQUE(SName, SLocation)
);

CREATE TABLE Ingredients(
    IName CHAR(32) PRIMARY KEY,
    IType CHAR(32)
);

CREATE TABLE Supplied(
    IName CHAR(32),
    SID INTEGER,
    Cost REAL,
    PRIMARY KEY (IName, SID),
    FOREIGN KEY (IName) REFERENCES Ingredients(IName) 
        ON DELETE NO ACTION 
        ON UPDATE CASCADE,
    FOREIGN KEY (SID) REFERENCES Suppliers(SID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE DishesHad(
    MID INTEGER,
    DName CHAR(32),
    DType CHAR(32),
    Price REAL,
    DateIntroduced DATE,
    PRIMARY KEY (MID, DName),
    FOREIGN KEY (MID) REFERENCES MenusOffered(MID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE Contained(
    MID INTEGER,
    DName CHAR(32),
    IName CHAR(32),
    Quantity CHAR(32),
    PRIMARY KEY (MID, DName, IName),
    FOREIGN KEY (MID, DName) REFERENCES DishesHad(MID, DName) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (IName) REFERENCES Ingredients(IName) 
        ON DELETE NO ACTION 
        ON UPDATE CASCADE
);

CREATE TABLE Customers(
    CEmail CHAR(32) PRIMARY KEY,
    PhoneNo CHAR(16),
    CName CHAR(32),
    UNIQUE (CName, PhoneNo)
);

CREATE TABLE EmployeesMain(
    EID INTEGER PRIMARY KEY,
    EName CHAR(32),
    AnnualSalary REAL
);

CREATE TABLE EmployeesSalary(
    AnnualSalary REAL PRIMARY KEY,
    FulltimeStatus BOOLEAN
);

CREATE TABLE Servers(
    EID INTEGER PRIMARY KEY,
    AlcoholServingCertification BOOLEAN,
    FOREIGN KEY (EID) REFERENCES EmployeesMain(EID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE Cooks(
    EID INTEGER PRIMARY KEY,
    Rank CHAR(32),
    FOREIGN KEY (EID) REFERENCES EmployeesMain(EID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE ManagersManaged(
    EID INTEGER PRIMARY KEY,
    RID INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (EID) REFERENCES EmployeesMain(EID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (RID) REFERENCES RestaurantsMain(RID) 
        ON DELETE NO ACTION 
        ON UPDATE CASCADE
);

CREATE TABLE Employed(
    EID INTEGER,
    RID INTEGER,
    DateEmployed DATE,
    PRIMARY KEY (EID, RID),
    FOREIGN KEY (EID) REFERENCES EmployeesMain(EID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (RID) REFERENCES RestaurantsMain(RID) 
        ON DELETE NO ACTION 
        ON UPDATE CASCADE
);

CREATE TABLE CanCook(
    EID INTEGER,
    MID INTEGER,
    DName CHAR(32),
    PRIMARY KEY (EID, MID, DName),
    FOREIGN KEY (EID) REFERENCES Cooks(EID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (MID, DName) REFERENCES DishesHad(MID, DName) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE OrdersPlacedServedTaken(
    OID INTEGER PRIMARY KEY,
    TotalPrice REAL,
    Date DATE,
    SatisfactionRating INTEGER,
    CEmail CHAR(32) NOT NULL,
    RID INTEGER NOT NULL,
    EID INTEGER NOT NULL,
    FOREIGN KEY (CEmail) REFERENCES Customers(CEmail) 
        ON DELETE SET DEFAULT 
        ON UPDATE CASCADE,
    FOREIGN KEY (RID) REFERENCES RestaurantsMain(RID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (EID) REFERENCES Servers(EID) 
        ON DELETE SET DEFAULT 
        ON UPDATE CASCADE
);

CREATE TABLE Included(
    OID INTEGER,
    MID INTEGER,
    DName CHAR(32),
    PRIMARY KEY (OID, MID, DName),
    FOREIGN KEY (OID) REFERENCES OrdersPlacedServedTaken(OID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (MID, DName) REFERENCES DishesHad(MID, DName) 
        ON DELETE SET DEFAULT 
        ON UPDATE CASCADE
);

-- INSERTIONS INTO TABLES

INSERT INTO RestaurantsMain(RID, RName, Branch, RLocation) VALUES
(1, "Jo's Italian Deli", "West Point Grey", "Vancouver, BC, CA"),
(2, "Nelly's Brunch Pantry", "Kitsilano", "Vancouver, BC, CA"),
(3, "Les Amis", "Kitsilano", "Montreal, QC, CA");

INSERT INTO RestaurantsName(Cuisine, RName) VALUES
("Italian", "Jo's Italian Deli"),
("Brunch", "Nelly's Brunch Pantry"),
("French", "Les Amis");

INSERT INTO MenusOffered(MID, MType, RID) VALUES
;

INSERT INTO Suppliers(SID, SName, SLocation) VALUES
;

INSERT INTO Ingredients(IName, IType) VALUES
;

INSERT INTO Supplied(IName, SID, Cost) VALUES
;

INSERT INTO DishesHad(MID, DName, DType, Price, DateIntroduced) VALUES
;

INSERT INTO Contained(MID, DName, IName, Quantity) VALUES
;

INSERT INTO Customers(CEmail, PhoneNo, CName) VALUES
;

INSERT INTO EmployeesMain(EID, EName, AnnualSalary) VALUES
;

INSERT INTO EmployeesSalary(AnnualSalary, FulltimeStatus) VALUES
;

INSERT INTO Servers(EID, AlcoholServingCertification) VALUES
;

INSERT INTO Cooks(EID, Rank) VALUES
(1, 'Head Chef'),
(2, 'Line Cook'),
(3, 'Sous Chef');

INSERT INTO ManagersManaged(EID, RID) VALUES
;

INSERT INTO Employed(EID, RID, DateEmployed) VALUES
;

INSERT INTO CanCook(EID, MID, DName) VALUES
;

INSERT INTO OrdersPlacedServedTaken(OID, TotalPrice, Date, SatisfactionRating, CEmail, RID, EID) VALUES
;

INSERT INTO Included(OID, MID, DName) VALUES
;