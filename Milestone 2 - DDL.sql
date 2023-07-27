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
(3, "Les Amis", "Kitsilano", "Montreal, QC, CA"),
(4, "Banana Leaf", "Kitsilano", "Vancouver, BC, CA"),
(5, "Banana Leaf", "Fairview", "Vancouver, BC, CA"),
(6, "PAI", "Downtown", "Toronto, ON, CA");

INSERT INTO RestaurantsName(Cuisine, RName) VALUES
("Italian", "Jo's Italian Deli"),
("Brunch", "Nelly's Brunch Pantry"),
("French", "Les Amis"),
("Malaysian", "Banana Leaf"),
("Thai", "PAI");

INSERT INTO MenusOffered(MID, MType, RID) VALUES
(1, "Sandwiches", 1),
(2, "Pastas", 1),
(3, "Brunch", 2),
(4, "Dinner", 3),
(5, "Happy Hour", 3),
(6, "Tasting Menu", 4),
(7, "Daily Special", 5),
(8, "Soups", 6),
(9, "Drinks", 1);

INSERT INTO Suppliers(SID, SName, SLocation) VALUES
(1, "Costco Business Centre", "Vancouver, BC, CA"),
(2, "Costco Business Centre", "Montreal, QC, CA"),
(3, "Costco Business Centre", "Toronto, ON, CA"),
(4, "Local Farm", "Delta, BC, CA"),
(5, "Italian Import Specialist", "Vancouver, BC, CA");

INSERT INTO Ingredients(IName, IType) VALUES
("Chicken", "Meat"),
("Pesto", "Pantry"),
("Prosciutto", "Meat"),
("Tomato", "Produce"),
("Beef", "Meat"),
("Lamb", "Meat"),
("Eggs", "Meat"),
("Bread Slice", "Grains"),
("Butter", "Dairy"),
("House Pinot Noir", "Alcohol"),
("Papaya", "Produce"),
("Peanut Butter", "Pantry"),
("Coconut Milk", "Pantry"),
("Mussles", "Seafood"),
("Noodles", "Grains"),
("White Rum", "Alcohol"),
("Lime", "Produce");
("Carrot", "Produce");



INSERT INTO Supplied(IName, SID, Cost) VALUES
("Chicken", 1, 50),
("Pesto", 5, 20),
("Prosciutto", 5, 30),
("Tomatoes", 5, 10.50),
("Beef", 2, 40),
("Beef", 3, 50),
("Eggs", 1, 10.32),
("Bread Slice", 1, 0.1),
("Butter", 4, 14),
("Peanut Butter", 3, 12),
("Coconut Milk", 1, 30);


INSERT INTO DishesHad(MID, DName, DType, Price, DateIntroduced) VALUES
(1, "Chicken Pesto Sandwich", "Side", 13.19, '2015-12-17'),
(1, "Prosciutto Sandwich", "Side", 13.19, '2015-12-27'),
(2, "Bolognese", 13.19, "Side", '2015-12-17'),
(3, "Eggs & Toast", "Breafast", 14.25, '2010-04-25'),
(4, "Beef Tartare", "Main", 40.00, '2017-03-12'),
(5, "House Pinot Noir (6 oz)", "Side",  8.00, '2022-06-01'),
(6, "9 Course Tasting", "Main", 49.00, '2023-02-15'),
(7, "Cumin Coconut Mussles", "Main", 18.00, '2023-03-20'),
(8, "Khao Soi", 22.00, "Main", '2019-07-12'),
(9, "Thai Mojito", 13.00, "Main", '2016-04-27');


INSERT INTO Contained(MID, DName, IName, Quantity) VALUES
(1, "Chicken Pesto Sandwich", "Chicken", "100 g"),
(1, "Chicken Pesto Sandwich", "Pesto", "15 g"),
(1, "Prosciutto Sandwich", "Prosciutto", "100 g"),
(2, "Bolognese", "Tomatoes", "200 g"),
(2, "Bolognese", "Beef", "50 g"),
(3, "Eggs & Toast", "Eggs", "2"),
(3, "Eggs & Toast", "Bread Slice", "2"),
(3, "Eggs & Toast", "Butter", "10 g"),
(4, "Beef Tartare", "Beef", "50 g"),
(5, "House Pinot Noir (6 oz)", "House Pinot Noir", "6 oz"),
(6, "9 Course Tasting", "Beef", "100 g"),
(6, "9 Course Tasting", "Papaya", "200 g"),
(6, "9 Course Tasting", "Peanut Butter", "30 g"),
(7, "Cumin Coconut Mussles", "Coconut Milk", "150 mL"),
(7, "Cumin Coconut Mussles", "Mussles", "100 g"),
(8, "Khao Soi", "Coconut Milk", "300 mL"),
(8, "Khao Soi", "Noodles", "200 g"),
(8, "Khao Soi", "Chicken", "60 g"),
(9, "Thai Mojito", "White Rum", "1.5 oz"),
(9, "Thai Mojito", "Lime", "1 oz");

INSERT INTO Customers(CEmail, PhoneNo, CName) VALUES
("johnny@hotmail.com", "604-223-1928", "Johnny Walker")
("peter@gmail.com", "604-111-2222", "Peter Cooks")
("jennifer@gmail.com", "604-222-1111", "Jennifer Tao")
("delpiero@gmail.com", "604-213-4444", "Alex Delpiero")
("casaraghi@gmail.com", "604-198-6464", "Alex Casaraghi")
("bierhoff@gmail.com", "237-122-9810", "Oliver Bierhoff")
("oliver@gmail.com", "237-114-0100", "Oliver Chow")
("donald@gmail.com", "237-009-9191", "Donald Acton")
("amy@gmail.com", "237-999-0099", "Amy Lee")
("schevechenko@gmail.com", "604-122-3333", "Andrie Schevechenko")
("hernan@gmail.com", "604-888-9999", "Hernan Crespo")
("gabriel@gmail.com", "604-332-2211", "Gabriel Batistuta")
("riken@gmail.com", "237-999-1111", "Riken")
("moller@gmail.com", "237-199-0000", "Andreas Moller")
("gomez@gmail.com", "237-333-1010", "Mario Gomez")
("jurgen@gmail.com", "237-000-1111", "Jurgen Klinsmen");

INSERT INTO EmployeesMain(EID, EName, AnnualSalary) VALUES
(1, "Alice Johnson", 35000),
(2, "Mark Ramirez", 30000),
(3, "Sarah Thompson", 32000),
(4, "James Lee", 28000),
(5, "Emily Martinez", 33000),
(6, "Michael Robinson", 29000),
(7, "Jessica Nguyen", 31000),
(8, "William Patel", 27000),
(9, "Jennifer Smith", 64000),
(10, "Robert Kim", 30500),
(11, "Laura Garcia", 33500),
(12, "Daniel Jackson", 28500),
(13, "Samantha Chen", 31500),
(14, "Christopher Brown", 29500),
(15, "Elizabeth Wilson", 32500),
(16, "Thomas Davis", 10500),
(17, "Ashley Rodriguez", 34500),
(18, "Kevin Taylor", 30200),
(19, "Amanda Wright", 33200),
(20, "Ryan Lewis", 28200);

INSERT INTO EmployeesSalary(AnnualSalary, FulltimeStatus) VALUES
(35000, 1),
(30000, 1),
(32000, 1),
(28000, 0),
(33000, 1)
(29000, 0),
(31000, 1),
(27000, 0),
(64000, 1),
(30500, 1),
(33500, 1),
(28500, 0),
(31500, 1),
(29500, 0),
(32500, 1),
(10500, 0),
(34500, 1),
(30200, 1),
(33200, 1),
(28200, 0);

INSERT INTO Servers(EID, AlcoholServingCertification) VALUES
(1, 1),
(3, 0),
(6, 0),
(10, 1),
(14, 1);

INSERT INTO Cooks(EID, Rank) VALUES
(2, 'Head Chef'),
(4, 'Head Chef'),
(5, 'Line Cook'),
(8, 'Sous Chef'),
(11, 'Head Chef');

INSERT INTO ManagersManaged(EID, RID) VALUES
(1, 3),
(7, 2),
(9, 4),
(15, 1),
(18, 5);

INSERT INTO Employed(EID, RID, DateEmployed) VALUES
(1, 3, '2015-12-17'),
(2, 1, '2015-12-17'),
(3, 3, '2015-12-17'),
(4, 2, '2015-12-17'),
(5, 3, '2015-12-17'),
(6, 3, '2015-12-17'),
(7, 2, '2015-12-17'),
(8, 4, '2015-12-17'),
(9, 4, '2015-12-17'),
(10, 3, '2015-12-17'),
(11, 5, '2015-12-17'),
(12, 3, '2015-12-17'),
(13, 3, '2015-12-17'),
(14, 3, '2015-12-17'),
(15, 1, '2015-12-17'),
(16, 3, '2015-12-17'),
(17, 3, '2015-12-17'),
(18, 5, '2015-12-17'),
(19, 3, '2015-12-17'),
(20, 3, '2015-12-17');

INSERT INTO CanCook(EID, MID, DName) VALUES
(2, 1, "Chicken Pesto Sandwich"),
(2, 1, "Prosciutto Sandwich"),
(2, 2, "Bolognese"),
(4, 3, "Eggs & Toast"),
(5, 4, "Beef Tartare"),
(5, 5, "House Pinot Noir (6 oz)"),
(5, 7, "Cumin Coconut Mussles"),
(8, 6, "9 Course Tasting"),
(11, 7, "Cumin Coconut Mussles"),
(11, 8, "Khao Soi"),
(11, 9, "Thai Mojito");

INSERT INTO OrdersPlacedServedTaken(OID, TotalPrice, Date, SatisfactionRating, CEmail, RID, EID) VALUES
(1, 13.19, DATE '2023-08-11', 4, "johnny@hotmail.com", 3 ,1),
(2, 13.19, DATE '2021-02-11', 8, "peter@gmail.com", 1 ,2),
(3, 14.25, DATE '2018-09-03', 8, "jennifer@gmail.com", 3 ,3),
(4, 13.19, DATE '2019-11-21', 7, "delpiero@gmail.com", 2 ,4),
(5, 13.19, DATE '2021-02-11', 7, "casaraghi@gmail.com", 3 ,5),
(6, 22.00, DATE '2021-07-03', 6, "bierhoff@gmail.com", 3 ,6),
(7, 13.00, DATE '2022-12-21', 4, "oliver@gmail.com", 2 ,7),
(8, 14.25, DATE '2020-07-03', 6, "donald@gmail.com", 4 ,8),
(9, 18.00, DATE '2020-12-21', 9, "amy@gmail.com", 4 ,9),
(10, 18.00, DATE '2020-12-21', 9, "schevechenko@gmail.com", 3 ,10),
(11, 14.25, DATE '2019-03-24', 7, "hernan@gmail.com", 5 ,11),
(12, 18.00, DATE '2018-04-08', 6, "hernan@gmail.com", 3 ,12),
(13, 22.00, DATE '2021-11-16', 3, "gabriel@gmail.com", 3 ,13),
(14, 40.00, DATE '2022-11-13', 6, "gabriel@gmail.com", 3 ,14),
(15, 13.19, DATE '2023-10-01', 9, "riken@gmail.com", 1 ,15),
(16, 49.00, DATE '2023-06-17', 7, "andreas@gmail.com", 3 ,16),
(17, 22.00, DATE '2018-03-13', 5, "moller@gmail.com", 3 ,17),
(18, 14.25, DATE '2023-03-13', 7, "moller@gmail.com", 3 ,17),
(19, 22.00, DATE '2023-03-13', 7, "gabriel@gmail.com", 3 ,17),
(20, 49.00, DATE '2020-02-23', 7, "gomez@gmail.com", 3 ,19),
(21, 49.00, DATE '2022-07-10', 8, "jurgen@gmail.com", 3 ,20),
(22, 14.25, DATE '2023-06-17', 7, "gomez@gmail.com", 5 ,11),
(23, 13.19, DATE '2023-06-17', 8, "jurgen@gmail.com", 5 ,11),
(24, 13.19, DATE '2023-06-17', 7, "bierhoff@gmail.com", 5 ,11),
(25, 8.00, DATE '2023-07-26', 5, "jurgen@gmail.com", 3 ,12),
(26, 8.00, DATE '2023-07-26', 5, "gomez@gmail.com", 3 ,12),
(27, 8.00, DATE '2023-07-27', 6, "bierhoff@gmail.com", 3 ,12);


INSERT INTO Included(OID, MID, DName) VALUES
(1, 1, "Chicken Pesto Sandwich"),
(2, 1, "Prosciutto Sandwich"),
(3, 3, "Eggs & Toast"),
(4, 2, "Bolognese"),
(5, 2, "Bolognese"),
(6, 8, "Khao Soi"),
(7, 9, "Thai Mojito"),
(8, 3, "Eggs & Toast"),
(9, 7, "Cumin Coconut Mussles"),
(10, 7, "Cumin Coconut Mussles"),
(11, 3, "Eggs & Toast"),
(12, 7 "Cumin Coconut Mussles"),
(13, 8, "Khao Soi"),
(14, 4, "Beef Tartare"),
(15, 1, "Prosciutto Sandwich"),
(16, 6, "9 Course Tasting"),
(17, 8, "Khao Soi"),
(18, 3, "Eggs & Toast"),
(19, 8, "Khao Soi"),
(20, 6, "9 Course Tasting"),
(21, 6, "9 Course Tasting"),
(22, 3, "Eggs & Toast"),
(23, 1, "Chicken Pesto Sandwich"),
(24, 1, "Chicken Pesto Sandwich"),
(25, 5, "House Pinot Noir (6 oz)"),
(26, 5, "House Pinot Noir (6 oz)"),
(27, 5, "House Pinot Noir (6 oz)");