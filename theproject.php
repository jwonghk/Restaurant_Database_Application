<!--Test Oracle file for UBC CPSC304 2018 Winter Term 1
  Created by Jiemin Zhang
  Modified by Simona Radu
  Modified by Jessica Wong (2018-06-22)
  This file shows the very basics of how to execute PHP commands
  on Oracle.
  Specifically, it will drop a table, create a table, insert values
  update values, and then query for values

  IF YOU HAVE A TABLE CALLED "demoTable" IT WILL BE DESTROYED

  The script assumes you already have a server set up
  All OCI commands are commands to the Oracle libraries
  To get the file to work, you must place it somewhere where your
  Apache server can run it, and you must rename it to have a ".php"
  extension.  You must also change the username and password on the
  OCILogon below to be your ORACLE username and password -->

<html>
    <head>
        <title>Restaurants Manager</title>
    </head>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Restaurants Manager</title>
    </head>
    <body>
        <h1 style="text-align: center;">Restaurants Manager</h1>

        <hr style="height:8px;background-color:black">
    </body>

    <body>
        <h2>Reset Database</h2>
        <p>Reset to restore the default tables for the Restaurants Manager. If this is the first time running this page, you MUST use reset.</p>

        <form method="POST" action="theproject.php">
            <!-- if you want another page to load after the button is clicked, you have to specify that page in the action parameter -->
            <input type="hidden" id="resetTablesRequest" name="resetTablesRequest">
            <p><input type="submit" value="Reset" name="reset"></p>
        </form>

        <hr />

        <h2>Add a New Cook</h2>
        <p>Enter the details for the cook to be added.</p>
        <form method="POST" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="insertQueryRequest" name="insertQueryRequest">
            Employee ID: <input type="number" name="EID" required> <br /><br />
            Name: <input type="text" name="EName" required> <br /><br />
            <label for="HourlyWage">Hourly Wage:</label>
            <input type="number" name="HourlyWage" step="0.01" required><br><br>
            <label for="HoursPerWeek">Hours Per Week:</label>
            <input type="number" name="HoursPerWeek" step="0.01" required><br><br>
            <label for="FulltimeStatus">Fulltime Status:</label>
            <select name="FulltimeStatus" required>
                <option value="">Select Option</option>
                <option value="1">Yes</option>
                <option value="0">No</option>
            </select><br><br>
            <label for="Rank">Cook Rank:</label>
            <select name="Rank" required>
                <option value="">Select Rank</option>
                <option value="Head Chef">Head Chef</option>
                <option value="Line Cook">Line Cook</option>
                <option value="Sous Chef">Sous Chef</option>
                <option value="Junior Chef">Junior Chef</option>
                <option value="Kitchen Porter">Kitchen Porter</option>
            </select><br><br>

            <input type="submit" value="Insert" name="insertSubmit"></p>
        </form>

        <hr />

        <h2>Remove an Employee</h2>
        <p>Remove an employee by Employee ID. This will also remove the tuple from the employee type.</p>
        <p>Leaving the box blank will delete a random employee.</p>

        <form method="POST" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="deleteQueryRequest" name="deleteQueryRequest">
            Employee ID: <input type="number" name="EID"> <br /><br />

            <input type="submit" value="Delete" name="deleteSubmit" class="button"></p>
        </form>

        <hr />

        <h2>Update an Employee's Details</h2>
        <p>Enter the ID of the employee to update.</p>

        <form method="POST" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
            Employee ID: <input type = "number" name = "EID" required> <br /> <br />

            <input type="submit" value="Update" name="updateSubmit"></p>
        </form>

        <hr />

        <h2>Select From a Chosen Table</h2>
        <p>Choose a table, and enter attributes to select from and any conditions.</p>
        <p>Leaving ''Select:'' blank will display all attributes for the chosen table.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="selectionRequest" name="selectionRequest">
            Select: <input type="text" name="selectParam" size="23" placeholder="Type appropriate attributes"> <br /><br />
            From: <select name="fromParam" required>
                <option value="">Select Table</option>
                <option value="Restaurants_Main">Restaurants Main</option>
                <option value="Restaurants_Name">Restaurants Name</option>
                <option value="Menus_Offered">Menus Offered</option>
                <option value="Suppliers">Suppliers</option>
                <option value="Ingredients">Ingredients</option>
                <option value="Supplied">Supplied</option>
                <option value="Dishes_Had">Dishes Had</option>
                <option value="Contained">Contained</option>
                <option value="Customers">Customers</option>
                <option value="Employees_Main">Employees Main</option>
                <option value="Employees_FT">Employees FT</option>
                <option value="Servers">Servers</option>
                <option value="Cooks">Cooks</option>
                <option value="Managers_Managed">Managers Managed</option>
                <option value="Employed">Employed</option>
                <option value="Can_Cook">Can Cook</option>
                <option value="Orders_Placed_Served_Taken">Orders Placed Served Taken</option>
                <option value="Included">Included</option>
            </select><br><br>
            Where: <input type="text" name="whereParam" size="23" placeholder="Leave blank for no condition"> <br /><br />

            <input type="submit" value="Select" name="selectSubmit" class="button"></p>
        </form>

        <hr />

        <h2>Find Restaurants That Have A Low Average Wage</h2>
        <p>Get a list of restaurants that have a lower employee average wage than the average wage of all employees in the database.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="nestedAggRequest" name="nestedAggRequest">

            <input type="submit" value="Submit" name="nestedAggTable"></p>
        </form>

        <hr />

        <h2>Find Suppliers That Supply Every Ingredient</h2>
        <p>Get a list of suppliers that supply all known ingredients in the database.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="divisionRequest" name="divisionRequest">

            <input type="submit" value="Submit" name="divisionTable"></p>
        </form>

        <hr />

        <h2>Count the Tuples in Restaurants Manager's Tables</h2>
        <p>Get the number of rows in each instance in the database.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="countTupleRequest" name="countTupleRequest">

            <input type="submit" value="Count" name="countTuples"></p>
        </form>

        <hr />

        <h2>Count Employees at Each Restaurant </h2>
        <p>Count the number of employees employed at each restaurant.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="countEmployeesRequest" name="countEmployeesRequest">

            <input type="submit" value="Count" name="countEmployees"></p>
        </form>

        <hr />

        <h2>Find Frequent Customers </h2>
        <p>Find emails of customers that have placed at least some number of orders.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
        <input type="hidden" id="findFrequentCustomersRequest" name="findFrequentCustomersRequest">
            <label for="OrderCount">Order Count:</label>
            <input type="number" name="minOrders" step="1" required><br><br>

            <input type="submit" value="Find" name="findFrequentCustomers"></p>
        </form>

        <hr />

        <h2>View all Tuples in Selected Table</h2>
        <p>Choose from a table in the database to view its rows.</p>
        <form method="GET" action="theproject.php"> <!--refresh page when submitted-->
            <input type="hidden" id="viewTupleRequest" name="viewTupleRequest">
            <select name="Table" required>
                <option value="">Select Table</option>
                <option value="Restaurants_Main">Restaurants Main</option>
                <option value="Restaurants_Name">Restaurants Name</option>
                <option value="Menus_Offered">Menus Offered</option>
                <option value="Suppliers">Suppliers</option>
                <option value="Ingredients">Ingredients</option>
                <option value="Supplied">Supplied</option>
                <option value="Dishes_Had">Dishes Had</option>
                <option value="Contained">Contained</option>
                <option value="Customers">Customers</option>
                <option value="Employees_Main">Employees Main</option>
                <option value="Employees_FT">Employees FT</option>
                <option value="Servers">Servers</option>
                <option value="Cooks">Cooks</option>
                <option value="Managers_Managed">Managers Managed</option>
                <option value="Employed">Employed</option>
                <option value="Can_Cook">Can Cook</option>
                <option value="Orders_Placed_Served_Taken">Orders Placed Served Taken</option>
                <option value="Included">Included</option>
            </select><br><br>

            <input type="submit" value="View" name="viewTuples"></p>
        </form>

        <hr style="height:8px;background-color:black">
        <?php
		//this tells the system that it's no longer just parsing html; it's now parsing PHP

        $success = True; //keep track of errors so it redirects the page only if there are no errors
        $db_conn = NULL; // edit the login credentials in connectToDB()
        $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

        function debugAlertMessage($message) {
            global $show_debug_alert_messages;

            if ($show_debug_alert_messages) {
                echo "<script type='text/javascript'>alert('" . $message . "');</script>";
            }
        }

        function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
            //echo "<br>running ".$cmdstr."<br>";
            global $db_conn, $success;

            $statement = OCIParse($db_conn, $cmdstr);
            //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
                echo htmlentities($e['message']);
                $success = False;
            }

            $r = OCIExecute($statement, OCI_DEFAULT);
            if (!$r) {
                echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
                echo htmlentities($e['message']);
                $success = False;
            }

			return $statement;
		}

        function executeBoundSQL($cmdstr, $list) {
            /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
		See the sample code below for how this function is used */

			global $db_conn, $success;
			$statement = OCIParse($db_conn, $cmdstr);

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn);
                echo htmlentities($e['message']);
                $success = False;
            }

            foreach ($list as $tuple) {
                foreach ($tuple as $bind => $val) {
                    //echo $val;
                    //echo "<br>".$bind."<br>";
                    OCIBindByName($statement, $bind, $val);
                    unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
				}

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                    echo htmlentities($e['message']);
                    echo "<br>";
                    $success = False;
                }
            }
        }

        function connectToDB() {
            global $db_conn;

            // Your username is ora_(CWL_ID) and the password is a(student number). For example,
			// ora_platypus is the username and a12345678 is the password.
            $db_conn = OCILogon("ora_kynguyen", "a76276393", "dbhost.students.cs.ubc.ca:1522/stu");

            if ($db_conn) {
                debugAlertMessage("Database is Connected");
                return true;
            } else {
                debugAlertMessage("Cannot connect to Database");
                $e = OCI_Error(); // For OCILogon errors pass no handle
                echo htmlentities($e['message']);
                return false;
            }
        }

        function disconnectFromDB() {
            global $db_conn;

            debugAlertMessage("Disconnect from Database");
            OCILogoff($db_conn);
        }

        function handleResetRequest() {
            global $db_conn;
            // Reset tables with sample data
            echo "<br> Resetting tables with the default sample data. <br>";
            executePlainSQL("DROP TABLE Restaurants_Main CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Restaurants_Name CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Menus_Offered CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Suppliers CASCADE CONSTRAINTS");
            executePlainSQL("DROP Table Ingredients CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Supplied CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Dishes_Had CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Contained CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Customers CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Employees_Main CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Employees_FT CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Servers CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Cooks CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Managers_Managed CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Employed CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Can_Cook CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Orders_Placed_Served_Taken CASCADE CONSTRAINTS");
            executePlainSQL("DROP TABLE Included CASCADE CONSTRAINTS");

            executePlainSQL("CREATE TABLE Restaurants_Main(
                RID INTEGER PRIMARY KEY,
                RName CHAR(32),
                Branch CHAR(32),
                RLocation CHAR(32),
                UNIQUE(RName, Branch, RLocation)
                )"
            );

            executePlainSQL("CREATE TABLE Restaurants_Name(
                Cuisine CHAR(32),
                RName CHAR(32) PRIMARY KEY
                )"
            );

            executePlainSQL("CREATE TABLE Menus_Offered(
                MID INTEGER PRIMARY KEY,
                MType CHAR(32),
                RID INTEGER NOT NULL,
                FOREIGN KEY (RID) REFERENCES Restaurants_Main (RID)
                    ON DELETE CASCADE   
                )"
            );

            executePlainSQL("CREATE TABLE Suppliers(
                SID INTEGER PRIMARY KEY,
                SName CHAR(32),
                SLocation CHAR(32),
                UNIQUE(SName, SLocation)
                )"
            );

            executePlainSQL("CREATE TABLE Ingredients(
                IName CHAR(32) PRIMARY KEY,
                IType CHAR(32)
                )"
            );

            executePlainSQL("CREATE TABLE Supplied(
                IName CHAR(32),
                SID INTEGER,
                Cost REAL,
                PRIMARY KEY (IName, SID),
                FOREIGN KEY (IName) REFERENCES Ingredients(IName)
                    ON DELETE CASCADE,
                FOREIGN KEY (SID) REFERENCES Suppliers(SID) 
                    ON DELETE CASCADE 
                )"
            );

            executePlainSQL("CREATE TABLE Dishes_Had(
                MID INTEGER,
                DName CHAR(32),
                DType CHAR(32),
                Price REAL,
                DateIntroduced DATE,
                PRIMARY KEY (MID, DName),
                FOREIGN KEY (MID) REFERENCES Menus_Offered(MID) 
                    ON DELETE CASCADE 
                )"
            );

            executePlainSQL("CREATE TABLE Contained(
                MID INTEGER,
                DName CHAR(32),
                IName CHAR(32),
                Quantity CHAR(32),
                PRIMARY KEY (MID, DName, IName),
                FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
                    ON DELETE CASCADE, 
                FOREIGN KEY (IName) REFERENCES Ingredients(IName) 
                    ON DELETE CASCADE
                )"
            );

            executePlainSQL("CREATE TABLE Customers(
                CEmail CHAR(32) PRIMARY KEY,
                PhoneNo CHAR(16),
                CName CHAR(32),
                UNIQUE (CName, PhoneNo)
                )"
            );

            executePlainSQL("CREATE TABLE Employees_Main(
                EID INTEGER PRIMARY KEY,
                EName CHAR(32),
                HourlyWage REAL,
                HoursPerWeek REAL
                )"
            );

            executePlainSQL("CREATE TABLE Employees_FT(
                HoursPerWeek REAL PRIMARY KEY,
                FulltimeStatus Number(1,0) 
                )"
            );

            executePlainSQL("CREATE TABLE Servers(
                EID INTEGER PRIMARY KEY,
                AlcoholServingCertification Number(1,0),
                FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
                    ON DELETE CASCADE 
                )"
            );

            executePlainSQL("CREATE TABLE Cooks(
                EID INTEGER PRIMARY KEY,
                Rank CHAR(32),
                FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
                    ON DELETE CASCADE 
                )"
            );

            executePlainSQL("CREATE TABLE Managers_Managed(
                EID INTEGER PRIMARY KEY,
                RID INTEGER NOT NULL UNIQUE,
                FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
                    ON DELETE CASCADE, 
                FOREIGN KEY (RID) REFERENCES Restaurants_Main(RID) 
                )"
            );

            executePlainSQL("CREATE TABLE Employed(
                EID INTEGER,
                RID INTEGER,
                DateEmployed DATE,
                PRIMARY KEY (EID, RID),
                FOREIGN KEY (EID) REFERENCES Employees_Main(EID) 
                    ON DELETE CASCADE, 
                FOREIGN KEY (RID) REFERENCES Restaurants_Main(RID) 
                    ON DELETE CASCADE
                )"
            );

            executePlainSQL("CREATE TABLE Can_Cook(
                EID INTEGER,
                MID INTEGER,
                DName CHAR(32),
                PRIMARY KEY (EID, MID, DName),
                FOREIGN KEY (EID) REFERENCES Cooks(EID) 
                    ON DELETE CASCADE, 
                FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
                    ON DELETE CASCADE 
                )"
            );

            executePlainSQL("CREATE TABLE Orders_Placed_Served_Taken(
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
                )"
            );

            executePlainSQL("CREATE TABLE Included(
                OID INTEGER,
                MID INTEGER,
                DName CHAR(32),
                PRIMARY KEY (OID, MID, DName),
                FOREIGN KEY (OID) REFERENCES Orders_Placed_Served_Taken(OID) 
                    ON DELETE CASCADE, 
                FOREIGN KEY (MID, DName) REFERENCES Dishes_Had(MID, DName) 
                    ON DELETE CASCADE
                )"
            );

            executePlainSQL("INSERT ALL 
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (1, 'Jo''s Italian Deli', 'West Point Grey', 'Vancouver, BC, CA')
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (2, 'Nelly''s Brunch Pantry', 'Kitsilano', 'Vancouver, BC, CA')
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (3, 'Les Amis', 'Kitsilano', 'Montreal, QC, CA')
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (4, 'Banana Leaf', 'Kitsilano', 'Vancouver, BC, CA')
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (5, 'Banana Leaf', 'Fairview', 'Vancouver, BC, CA')
                INTO Restaurants_Main(RID, RName, Branch, RLocation) VALUES (6, 'PAI', 'Downtown', 'Toronto, ON, CA')
                SELECT *
                  FROM dual"
            );

            executePlainSQL("INSERT ALL 
                INTO Restaurants_Name(Cuisine, RName) VALUES ('Italian', 'Jo''s Italian Deli')
                INTO Restaurants_Name(Cuisine, RName) VALUES ('Brunch', 'Nelly''s Brunch Pantry')
                INTO Restaurants_Name(Cuisine, RName) VALUES ('French', 'Les Amis')
                INTO Restaurants_Name(Cuisine, RName) VALUES ('Malaysian', 'Banana Leaf')
                INTO Restaurants_Name(Cuisine, RName) VALUES ('Thai', 'PAI')
                SELECT *
                  FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                  FROM dual"
            );

            executePlainSQL("INSERT ALL
                INTO Suppliers(SID, SName, SLocation) VALUES (1, 'Costco Business Centre', 'Vancouver, BC, CA')
                INTO Suppliers(SID, SName, SLocation) VALUES (2, 'Costco Business Centre', 'Montreal, QC, CA')
                INTO Suppliers(SID, SName, SLocation) VALUES (3, 'Costco Business Centre', 'Toronto, ON, CA')
                INTO Suppliers(SID, SName, SLocation) VALUES (4, 'Local Farm', 'Delta, BC, CA')
                INTO Suppliers(SID, SName, SLocation) VALUES (5, 'Italian Import Specialist', 'Vancouver, BC, CA')
                SELECT *
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (37.5, 1)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (40, 1)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (50, 1)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (35, 1)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (5, 0)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (10, 0)
                INTO Employees_FT(HoursPerWeek, FulltimeStatus) VALUES (20, 1)
                SELECT *
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
                INTO Cooks(EID, Rank) VALUES (2, 'Head Chef')
                INTO Cooks(EID, Rank) VALUES (4, 'Head Chef')
                INTO Cooks(EID, Rank) VALUES (5, 'Line Cook')
                INTO Cooks(EID, Rank) VALUES (8, 'Sous Chef')
                INTO Cooks(EID, Rank) VALUES (11, 'Head Chef')
                SELECT *
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
                INTO Managers_Managed(EID, RID) VALUES (1, 3)
                INTO Managers_Managed(EID, RID) VALUES (7, 2)
                INTO Managers_Managed(EID, RID) VALUES (9, 4)
                INTO Managers_Managed(EID, RID) VALUES (15, 1)
                INTO Managers_Managed(EID, RID) VALUES (18, 5)
                SELECT *
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );

            executePlainSQL("INSERT ALL
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (1, 26.38, DATE '2023-08-11', 4, 'johnny@hotmail.com', 1 ,3)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (2, 13.19, DATE '2021-02-11', 8, 'peter@gmail.com', 1 ,2)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (3, 14.25, DATE '2018-09-03', 8, 'jennifer@gmail.com', 3 ,3)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (4, 13.19, DATE '2019-11-21', 7, 'delpiero@gmail.com', 2 ,4)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (5, 13.19, DATE '2021-02-11', 7, 'casaraghi@gmail.com', 3 ,5)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (6, 22.00, DATE '2021-07-03', 6, 'bierhoff@gmail.com', 3 ,6)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (7, 13.00, DATE '2022-12-21', 4, 'oliver@gmail.com', 2 ,7)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (8, 14.25, DATE '2020-07-03', 6, 'donald@gmail.com', 4 ,8)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (9, 18.00, DATE '2020-12-21', 9, 'amy@gmail.com', 4 ,9)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (10, 18.00, DATE '2020-12-21', 9, 'schevechenko@gmail.com', 3 ,10)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (11, 14.25, DATE '2019-03-24', 7, 'hernan@gmail.com', 5 ,11)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (12, 18.00, DATE '2018-04-08', 6, 'hernan@gmail.com', 3 ,12)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (13, 22.00, DATE '2021-11-16', 3, 'gabriel@gmail.com', 3 ,13)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (14, 40.00, DATE '2022-11-13', 6, 'gabriel@gmail.com', 3 ,14)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (15, 13.19, DATE '2023-10-01', 9, 'riken@gmail.com', 1 ,15)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (16, 49.00, DATE '2023-06-17', 7, 'moller@gmail.com', 3 ,16)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (17, 22.00, DATE '2018-03-13', 5, 'moller@gmail.com', 3 ,17)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (18, 14.25, DATE '2023-03-13', 7, 'moller@gmail.com', 3 ,17)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (19, 22.00, DATE '2023-03-13', 7, 'gabriel@gmail.com', 3 ,17)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (20, 49.00, DATE '2020-02-23', 7, 'gomez@gmail.com', 3 ,19)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES(21, 49.00, DATE '2022-07-10', 8, 'jurgen@gmail.com', 3 ,20)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (22, 14.25, DATE '2023-06-17', 7, 'gomez@gmail.com', 5 ,11)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (23, 13.19, DATE '2023-06-17', 8, 'jurgen@gmail.com', 5 ,11)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (24, 13.19, DATE '2023-06-17', 7, 'bierhoff@gmail.com', 5 ,11)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (25, 8.00, DATE '2023-07-26', 5, 'jurgen@gmail.com', 3 ,12)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (26, 8.00, DATE '2023-07-26', 5, 'gomez@gmail.com', 3 ,12)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID)
                    VALUES (27, 8.00, DATE '2023-07-27', 6, 'bierhoff@gmail.com', 3 ,12)
                INTO Orders_Placed_Served_Taken(OID, TotalPrice, Dates, SatisfactionRating, CEmail, RID, EID) 
                    VALUES (28, 13.19, DATE '2023-08-12', 7, 'johnny@hotmail.com', 1 ,3)
                SELECT *
                    FROM dual"
            );

            executePlainSQL("INSERT ALL 
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
                    FROM dual"
            );
            
            OCICommit($db_conn);
        }

        function handleInsertRequest() {
            global $db_conn;

            $EID = $_POST["EID"];
            $EName = $_POST["EName"];
            $HourlyWage = $_POST["HourlyWage"];
            $HoursPerWeek = $_POST["HoursPerWeek"];
            $FulltimeStatus = $_POST["FulltimeStatus"];
            $Rank = $_POST["Rank"];

            // Check if EID already exists in Employees_Main
            $checkResult = executePlainSQL("SELECT COUNT(*) AS COUNT FROM Employees_Main WHERE EID = " . $EID . "");
            if (($row = oci_fetch_row($checkResult)) != false) {
                if ($row[0] > 0) {
                    // EID already exists, stop insertion and show an error message
                    echo "Error: Employee ID already exists in Employees_Main. Please use a different ID.";
                    return;
                }
            }
            
            // Insert the new employee tuple into Employees_Main, if it doesn't exist already
            $employeeTuple = array(
                ":bind1" => $EID,
                ":bind2" => $EName,
                ":bind3" => $HourlyWage,
                ":bind4" => $HoursPerWeek
            );

            $allEmployeeTuples = array(
                $employeeTuple
            );

            executeBoundSQL("INSERT INTO Employees_Main VALUES (:bind1, :bind2, :bind3, :bind4)", $allEmployeeTuples);

            OCICommit($db_conn);
            echo "New employee ID registered in Employees_Main.";
            echo "</br>";

            // Check if HoursPerWeek already exists in Employees_FT
            $checkResult = executePlainSQL("SELECT COUNT(*) AS COUNT FROM Employees_FT WHERE HoursPerWeek = " . $HoursPerWeek . "");
            if (($row = oci_fetch_row($checkResult)) != false) {
                if ($row[0] > 0) {
                    // EID already exists, stop insertion and show an error message
                    echo "Fulltime hours already exists in Employees_FT.";
                    echo "</br>";
                } else {
                    // Insert the new employee hours and fulltime status tuple into Employees_FT, if it doesn't exist already
                    $employeeFTTuple = array(
                        ":bind1" => $HoursPerWeek,
                        ":bind2" => $FulltimeStatus
                    );

                    $allEmployeeFTTuples = array(
                        $employeeFTTuple
                    );

                    executeBoundSQL("INSERT INTO Employees_FT VALUES (:bind1, :bind2)", $allEmployeeFTTuples);
                    OCICommit($db_conn);
                    echo "New fulltime hours saved in Employees_FT.";
                    echo "</br>";
                }
            }

            // Insert the cook tuple into Cooks
            $cookTuple = array(
                ":bind1" => $EID,
                ":bind2" => $Rank
            );

            $allCookTuples = array(
                $cookTuple
            );

            executeBoundSQL("INSERT INTO Cooks VALUES (:bind1, :bind2)", $allCookTuples);
            OCICommit($db_conn);
            echo "Employee ID successfully added to Cooks.";
            echo "</br>";
            echo "</br>";
            echo "Employee ID: " . $EID . "";
            echo "</br>";
            echo "Name: " . $EName . "";
            echo "</br>";
            echo "Hourly Wage: " . $HourlyWage . ""; 
            echo "</br>";
            echo "Hours Per Week: " . $HoursPerWeek . "";
            echo "</br>";
            echo "FulltimeStatus: " . $FulltimeStatus . "";
            echo "</br>";
            echo "Rank: " . $Rank . "";
        }

        function handleDeleteRequest() {
            global $db_conn;

            $EID = $_POST['EID'];


            $EID = $_POST['EID'];

            // Check if EID is empty
            if (empty($EID)) {
                // Get a random Employee ID from the Employees_Main table
                $randomResult = executePlainSQL("SELECT EID FROM Employees_Main ORDER BY DBMS_RANDOM.RANDOM");
                $randomEmployee = oci_fetch_row($randomResult);
                if ($randomEmployee) {
                    $EID = $randomEmployee[0];
                } else {
                    echo "Error: No employees found in the database.";
                    return;
                }
            } else {
                // Check if EID doesn't exist in Employees_Main
                $checkResult = executePlainSQL("SELECT COUNT(*) AS COUNT FROM Employees_Main WHERE EID = " . $EID);
                if (($row = oci_fetch_row($checkResult)) != false) {
                    if ($row[0] <= 0) {
                        // EID doesn't exist
                        echo "Error: Employee ID: " . $EID . " does not exist.";
                        return;
                    }
                }
            }
        
            $result = executePlainSQL("SELECT EName FROM Employees_Main WHERE EID = " . $EID);
            $name = oci_fetch_row($result);
            executePlainSQL("DELETE FROM Employees_Main WHERE EID = " . $EID);
            OCICommit($db_conn);
            echo "Removed employee " . $name[0] . " with Employee ID: " . $EID . ".";
        }

        function handleUpdateRequest() {
            global $db_conn;

            $EID = $_POST['EID'];
            echo "Updating Employee ID: " . $EID . "";
            echo "</br>";
            echo '<form method="POST" action="">';

            $result = executePlainSQL("SELECT * FROM Employees_Main WHERE EID = '" . $EID . "'");
            echo '<table>';
            
            echo '<tr>';
                echo "<th> Employee ID </th>";
                echo "<th> Name </th>";
                echo "<th> Hourly Wage </th>";
                echo "<th> Hours Per Week </th>";
            echo '</tr>';

            echo "<tr>";
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo '<td>';
                        echo '<input type = "number" name = "EID" value = "' . $row[0] . '" readonly>';
                    echo '</td>';
                    echo '<td>';
                        echo '<input type = "text" name = "EName" value = "' . trim($row[1]) . '" required>';
                    echo '</td>';
                    echo '<td>';
                        echo '<input type = "number" name = "HourlyWage" step = "0.01" value = "' . $row[2] . '" required>';
                    echo '</td>';
                    echo '<td>';
                        echo '<input type = "number" name = "HoursPerWeek" step = "0.01" value = "' . $row[3] . '" required>';
                    echo '</td>';
                }
            echo "</tr>";

            echo "</table>";

            echo '<input type="hidden" id="updateQueryHelper" name="updateQueryHelper">';
            echo '<input type="submit" value="Update Employee" name="updateHelperSubmit"></p>';
            echo "</form>";
        }

        function handleUpdateHelper() {
            global $db_conn;

            $EID = $_POST["EID"];
            $EName = $_POST["EName"];
            $HourlyWage = $_POST["HourlyWage"];
            $HoursPerWeek = $_POST["HoursPerWeek"];

            $employeeTuple = array(
                ":bind1" => $EID,
                ":bind2" => $EName,
                ":bind3" => $HourlyWage,
                ":bind4" => $HoursPerWeek
            );

            $allEmployeeTuples = array(
                $employeeTuple
            );

            executeBoundSQL("UPDATE Employees_Main SET EName=:bind2, HourlyWage=:bind3, HoursPerWeek=:bind4 
            WHERE EID=:bind1", $allEmployeeTuples);
            OCICommit($db_conn);

            echo "Employee ID: " . $EID . " successfully updated.";
            echo "</br>";
            echo "</br>";
            echo "Name: " . $EName . "";
            echo "</br>";
            echo "Hourly Wage: " . $HourlyWage . ""; 
            echo "</br>";
            echo "Hours Per Week: " . $HoursPerWeek . "";
            echo "</br>";
        }

        function handleSelectionRequest() {
            global $db_conn;

            $selectParam = $_GET['selectParam'];
            $fromParam = $_GET['fromParam'];
            $whereParam = $_GET['whereParam'];

            if (!empty($selectParam)) {
                if (!empty($whereParam)) {
                    $result = executePlainSQL("SELECT " . $selectParam . " FROM " . $fromParam . " WHERE " . $whereParam);
                } else {
                    $result = executePlainSQL("SELECT " . $selectParam . " FROM " . $fromParam . "");
                }
            } else {
                if (!empty($whereParam)) {
                    $result = executePlainSQL("SELECT * FROM " . $fromParam . " WHERE " . $whereParam);
                } else {
                    $result = executePlainSQL("SELECT * FROM " . $fromParam . "");
                }
            }
            
            printResult($result);
        }

        function handleNestedAggRequest() {
            global $db_conn;

            $result = executePlainSQL(" SELECT R.RID, R.RName, R.Branch, R.RLocation, (
                                                SELECT AVG(E2.HourlyWage) 
                                                FROM Employees_Main E2
                                                WHERE E2.EID IN (
                                                    SELECT EID
                                                    FROM Employed E3
                                                    WHERE E3.RID = R.RID)) 
                                                AS AvgHourlyWageRestaurant
                                        FROM Restaurants_Main R
                                        GROUP BY R.RID, R.RName, R.Branch, R.RLocation
                                        HAVING (
                                                SELECT AVG(E2.HourlyWage)
                                                FROM Employees_Main E2
                                                WHERE E2.EID IN (
                                                    SELECT EID
                                                    FROM Employed E3
                                                    WHERE E3.RID = R.RID
                                                )
                                            ) < (
                                                SELECT AVG(HourlyWage)
                                                FROM Employees_Main
                                                )
            ");
            printResult($result);
        }

        function handleDivisionRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT S.SID, S.SName
                                        FROM Suppliers S
                                        WHERE NOT EXISTS (
                                            SELECT I.IName
                                            FROM Ingredients I
                                            WHERE NOT EXISTS (
                                                SELECT SP.SID
                                                FROM Supplied SP
                                                WHERE SP.SID = S.SID
                                                AND SP.IName = I.IName
                                            )
                                        )"
            );
            printResult($result);
        }

        function handleCountRequest() {
            global $db_conn;
            $table_names = executePlainSQL("SELECT table_name FROM user_tables");

            while (($name = oci_fetch_row($table_names)) != false) {
                $count = oci_fetch_row(executePlainSQL("SELECT Count(*) FROM $name[0]"));
                echo "Number of tuples in " . $name[0] . ": " . $count[0] . "";
                echo "</br>";
            }
        }

        function handleCountEmployeesRequest() {
            global $db_conn;
            $result = executePlainSQL("SELECT RName, Branch, RLocation, Count(*) AS EmployeeCount
                                            FROM Restaurants_Main r, Employed e
                                            WHERE r.RID = e.RID
                                            GROUP BY RName, Branch, RLocation");
            echo "Employee count at each restaurant:";
            printResult($result);
        }

        function handleFindFrequentCustomersRequest() {
            global $db_conn;
            $minOrders = $_GET["minOrders"];
            $result = executePlainSQL("SELECT CEMail, Count(*) AS OrderCount
                                        FROM Orders_Placed_Served_Taken
                                        GROUP BY CEmail
                                        HAVING COUNT(*) >= " . $minOrders);
            echo "Emails of customers that have placed at least " . $minOrders . " orders:";
            printResult($result);
        }

        function handleViewRequest() {
            global $db_conn;
            $Table = $_GET["Table"];
            $result = executePlainSQL("SELECT * FROM $Table");
            printResult($result);
        }

        function printResult($result) {
            if (oci_fetch_all($result, $rows, null, null, OCI_FETCHSTATEMENT_BY_ROW)) {
                $columnNames = array_keys($rows[0]);
        
                echo "<table border='2'>";
                echo "<tr>";
                foreach ($columnNames as $columnName) {
                    echo "<th>$columnName</th>";
                }
                echo "</tr>";
        
                // Print table rows
                foreach ($rows as $row) {
                    echo "<tr>";
                    foreach ($row as $value) {
                        echo "<td>$value</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "</br>";
                echo "</br>";
                echo "No data found.";
            }
        }

        // HANDLE ALL POST ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handlePOSTRequest() {
            if (connectToDB()) {
                if (array_key_exists('resetTablesRequest', $_POST)) {
                    handleResetRequest();
                } else if (array_key_exists('insertQueryRequest', $_POST)) {
                    handleInsertRequest();
                } else if (array_key_exists('deleteQueryRequest', $_POST)) {
                    handleDeleteRequest();
                } else if (array_key_exists('updateQueryRequest', $_POST)) {
                    handleUpdateRequest();
                } else if (array_key_exists('updateQueryHelper', $_POST)) {
                    handleUpdateHelper();
                }
                disconnectFromDB();
            }
        }

        // HANDLE ALL GET ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handleGETRequest() {
            if (connectToDB()) {
                if (array_key_exists('selectSubmit', $_GET)) {
                    handleSelectionRequest();
                } else if (array_key_exists('nestedAggTable', $_GET)) {
                    handleNestedAggRequest();
                } else if (array_key_exists('divisionTable', $_GET)) {
                    handleDivisionRequest();
                } else if (array_key_exists('countTuples', $_GET)) {
                    handleCountRequest();
                } else if (array_key_exists('countEmployees', $_GET)){
                    handleCountEmployeesRequest();
                } else if (array_key_exists('findFrequentCustomers', $_GET)){
                    handleFindFrequentCustomersRequest();
                } else if (array_key_exists('viewTuples', $_GET)) {
                    handleViewRequest();
                }
                disconnectFromDB();
            }
        }

		if (isset($_POST['reset']) || 
            isset($_POST['insertSubmit']) || 
            isset($_POST['deleteSubmit']) ||
            isset($_POST['updateSubmit']) ||
            isset($_POST['updateHelperSubmit'])
            ) {
            handlePOSTRequest();
        } else if (isset($_GET['selectionRequest']) ||
                   isset($_GET['nestedAggRequest']) ||
                   isset($_GET['divisionRequest']) ||
                   isset($_GET['countTupleRequest']) ||
                   isset($_GET['countEmployeesRequest']) ||
                   isset($_GET['findFrequentCustomersRequest']) ||
                   isset($_GET['viewTupleRequest'])
            ) {
            handleGETRequest();
        }
		?>
	</body>
</html>
