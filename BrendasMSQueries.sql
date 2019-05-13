-- 3.4 - Mika Shumway
-- Lists every employee that works in the 10th shop which is named “Brenda's Space Bakery.”
USE brendasms;

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    shop.Name AS 'Shop'
FROM
    employee
        INNER JOIN
    employeelineitem ON employee.ID = employeelineitem.EmployeeID
        INNER JOIN
    shop ON employeelineitem.ShopID = shop.ID
WHERE
    shop.ID = 10
ORDER BY employee.LastName;



-- 3.5 - Mika Shumway
-- Lists every employee that lives in Houston, Texas or works in “Brenda's Organic Pastries” which is located in Houston, Texas.  The data shown may not be realistic because it was generated.
USE brendasms;

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    City State
FROM
    employee
        INNER JOIN
    employeelineitem ON employee.ID = employeelineitem.EmployeeID
WHERE
    (City = 'Houston' AND State = 'TX')
        OR employeelineitem.ShopID = 5
ORDER BY LastName;



-- 3.6 - Mika Shumway
-- Lists each customer having over 2 purchases made, the total number of purchases each customer made, and the total amount each customer spent on purchases.  This can be used for Brenda’s loyalty program.
USE brendasms;

SELECT 
    CONCAT(customer.FirstName,
            ' ',
            customer.LastName) AS 'Customer',
    COUNT(sale.CustomerID) AS 'Sales',
    SUM(product.Price * salelineitem.Quantity) AS 'Total Paid'
FROM
    customer
        INNER JOIN
    sale ON customer.ID = sale.CustomerID
        INNER JOIN
    salelineitem ON sale.ID = salelineitem.PurchaseID
        INNER JOIN
    product ON salelineitem.ProductID = product.ID
GROUP BY customer.ID
HAVING COUNT(sale.CustomerID) > 2
ORDER BY COUNT(sale.CustomerID);



-- 3.7 - Mika Shumway
-- Lists each sale, the customer involved, and the employee that made the sale.
USE brendasms;

SELECT
	sale.Date AS 'Sale Date',
    CONCAT(customer.FirstName, ' ', customer.LastName) AS 'Customer',
    CONCAT(employee.FirstName, ' ', employee.LastName) AS 'Employee'
FROM
	sale
		INNER JOIN
	Customer ON sale.CustomerID = customer.ID
		INNER JOIN
	Employee ON sale.EmployeeID = employee.ID
ORDER BY sale.Date;



-- 3.8 - Mika Shumway
-- Lists each employee and the total number of sales made by that employee.
USE brendasms;

SELECT 
    CONCAT(employee.FirstName,
            ' ',
            employee.LastName) AS 'Employee',
    COUNT(sale.EmployeeID) AS 'Sales'
FROM
    employee
        LEFT JOIN
    sale ON employee.ID = sale.EmployeeID
GROUP BY employee.ID
ORDER BY COUNT(sale.EmployeeID) DESC;



-- 3.9 - Mika Shumway
-- Lists each shop and the total amount of income made by it.
USE brendasms;

SELECT 
    shop.Name AS 'Shop',
    SUM(product.Price * salelineitem.Quantity) AS 'Total Income'
FROM
    shop
        RIGHT JOIN
    sale ON shop.ID = sale.ShopID
        INNER JOIN
    salelineitem ON sale.ID = salelineitem.PurchaseID
        INNER JOIN
    product ON salelineitem.ProductID = product.ID
GROUP BY shop.Name
ORDER BY SUM(product.Price * salelineitem.Quantity);



-- 3.10 - Mika Shumway
-- Creates a report including the number of sales and amount of income for each day.
CREATE VIEW DailySales AS
    SELECT 
        sale.Date AS 'Date',
        COUNT(sale.Date) AS 'Sales',
        SUM(product.Price * salelineitem.Quantity) AS 'Income'
    FROM
        sale
            INNER JOIN
        salelineitem ON sale.ID = salelineitem.PurchaseID
            INNER JOIN
        product ON salelineitem.ProductID = product.ID
    GROUP BY sale.Date
    ORDER BY sale.Date;



-- 3.11 - Mika Shumway
-- Calculates a shops average income from each sale.
DELIMITER $$

CREATE PROCEDURE `Shop_AverageDailyIncome`(IN id INT, OUT Average DECIMAL(10, 2))
BEGIN
	SELECT 
		ROUND(AVG(salelineitem.Quantity * product.Price), 2)
	INTO
		average
	FROM
		salelineitem
			INNER JOIN
		sale ON salelineitem.PurchaseID = sale.ID
			INNER JOIN
		product ON salelineitem.ProductID = product.ID
			INNER JOIN
		shop ON sale.ShopID = shop.ID
	WHERE
		shop.ID = id;
END $$

DELIMITER ;



-- 3.12 - Mika Shumway
-- Checks for basic format errors in the Phone field.
DELIMITER $$

CREATE TRIGGER Employee_Before_Insertemployee
	BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
	SET NEW.Phone = REPLACE(NEW.Phone, '-', '');
    SET NEW.Phone = REPLACE(NEW.Phone, '(', '');
    SET NEW.Phone = REPLACE(NEW.Phone, ')', '');
    SET NEW.Phone = REPLACE(NEW.Phone, ' ', '');
END $$

DELIMITER ;

--
INSERT INTO employee (ID, FirstName, LastName, Email, Phone, Birthdate, Address, City, State, Zip, Country, SSN)
	VALUES (12, 'Mika', 'Shumway', 'S01158370@acad.tri-c.edu', '(555) 555-5555', '2000-12-15', '555 Tri-c Circle', 'Cleveland', 'OH', '55555', 'United States', 555555555);



-- 3.13 - Mika Shumway
-- Checks for format errors for both the email and state fields.  Displays detailed error messages for each.
DELIMITER $$

CREATE TRIGGER Employee_Before_Update
	BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
	IF (POSITION('@' IN NEW.Email) < 2) THEN
		SIGNAL SQLSTATE '99999' SET MESSAGE_TEXT = 'Invalid email address.  Missing: @ ';
	ELSEIF (POSITION('.' IN NEW.Email) < 4) THEN
		SIGNAL SQLSTATE '99998' SET MESSAGE_TEXT = 'Invalid email address.  Missing: . ';
	ELSEIF (POSITION('.' IN NEW.State) < 2) THEN
		SIGNAL SQLSTATE '99997' SET MESSAGE_TEXT = 'Invalid state abbreviation.  Character Limit: 2 ';
	END IF;
END $$

DELIMITER ;

--
UPDATE employee 
SET 
    Email = 'BadBad.bad'
WHERE
    ID = 12;

UPDATE employee 
SET 
    Email = 'Bad@Badbad'
WHERE
    ID = 12;

UPDATE employee 
SET 
    State = 'BAD'
WHERE
    ID = 12;



-- 3.14 - Mika Shumway
-- Copies the data from the deleted row to a log table called EmployeeLog.
DELIMITER $$

CREATE TRIGGER Employee_After_Delete
	AFTER DELETE ON employee
FOR EACH ROW
BEGIN
	DECLARE mID INT;
	SELECT MAX(ID) INTO mID FROM employeelog;
    
    IF ISNULL(mID) THEN
		SET mID = 1;
	ELSE
		SET mID = (mID + 1);
	END IF;
    
	INSERT INTO employeelog (ID, EmployeeID, EmployeeName, EmployeeEmail, EmployeePhone, EmployeeBirth, EmployeeAddress, EmployeeCity, EmployeeState, EmployeeCountry, EmployeeZip, EmployeeSSN)
		VALUES (
			mID,
			OLD.ID, 
			CONCAT(OLD.FirstName, ' ', OLD.LastName),
			OLD.Email,
            OLD.Phone,
            OLD.Birthdate,
            OLD.Address,
            OLD.City,
            OLD.State,
            OLD.Country,
            OLD.Zip,
            OLD.SSN
        );
END $$

DELIMITER ;

--
DELETE FROM employee 
WHERE
    ID = 12;



-- 3.15 - Mika Shumway
-- Returns a message.
DELIMITER $$
USE `brendasms`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Hello`(input CHAR(20)) RETURNS char(50) CHARSET utf8
    DETERMINISTIC
BEGIN
	DECLARE output VARCHAR(50);
    
	IF (input = '')
		THEN SET output = 'Hello World!';
	ELSE
		SET output = CONCAT('Hello ', input, '!');
	END IF;
    
RETURN output;
END$$

DELIMITER ;