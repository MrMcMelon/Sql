CREATE DATABASE Study;
USE Study;

# Table creation
CREATE TABLE employees(
name VARCHAR(64) NOT NULL,
id INT PRIMARY KEY,
salary INT DEFAULT 0,
bonus INT
);

# Inserting an entire row
INSERT INTO employees VALUES
("ABC", 0, 2500, 500),
("DEF", 1, 2400, 200),
("GHI", 2, 3000, 750),
("ABC", 4, 3500, 1000);

# Inserting only certain fields
INSERT INTO employees(name, id) VALUES
("XYZ", 5),
("PQR", 6);

# Single value insert
INSERT INTO employees VALUE
("LMO", 3, 3000, 400);

# Selecting an entire row from a table (no condition so entire table will be displayed)
SELECT * FROM employees;

# Selecting an entire row when it meets the where condition
SELECT * FROM employees WHERE bonus > 500;

# Selecting only certain columns
SELECT name, id FROM employees WHERE name = "ABC";

# Selecting unique records from the table (Returns the column even if one of them is unique)
SELECT DISTINCT name, id FROM employees;

## Where Clause
# Logical Operators
SELECT * FROM employees WHERE salary = 3000; # Equal To
SELECT * FROM employees WHERE salary != 3000; # Not Equal To
SELECT * FROM employees WHERE salary <> 3000; # Not Equal To
SELECT * FROM employees WHERE bonus > 500; # Greater Than
SELECT * FROM employees WHERE salary < 3000; # Lesser Than
SELECT * FROM employees WHERE bonus >= 500; # Greater Than Equal To
SELECT * FROM employees WHERE salary <= 3000; # Lesser Than Equal To
SELECT * FROM employees WHERE bonus BETWEEN 500 AND 1000; # Between
SELECT * FROM employees WHERE id IN (1, 2, 6, 5); # In
SELECT * FROM employees WHERE salary = 3000 AND bonus = 750; # And
SELECT * FROM employees WHERE salary = 3000 OR bonus = 400; # Or
SELECT * FROM employees WHERE NOT id = 2;  # Not (can be used in combo with all the above logical operators)

# Like Operator (underscore = 1n)
SELECT * FROM employees WHERE name LIKE "A%"; # Finding first letter
SELECT * FROM employees WHERE name LIKE "%C"; # Finding last letter
SELECT * FROM employees WHERE name LIKE "_E%"; # Finding n-1 letter from front
SELECT * FROM employees WHERE name LIKE "%B_"; # Finding n-1 letter from back
SELECT * FROM employees WHERE name NOT LIKE "A%"; # Not and Like together
SELECT * FROM employees WHERE name LIKE "A___%"; # Find pattern and value must be of size n-1 (here starting with a and must be atleast 4 char)
SELECT * FROM employees where name LIKE "%B%"; # Finding pattern anywhere

## Order By Clause
SELECT * FROM employees ORDER BY salary; # Asecnding order (asc is default)
SELECT * FROM employees ORDER BY salary DESC; # Descending order

SELECT * FROM employees ORDER BY salary, bonus; # Multi-Column Select (If the values in the first column are same then the second column is considered)
SELECT * FROM employees ORDER BY salary ASC, bonus DESC; # Multi-Column Select but different order for different columns;

SELECT * FROM employees ORDER BY name; # Alphabetically Asecnding Order By
SELECT * FROM employees ORDER BY name DESC; # Alphabetically Descending Order By

# Combining Operators & Clauses
SELECT * FROM employees WHERE id = 3 OR ( (name LIKE "a%") OR (name LIKE "%f") ) ORDER BY salary DESC;

# NULL values
SELECT * FROM employees WHERE bonus IS NULL; # Is Null (Returns if the value is null)
SELECT * FROM employees WHERE bonus IS NOT NULL; # Is Null + Not

# Updating Values inside a table (DML)
UPDATE employees SET name = "XYZ"; # Updating entire table (Does not work if safe-update mode is enabled)
UPDATE employees SET name = "ABCD" WHERE id = 1; # Updating single column with where condition
UPDATE employees SET name = "ABCDE", salary = 20000 WHERE id = 3; # Updating multiple column with where conditon

# Deleting Values inside a table (DML)
DELETE FROM employees WHERE id = 3; # Delete the record if the where condition is met
DELETE FROM employees; # Deleting all the records (Won't work in safe mode)

# Agreegate Functions
SELECT MIN(salary) FROM employees; # Returns the minimum of the given value (NULL IS CONSIDERED AS ZERO or atleast i think so)
SELECT MAX(salary) FROM employees; # Returns the maximum of the given value 
SELECT MIN(name) AS "Smallest Name?" FROM employees; # Setting a column name to the value using 'AS' Operator
SELECT COUNT(bonus) AS "NUMBER OF EMPLOYEES" FROM employees; # Returns the number of rows with the column (IF VALUE IS NULL IT IS NOT COUNTED)
SELECT AVG(salary) AS "Average salary" FROM employees;

# Group By
CREATE TABLE groupByTable(
grp int,
val int
);

INSERT INTO groupByTable VALUES
(1, 10),
(1, 20),
(1, 30),
(2, 15),
(2, 25),
(2, 35);

SELECT grp, COUNT(val) AS "Item in grp" FROM groupByTable GROUP BY grp; # Puts all the rows with the same value in the given column into a grp and by using COUNT(val) we return the number of rows in each of the grps

# Having Clause (Like where but for agreegate functions)
SELECT grp, AVG(val) AS "Average" FROM groupByTable GROUP BY grp HAVING AVG(val) <= 20; # Only displays grps with avg val less than or equal to 20

# If null
UPDATE employees SET salary = IFNULL(salary, 1000) + IFNULL(bonus, 0) WHERE id > -1; # If the value is null then the given value is used 
UPDATE employees SET bonus = IFNULL(bonus, 0) WHERE id > -1; 

# Arithmetic Operators
SELECT 10 + 20; # Addition
SELECT 10 - 20; # Subtration
SELECT 10 * 10; # Multiplication
SELECT 10 / 10; # Division (Converts to float?)
SELECT 40 % 6; # Modulo

# Drop (DDL)
CREATE DATABASE temp; 
DROP DATABASE temp; # Deletes the database
USE temp;

CREATE TABLE temp(a int);
DROP TABLE temp; # Deletes a table
SELECT * FROM temp;

# Alter Table
ALTER TABLE temp ADD COLUMN b int; # Adds a column to the table
ALTER TABLE temp DROP COLUMN b; # Removes a column from the table
ALTER TABLE temp MODIFY COLUMN b VARCHAR(255) NOT NULL; # Modifys the type / constraints of the given column
ALTER TABLE temp ADD PRIMARY KEY (a); # Makes b the primary-key (does not work if primary key already set)
ALTER TABLE temp DROP PRIMARY KEY; # Removing primary key
ALTER TABLE temp RENAME teemp; # Renaming table
ALTER TABLE teemp RENAME COLUMN b TO C; # Renaming column

# Foriegn Key
CREATE TABLE persons(
name VARCHAR(255),
personId INT PRIMARY KEY
);

CREATE TABLE ORDERS(
orderId INT,
ordererId INT,
PRIMARY KEY(orderId), # Valid Syntax
FOREIGN KEY(ordererId) REFERENCES persons(personId) # Setting orderedId of table orders as a foreign key pointing to the primary key personId of the table persons
);

INSERT INTO persons VALUES
("ABC", 0),
("DEF", 1);

INSERT INTO orders VALUES # Valid Query
(1, 0);

INSERT INTO orders VALUES # In-Valid Query because 2 is not personId in persons
(1, 2);

# Natural Join
CREATE TABLE table1(
name VARCHAR(255),
chill BOOLEAN
);

CREATE TABLE table2(
name VARCHAR(255),
phone INT
);

INSERT INTO table1 VALUES
("ABC", TRUE),
("DEF", FALSE);

INSERT INTO table2 VALUES
("ABC", 92948892),
("XYZ", 92948892),
("DEF", 92948892);

SELECT * FROM table1 NATURAL JOIN table2; 

# Equi Join
SELECT * FROM table1, table2;

# Cross Product
SELECT * from table1 CROSS JOIN table2;