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
(9, "Drinks");

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
("Tomatoes", "Produce"),
("Beef", "Meat"),
("Lamb", "Meat"),
("Eggs", "Eggs"),
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
("carrot", "Produce");



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
(1, "Chicken Pesto Sandwich", 13.19, DATE '2015-12-17'),
(1, "Prosciutto Sandwich", 13.19, DATE '2015-12-27'),
(2, "Bolognese", 13.19, DATE '2015-12-17'),
(3, "Eggs & Toast", 14.25, DATE '2010-04-25'),
(4, "Beef Tartare", 40.00, DATE '2017-03-12'),
(5, "House Pinot Noir (6 oz)", 8.00, DATE '2022-06-01'),
(6, "9 Course Tasting", 49.00, DATE '2023-02-15'),
(7, "Cumin Coconut Mussles", 18.00, DATE '2023-03-20'),
(8, "Khao Soi", 22.00, DATE '2019-07-12'),
(9, "Thai Mojito", 13.00, DATE '2016-04-27');


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
;

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
;

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
(1, 3, DATE '2015-12-17'),
(2, 1, DATE '2015-12-17'),
(3, 3, DATE '2015-12-17'),
(4, 2, DATE '2015-12-17'),
(5, 3, DATE '2015-12-17'),
(6, 3, DATE '2015-12-17'),
(7, 2, DATE '2015-12-17'),
(8, 4, DATE '2015-12-17'),
(9, 4, DATE '2015-12-17'),
(10, 3, DATE '2015-12-17'),
(11, 5, DATE '2015-12-17'),
(12, 3, DATE '2015-12-17'),
(13, 3, DATE '2015-12-17'),
(14, 3, DATE '2015-12-17'),
(15, 1, DATE '2015-12-17'),
(16, 3, DATE '2015-12-17'),
(17, 3, DATE '2015-12-17'),
(18, 5, DATE '2015-12-17'),
(19, 3, DATE '2015-12-17'),
(20, 3, DATE '2015-12-17');

INSERT INTO CanCook(EID, MID, DName) VALUES
(2, 1, "Chicken Pesto Sandwich"),
(2, 1, "Prosciutto Sandwich", 13.19, DATE '2015-12-27'),
(2, 2, "Bolognese", 13.19, DATE '2015-12-17'),
(4, 3, "Eggs & Toast", 14.25, DATE '2010-04-25'),
(5, 4, "Beef Tartare", 40.00, DATE '2017-03-12'),
(5, 5, "House Pinot Noir (6 oz)", 8.00, DATE '2022-06-01'),
(5, 7, "Cumin Coconut Mussles", 18.00, DATE '2022-06-11'),
(8, 6, "9 Course Tasting", 49.00, DATE '2023-02-15'),
(11, 7, "Cumin Coconut Mussles", 18.00, DATE '2023-03-20'),
(11, 8, "Khao Soi", 22.00, DATE '2019-07-12'),
(11, 9, "Thai Mojito", 13.00, DATE '2016-04-27');

INSERT INTO OrdersPlacedServedTaken(OID, TotalPrice, Date, SatisfactionRating, CEmail, RID, EID) VALUES
;

INSERT INTO Included(OID, MID, DName) VALUES
;