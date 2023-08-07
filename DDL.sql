-- DROP PRE-EXISTING TABLES IF NECESSARY 

DROP TABLE Restaurants_Main CASCADE CONSTRAINTS;
DROP TABLE Restaurants_Name CASCADE CONSTRAINTS;
DROP TABLE Menus_Offered CASCADE CONSTRAINTS;
DROP TABLE Suppliers CASCADE CONSTRAINTS;
DROP TABLE Ingredients CASCADE CONSTRAINTS;
DROP TABLE Supplied CASCADE CONSTRAINTS;
DROP TABLE Dishes_Had CASCADE CONSTRAINTS;
DROP Table Contained CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE Employees_Main CASCADE CONSTRAINTS;
DROP TABLE Employees_FT CASCADE CONSTRAINTS;
DROP TABLE Servers CASCADE CONSTRAINTS;
DROP TABLE Cooks CASCADE CONSTRAINTS;
DROP TABLE Managers_Managed CASCADE CONSTRAINTS;
DROP TABLE Employed CASCADE CONSTRAINTS;
DROP TABLE Can_Cook CASCADE CONSTRAINTS;
DROP TABLE Orders_Placed_Served_Taken CASCADE CONSTRAINTS;
DROP TABLE Included CASCADE CONSTRAINTS;

-- CREATE TABLES

CREATE TABLE Restaurants_Main(
    RID INTEGER PRIMARY KEY,
    RName CHAR(32),
    Branch CHAR(32),
    RLocation CHAR(32),
    UNIQUE(RName, Branch, RLocation)
);

 CREATE TABLE Restaurants_Name(
     Cuisine CHAR(32),
     RName CHAR(32) PRIMARY KEY
);

CREATE TABLE Menus_Offered(
    MID INTEGER PRIMARY KEY,
    MType CHAR(32),
    RID INTEGER NOT NULL,
    FOREIGN KEY (RID) REFERENCES Restaurants_Main (RID)
        ON DELETE CASCADE   
); 

CREATE TABLE Suppliers(
    SID INTEGER PRIMARY KEY,
    SName CHAR(32),
    SLocation CHAR(32),
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
        ON DELETE CASCADE,
    FOREIGN KEY (SID) REFERENCES Suppliers(SID) 
        ON DELETE CASCADE 
);

CREATE TABLE Dishes_Had(
    MID INTEGER,
    DName CHAR(32),
    DType CHAR(32),
    Price REAL,
    DateIntroduced DATE,
    PRIMARY KEY (MID, DName),
    FOREIGN KEY (MID) REFERENCES Menus_Offered(MID) 
        ON DELETE CASCADE 
);

CREATE TABLE Contained(
    MID INTEGER,
    DName CHAR(32),
    IName CHAR(32),
    Quantity CHAR(32),
    PRIMARY KEY (MID, DName, IName),
    FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
        ON DELETE CASCADE, 
    FOREIGN KEY (IName) REFERENCES Ingredients(IName) 
        ON DELETE CASCADE
);

CREATE TABLE Customers(
    CEmail CHAR(32) PRIMARY KEY,
    PhoneNo CHAR(16),
    CName CHAR(32),
    UNIQUE (CName, PhoneNo)
);

CREATE TABLE Employees_Main(
    EID INTEGER PRIMARY KEY,
    EName CHAR(32),
    HourlyWage REAL,
    HoursPerWeek REAL
);

CREATE TABLE Employees_FT(
    HoursPerWeek REAL PRIMARY KEY,
    FulltimeStatus NUMBER(1,0) 
);

CREATE TABLE Servers(
    EID INTEGER PRIMARY KEY,
    AlcoholServingCertification NUMBER(1,0),
    FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
        ON DELETE CASCADE 
);

CREATE TABLE Cooks(
    EID INTEGER PRIMARY KEY,
    Rank CHAR(32),
    FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
        ON DELETE CASCADE
);

CREATE TABLE Managers_Managed(
    EID INTEGER PRIMARY KEY,
    RID INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
        ON DELETE CASCADE, 
    FOREIGN KEY (RID) REFERENCES Restaurants_Main(RID) 
        ON DELETE CASCADE
);

CREATE TABLE Employed(
    EID INTEGER,
    RID INTEGER,
    DateEmployed DATE,
    PRIMARY KEY (EID, RID),
    FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
        ON DELETE CASCADE, 
    FOREIGN KEY (RID) REFERENCES Restaurants_Main(RID) 
        ON DELETE CASCADE
);

CREATE TABLE Can_Cook(
    EID INTEGER,
    MID INTEGER,
    DName CHAR(32),
    PRIMARY KEY (EID, MID, DName),
    FOREIGN KEY (EID) REFERENCES Cooks(EID) 
        ON DELETE CASCADE, 
    FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
        ON DELETE CASCADE 
);

CREATE TABLE Orders_Placed_Served_Taken(
    OID INTEGER PRIMARY KEY,
    TotalPrice REAL,
    Dates DATE,
    SatisfactionRating INTEGER,
    CEmail CHAR(32) NOT NULL,
    RID INTEGER NOT NULL,
    EID INTEGER NOT NULL,
    FOREIGN KEY (CEmail) REFERENCES Customers(CEmail)
        ON DELETE CASCADE,
    FOREIGN KEY (RID) REFERENCES Restaurants_Main(RID) 
        ON DELETE CASCADE,
    FOREIGN KEY (EID) REFERENCES Servers(EID) 
        ON DELETE CASCADE
);

CREATE TABLE Included(
    OID INTEGER,
    MID INTEGER,
    DName CHAR(32),
    PRIMARY KEY (OID, MID, DName),
    FOREIGN KEY (OID) REFERENCES Orders_Placed_Served_Taken(OID) 
        ON DELETE CASCADE, 
    FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
        ON DELETE CASCADE
);

-- INSERTIONS INTO TABLES

INSERT ALL 
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (1, 'Jo''s Italian Deli', 'West Point Grey', 'Vancouver, BC, CA')
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (2, 'Nelly''s Brunch Pantry', 'Kitsilano', 'Vancouver, BC, CA')
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (3, 'Les Amis', 'Kitsilano', 'Montreal, QC, CA')
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (4, 'Banana Leaf', 'Kitsilano', 'Vancouver, BC, CA')
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (5, 'Banana Leaf', 'Fairview', 'Vancouver, BC, CA')
INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (6, 'PAI', 'Downtown', 'Toronto, ON, CA')
SELECT *
  FROM dual;

INSERT ALL 
INTO Restaurants_Name(Cuisine, RName) VALUES ('Italian', 'Jo''s Italian Deli')
INTO Restaurants_Name(Cuisine, RName) VALUES ('Brunch', 'Nelly''s Brunch Pantry')
INTO Restaurants_Name(Cuisine, RName) VALUES ('French', 'Les Amis')
INTO Restaurants_Name(Cuisine, RName) VALUES ('Malaysian', 'Banana Leaf')
INTO Restaurants_Name(Cuisine, RName) VALUES ('Thai', 'PAI')
SELECT *
  FROM dual;

INSERT ALL 
INTO Menus_Offered(MID, MType, RID) VALUES (1, 'Sandwiches', 1)
INTO Menus_Offered(MID, MType, RID) VALUES (2, 'Pastas', 1)
INTO Menus_Offered(MID, MType, RID) VALUES (3, 'Brunch', 2)
INTO Menus_Offered(MID, MType, RID) VALUES (4, 'Dinner', 3)
INTO Menus_Offered(MID, MType, RID) VALUES (5, 'Happy Hour', 3)
INTO Menus_Offered(MID, MType, RID) VALUES (6, 'Tasting Menu', 4)
INTO Menus_Offered(MID, MType, RID) VALUES (7, 'Daily Special', 5)
INTO Menus_Offered(MID, MType, RID) VALUES (8, 'Soups', 6)
INTO Menus_Offered(MID, MType, RID) VALUES (9, 'Drinks', 1)
SELECT *
  FROM dual;

INSERT ALL
INTO Suppliers(SID, SName, SLocation) VALUES (1, 'Costco Business Centre', 'Vancouver, BC, CA')
INTO Suppliers(SID, SName, SLocation) VALUES (2, 'Costco Business Centre', 'Montreal, QC, CA')
INTO Suppliers(SID, SName, SLocation) VALUES (3, 'Costco Business Centre', 'Toronto, ON, CA')
INTO Suppliers(SID, SName, SLocation) VALUES (4, 'Local Farm', 'Delta, BC, CA')
INTO Suppliers(SID, SName, SLocation) VALUES (5, 'Italian Import Specialist', 'Vancouver, BC, CA')
SELECT *
    FROM dual;


INSERT ALL 
INTO Ingredients(IName, IType) VALUES ('Chicken', 'Meat')
INTO Ingredients(IName, IType) VALUES ('Pesto', 'Pantry')
INTO Ingredients(IName, IType) VALUES ('Prosciutto', 'Meat')
INTO Ingredients(IName, IType) VALUES ('Tomatoes', 'Produce')
INTO Ingredients(IName, IType) VALUES ('Beef', 'Meat')
INTO Ingredients(IName, IType) VALUES ('Lamb', 'Meat')
INTO Ingredients(IName, IType) VALUES ('Eggs', 'Meat')
INTO Ingredients(IName, IType) VALUES ('Bread Slice', 'Grains')
INTO Ingredients(IName, IType) VALUES ('Butter', 'Dairy')
INTO Ingredients(IName, IType) VALUES ('House Pinot Noir', 'Alcohol')
INTO Ingredients(IName, IType) VALUES ('Papaya', 'Produce')
INTO Ingredients(IName, IType) VALUES ('Peanut Butter', 'Pantry')
INTO Ingredients(IName, IType) VALUES ('Coconut Milk', 'Pantry')
INTO Ingredients(IName, IType) VALUES ('Mussles', 'Seafood')
INTO Ingredients(IName, IType) VALUES ('Noodles', 'Grains')
INTO Ingredients(IName, IType) VALUES ('White Rum', 'Alcohol')
INTO Ingredients(IName, IType) VALUES ('Lime', 'Produce')
INTO Ingredients(IName, IType) VALUES ('Carrot', 'Produce')
SELECT *
    FROM dual;

INSERT ALL
INTO Supplied(IName, SID, Cost) VALUES ('Chicken', 1, 50)
INTO Supplied(IName, SID, Cost) VALUES ('Pesto', 1, 25)
INTO Supplied(IName, SID, Cost) VALUES ('Prosciutto', 1, 25)
INTO Supplied(IName, SID, Cost) VALUES ('Tomatoes', 1, 25)
INTO Supplied(IName, SID, Cost) VALUES ('Beef', 1, 30)
INTO Supplied(IName, SID, Cost) VALUES ('Lamb', 1, 35)
INTO Supplied(IName, SID, Cost) VALUES ('Eggs', 1, 12.59)
INTO Supplied(IName, SID, Cost) VALUES ('Bread Slice', 1, 0.10)
INTO Supplied(IName, SID, Cost) VALUES ('Butter', 1, 20)
INTO Supplied(IName, SID, Cost) VALUES ('House Pinot Noir', 1, 25)
INTO Supplied(IName, SID, Cost) VALUES ('Papaya', 1, 30)
INTO Supplied(IName, SID, Cost) VALUES ('Peanut Butter', 1, 19.99)
INTO Supplied(IName, SID, Cost) VALUES ('Coconut Milk', 1, 22.50)
INTO Supplied(IName, SID, Cost) VALUES ('Mussles', 1, 50)
INTO Supplied(IName, SID, Cost) VALUES ('Noodles', 1, 15)
INTO Supplied(IName, SID, Cost) VALUES ('White Rum', 1, 25)
INTO Supplied(IName, SID, Cost) VALUES ('Lime', 1, 15)
INTO Supplied(IName, SID, Cost) VALUES ('Carrot', 1, 10)
INTO Supplied(IName, SID, Cost) VALUES ('Pesto', 5, 20)
INTO Supplied(IName, SID, Cost) VALUES ('Prosciutto', 5, 30)
INTO Supplied(IName, SID, Cost) VALUES ('Tomatoes', 5, 10.50)
INTO Supplied(IName, SID, Cost) VALUES ('Beef', 2, 40)
INTO Supplied(IName, SID, Cost) VALUES ('Beef', 3, 50)
INTO Supplied(IName, SID, Cost) VALUES ('Butter', 4, 14)
INTO Supplied(IName, SID, Cost) VALUES ('Peanut Butter', 3, 12)
SELECT *
    FROM dual;

INSERT ALL
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (1, 'Chicken Pesto Sandwich', 'Side', 13.19, DATE '2015-12-17')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (1, 'Prosciutto Sandwich', 'Side', 13.19, DATE '2015-12-27')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (2, 'Bolognese', 'Side', 13.19, DATE '2015-12-17')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (3, 'Eggs and Toast', 'Breakfast', 14.25, DATE '2010-04-25')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (4, 'Beef Tartare', 'Main', 40.00, DATE '2017-03-12')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (5, 'House Pinot Noir (6 oz)', 'Side',  8.00, DATE '2022-06-01')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (6, '9 Course Tasting', 'Main', 49.00, DATE '2023-02-15')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (7, 'Cumin Coconut Mussles', 'Main', 18.00, DATE '2023-03-20')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (8, 'Khao Soi', 'Main', 22.00, DATE '2019-07-12')
INTO Dishes_Had(MID, DName, DType, Price, DateIntroduced) VALUES (9, 'Thai Mojito', 'Main', 13.00, DATE '2016-04-27')
SELECT *
    FROM dual;

INSERT ALL
INTO Contained(MID, DName, IName, Quantity) VALUES (1, 'Chicken Pesto Sandwich', 'Chicken', '100 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (1, 'Chicken Pesto Sandwich', 'Pesto', '15 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (1, 'Prosciutto Sandwich', 'Prosciutto', '100 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (2, 'Bolognese', 'Tomatoes', '200 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (2, 'Bolognese', 'Beef', '50 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (3, 'Eggs and Toast', 'Eggs', '2')
INTO Contained(MID, DName, IName, Quantity) VALUES (3, 'Eggs and Toast', 'Bread Slice', '2')
INTO Contained(MID, DName, IName, Quantity) VALUES (3, 'Eggs and Toast', 'Butter', '10 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (4, 'Beef Tartare', 'Beef', '50 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (5, 'House Pinot Noir (6 oz)', 'House Pinot Noir', '6 oz')
INTO Contained(MID, DName, IName, Quantity) VALUES (6, '9 Course Tasting', 'Beef', '100 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (6, '9 Course Tasting', 'Papaya', '200 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (6, '9 Course Tasting', 'Peanut Butter', '30 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (7, 'Cumin Coconut Mussles', 'Coconut Milk', '150 mL')
INTO Contained(MID, DName, IName, Quantity) VALUES (7, 'Cumin Coconut Mussles', 'Mussles', '100 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (8, 'Khao Soi', 'Coconut Milk', '300 mL')
INTO Contained(MID, DName, IName, Quantity) VALUES (8, 'Khao Soi', 'Noodles', '200 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (8, 'Khao Soi', 'Chicken', '60 g')
INTO Contained(MID, DName, IName, Quantity) VALUES (9, 'Thai Mojito', 'White Rum', '1.5 oz')
INTO Contained(MID, DName, IName, Quantity) VALUES (9, 'Thai Mojito', 'Lime', '1 oz')
SELECT *
    FROM dual;

INSERT ALL 
INTO Customers(CEmail, PhoneNo, CName) VALUES ('johnny@hotmail.com', '604-223-1928', 'Johnny Walker')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('peter@gmail.com', '604-111-2222', 'Peter Cooks')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('jennifer@gmail.com', '604-222-1111', 'Jennifer Tao')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('delpiero@gmail.com', '604-213-4444', 'Alex Delpiero')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('casaraghi@gmail.com', '604-198-6464', 'Alex Casaraghi')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('bierhoff@gmail.com', '237-122-9810', 'Oliver Bierhoff')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('oliver@gmail.com', '237-114-0100', 'Oliver Chow')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('donald@gmail.com', '237-009-9191', 'Donald Acton')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('amy@gmail.com', '237-999-0099', 'Amy Lee')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('schevechenko@gmail.com', '604-122-3333', 'Andrie Schevechenko')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('hernan@gmail.com', '604-888-9999', 'Hernan Crespo')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('gabriel@gmail.com', '604-332-2211', 'Gabriel Batistuta')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('riken@gmail.com', '237-999-1111', 'Riken')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('moller@gmail.com', '237-199-0000', 'Andreas Moller')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('gomez@gmail.com', '237-333-1010', 'Mario Gomez')
INTO Customers(CEmail, PhoneNo, CName) VALUES ('jurgen@gmail.com', '237-000-1111', 'Jurgen Klinsmen')
SELECT *
    FROM dual;

INSERT ALL 
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (1, 'Alice Johnson', 30, 50)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (2, 'Mark Ramirez', 26.50, 20)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (3, 'Sarash Thompson', 14, 5)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (4, 'James Lee', 27, 35)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (5, 'Emily Martinez', 16.25, 10)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (6, 'Michael Robinson', 16.5, 37.5)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (7, 'Jessica Nguyen', 28.50, 50)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (8, 'William Patel', 22.30, 20)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (9, 'Jennifer Smith', 32.75, 40)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (10, 'Robert Kim', 15, 35)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (11, 'Laura Garcia', 32.50, 37.5)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (12, 'Daniel Jackson', 17, 20)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (13, 'Samantha Chen', 16, 10)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (14, 'Christopher Brown', 18.5, 40)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (15, 'Elizabeth Wilson', 28.25, 40)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (16, 'Thomas Davis', 16.30, 35)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (17, 'Ashley Rodriguez', 15.50, 20)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (18, 'Kevin Taylor', 29.50, 40)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (19, 'Amanda Wright', 17.25, 35)
INTO Employees_Main(EID, EName, HourlyWage, HoursPerWeek) VALUES (20, 'Ryan Lewis', 17.25, 37.5)
SELECT *
    FROM dual;

INSERT ALL 
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (37.5, 1)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (40, 1)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (50, 1)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (35, 1)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (5, 0)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (10, 0)
INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (20, 1)
SELECT *
    FROM dual;

INSERT ALL 
INTO Servers(EID, AlcoholServingCertification) VALUES (1, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (2, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (3, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (4, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (5, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (6, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (7, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (8, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (9, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (10, 0)
INTO Servers(EID, AlcoholServingCertification) VALUES (11, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (12, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (13, 0)
INTO Servers(EID, AlcoholServingCertification) VALUES (14, 0)
INTO Servers(EID, AlcoholServingCertification) VALUES (15, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (16, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (17, 0)
INTO Servers(EID, AlcoholServingCertification) VALUES (18, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (19, 1)
INTO Servers(EID, AlcoholServingCertification) VALUES (20, 0)
SELECT *
    FROM dual;

INSERT ALL 
INTO Cooks(EID, Rank) VALUES (2, 'Head Chef')
INTO Cooks(EID, Rank) VALUES (4, 'Head Chef')
INTO Cooks(EID, Rank) VALUES (5, 'Line Cook')
INTO Cooks(EID, Rank) VALUES (8, 'Sous Chef')
INTO Cooks(EID, Rank) VALUES (11, 'Head Chef')
SELECT *
    FROM dual;

INSERT ALL 
INTO Managers_Managed(EID, RID) VALUES (1, 3)
INTO Managers_Managed(EID, RID) VALUES (7, 2)
INTO Managers_Managed(EID, RID) VALUES (9, 4)
INTO Managers_Managed(EID, RID) VALUES (15, 1)
INTO Managers_Managed(EID, RID) VALUES (18, 5)
SELECT *
    FROM dual;

INSERT ALL 
INTO Employed(EID, RID, DateEmployed) VALUES (1, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (2, 1, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (3, 1, DATE '2015-12-20')
INTO Employed(EID, RID, DateEmployed) VALUES (3, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (4, 2, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (6, 2, DATE '2015-11-15')
INTO Employed(EID, RID, DateEmployed) VALUES (5, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (6, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (7, 2, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (8, 4, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (9, 4, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (10, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (11, 5, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (12, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (13, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (14, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (15, 1, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (16, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (17, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (18, 5, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (19, 3, DATE '2015-12-17')
INTO Employed(EID, RID, DateEmployed) VALUES (20, 3, DATE '2015-12-17')
SELECT *
    FROM dual;

INSERT ALL 
INTO Can_Cook(EID, MID, DName) VALUES (2, 1, 'Chicken Pesto Sandwich')
INTO Can_Cook(EID, MID, DName) VALUES (2, 1, 'Prosciutto Sandwich')
INTO Can_Cook(EID, MID, DName) VALUES (2, 2, 'Bolognese')
INTO Can_Cook(EID, MID, DName) VALUES (4, 3, 'Eggs and Toast')
INTO Can_Cook(EID, MID, DName) VALUES (5, 4, 'Beef Tartare')
INTO Can_Cook(EID, MID, DName) VALUES (5, 5, 'House Pinot Noir (6 oz)')
INTO Can_Cook(EID, MID, DName) VALUES (5, 7, 'Cumin Coconut Mussles')
INTO Can_Cook(EID, MID, DName) VALUES (8, 6, '9 Course Tasting')
INTO Can_Cook(EID, MID, DName) VALUES (11, 7, 'Cumin Coconut Mussles')
INTO Can_Cook(EID, MID, DName) VALUES (11, 8, 'Khao Soi')
INTO Can_Cook(EID, MID, DName) VALUES (11, 9, 'Thai Mojito')
SELECT *
    FROM dual;

INSERT ALL
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (1, 26.38, DATE '2023-08-11', 4, 'johnny@hotmail.com', 1 , 3)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (2, 13.19, DATE '2021-02-11', 8, 'peter@gmail.com', 1 , 3)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (3, 14.25, DATE '2018-09-03', 8, 'jennifer@gmail.com', 3 , 3)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (4, 13.19, DATE '2019-11-21', 7, 'delpiero@gmail.com', 2 , 4)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (5, 13.19, DATE '2021-02-11', 7, 'casaraghi@gmail.com', 3 , 5)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (6, 22.00, DATE '2021-07-03', 6, 'bierhoff@gmail.com', 3 , 6)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (7, 13.00, DATE '2022-12-21', 4, 'oliver@gmail.com', 2 , 7)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (8, 14.25, DATE '2020-07-03', 6, 'donald@gmail.com', 4 , 8)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (9, 18.00, DATE '2020-12-21', 9, 'amy@gmail.com', 4 , 9)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (10, 18.00, DATE '2020-12-21', 9, 'schevechenko@gmail.com', 3 , 10)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (11, 14.25, DATE '2019-03-24', 7, 'hernan@gmail.com', 5 , 11)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (12, 18.00, DATE '2018-04-08', 6, 'hernan@gmail.com', 3 , 12)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (13, 22.00, DATE '2021-11-16', 3, 'gabriel@gmail.com', 3 , 13)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (14, 40.00, DATE '2022-11-13', 6, 'gabriel@gmail.com', 3 , 14)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (15, 13.19, DATE '2023-10-01', 9, 'riken@gmail.com', 1 , 15)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (16, 49.00, DATE '2023-06-17', 7, 'moller@gmail.com', 3 , 16)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (17, 22.00, DATE '2018-03-13', 5, 'moller@gmail.com', 3 , 17)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (18, 14.25, DATE '2023-03-13', 7, 'moller@gmail.com', 3 , 17)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (19, 22.00, DATE '2023-03-13', 7, 'gabriel@gmail.com', 3 , 17)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (20, 49.00, DATE '2020-02-23', 7, 'gomez@gmail.com', 3 , 19)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES(21, 49.00, DATE '2022-07-10', 8, 'jurgen@gmail.com', 3 , 20)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (22, 14.25, DATE '2023-06-17', 7, 'gomez@gmail.com', 5 , 11)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (23, 13.19, DATE '2023-06-17', 8, 'jurgen@gmail.com', 5 , 11)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (24, 13.19, DATE '2023-06-17', 7, 'bierhoff@gmail.com', 5 , 11)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (25, 8.00, DATE '2023-07-26', 5, 'jurgen@gmail.com', 3 , 12)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (26, 8.00, DATE '2023-07-26', 5, 'gomez@gmail.com', 3 , 12)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID)
    VALUES (27, 8.00, DATE '2023-07-27', 6, 'bierhoff@gmail.com', 3 , 12)
INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
    VALUES (28, 13.19, DATE '2023-08-12', 7, 'johnny@hotmail.com', 1 , 3)
SELECT *
    FROM dual;

INSERT ALL 
INTO Included(OID, MID, DName) VALUES (1, 1, 'Chicken Pesto Sandwich')
INTO Included(OID, MID, DName) VALUES (1, 1, 'Prosciutto Sandwich')
INTO Included(OID, MID, DName) VALUES (2, 1, 'Prosciutto Sandwich')
INTO Included(OID, MID, DName) VALUES (3, 3, 'Eggs and Toast')
INTO Included(OID, MID, DName) VALUES (4, 2, 'Bolognese')
INTO Included(OID, MID, DName) VALUES (5, 2, 'Bolognese')
INTO Included(OID, MID, DName) VALUES (6, 8, 'Khao Soi')
INTO Included(OID, MID, DName) VALUES (7, 9, 'Thai Mojito')
INTO Included(OID, MID, DName) VALUES (8, 3, 'Eggs and Toast')
INTO Included(OID, MID, DName) VALUES (9, 7, 'Cumin Coconut Mussles')
INTO Included(OID, MID, DName) VALUES (10, 7, 'Cumin Coconut Mussles')
INTO Included(OID, MID, DName) VALUES (11, 3, 'Eggs and Toast')
INTO Included(OID, MID, DName) VALUES (12, 7, 'Cumin Coconut Mussles')
INTO Included(OID, MID, DName) VALUES (13, 8, 'Khao Soi')
INTO Included(OID, MID, DName) VALUES (14, 4, 'Beef Tartare')
INTO Included(OID, MID, DName) VALUES (15, 1, 'Prosciutto Sandwich')
INTO Included(OID, MID, DName) VALUES (16, 6, '9 Course Tasting')
INTO Included(OID, MID, DName) VALUES (17, 8, 'Khao Soi')
INTO Included(OID, MID, DName) VALUES (18, 3, 'Eggs and Toast')
INTO Included(OID, MID, DName) VALUES (19, 8, 'Khao Soi')
INTO Included(OID, MID, DName) VALUES (20, 6, '9 Course Tasting')
INTO Included(OID, MID, DName) VALUES (21, 6, '9 Course Tasting')
INTO Included(OID, MID, DName) VALUES (22, 3, 'Eggs and Toast')
INTO Included(OID, MID, DName) VALUES (23, 1, 'Chicken Pesto Sandwich')
INTO Included(OID, MID, DName) VALUES (24, 1, 'Chicken Pesto Sandwich')
INTO Included(OID, MID, DName) VALUES (25, 5, 'House Pinot Noir (6 oz)')
INTO Included(OID, MID, DName) VALUES (26, 5, 'House Pinot Noir (6 oz)')
INTO Included(OID, MID, DName) VALUES (27, 5, 'House Pinot Noir (6 oz)')
INTO Included(OID, MID, DName) VALUES (28, 2, 'Bolognese')
SELECT *
    FROM dual;