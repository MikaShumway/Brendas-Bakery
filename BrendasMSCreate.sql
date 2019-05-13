-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema brendasms
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `brendasms` ;

-- -----------------------------------------------------
-- Schema brendasms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `brendasms` DEFAULT CHARACTER SET utf8 ;
USE `brendasms` ;

-- -----------------------------------------------------
-- Table `brendasms`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`customer` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`customer` (
  `ID` INT(11) NOT NULL,
  `FirstName` VARCHAR(45) NULL DEFAULT NULL,
  `LastName` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Phone` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`employee` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`employee` (
  `ID` INT(11) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Phone` VARCHAR(45) NULL DEFAULT NULL,
  `Birthdate` DATE NULL DEFAULT NULL,
  `Address` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `State` VARCHAR(2) NULL DEFAULT NULL,
  `Zip` VARCHAR(45) NULL DEFAULT NULL,
  `Country` VARCHAR(45) NULL DEFAULT NULL,
  `SSN` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`shop` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`shop` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`employeelineitem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`employeelineitem` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`employeelineitem` (
  `ID` INT(11) NOT NULL,
  `HireDate` DATE NULL DEFAULT NULL,
  `EmployeeID` INT(11) NOT NULL,
  `ShopID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_EmployeeLineItem_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_EmployeeLineItem_Shop1_idx` (`ShopID` ASC),
  CONSTRAINT `fk_EmployeeLineItem_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `brendasms`.`employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmployeeLineItem_Shop1`
    FOREIGN KEY (`ShopID`)
    REFERENCES `brendasms`.`shop` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`employeelog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`employeelog` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`employeelog` (
  `ID` INT(11) NOT NULL,
  `EmployeeID` INT(11) NULL DEFAULT NULL,
  `EmployeeName` VARCHAR(90) NULL DEFAULT NULL,
  `EmployeeEmail` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeePhone` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeeBirth` DATE NULL DEFAULT NULL,
  `EmployeeAddress` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeeCity` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeeState` VARCHAR(2) NULL DEFAULT NULL,
  `EmployeeCountry` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeeZip` VARCHAR(45) NULL DEFAULT NULL,
  `EmployeeSSN` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`ingredient` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`ingredient` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`vender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`vender` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`vender` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`order` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`order` (
  `ID` INT(11) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `EmployeeID` INT(11) NOT NULL,
  `VenderID` INT(11) NOT NULL,
  `ShopID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Order_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_Order_Vendor1_idx` (`VenderID` ASC),
  INDEX `fk_Order_Shop1_idx` (`ShopID` ASC),
  CONSTRAINT `fk_Order_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `brendasms`.`employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Shop1`
    FOREIGN KEY (`ShopID`)
    REFERENCES `brendasms`.`shop` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Vendor1`
    FOREIGN KEY (`VenderID`)
    REFERENCES `brendasms`.`vender` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`unitofmeasure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`unitofmeasure` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`unitofmeasure` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`orderlineitem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`orderlineitem` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`orderlineitem` (
  `ID` INT(11) NOT NULL,
  `OrderID` INT(11) NOT NULL,
  `IngredientID` INT(11) NOT NULL,
  `UnitOfMeasureID` INT(11) NULL DEFAULT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  `Price` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_OrderLineItem_Order1_idx` (`OrderID` ASC),
  INDEX `fk_OrderLineItem_Ingredient1_idx` (`IngredientID` ASC),
  INDEX `fk_OrderLineItem_UnitOfMeasure1_idx` (`UnitOfMeasureID` ASC),
  CONSTRAINT `fk_OrderLineItem_Ingredient1`
    FOREIGN KEY (`IngredientID`)
    REFERENCES `brendasms`.`ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderLineItem_Order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `brendasms`.`order` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderLineItem_UnitOfMeasure1`
    FOREIGN KEY (`UnitOfMeasureID`)
    REFERENCES `brendasms`.`unitofmeasure` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`recipe` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`recipe` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`product` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`product` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Supply` INT(11) NULL DEFAULT NULL,
  `RecipeID` INT(11) NOT NULL,
  `Price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Product_Recipe1_idx` (`RecipeID` ASC),
  CONSTRAINT `fk_Product_Recipe1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `brendasms`.`recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`recipelineitem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`recipelineitem` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`recipelineitem` (
  `ID` INT(11) NOT NULL,
  `RecipeID` INT(11) NOT NULL,
  `IngredientID` INT(11) NOT NULL,
  `UnitOfMeasureID` INT(11) NULL DEFAULT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_RecipeLineItem_Recipe1_idx` (`RecipeID` ASC),
  INDEX `fk_RecipeLineItem_Ingredient1_idx` (`IngredientID` ASC),
  INDEX `fk_RecipeLineItem_UnitOfMeasure1_idx` (`UnitOfMeasureID` ASC),
  CONSTRAINT `fk_RecipeLineItem_Ingredient1`
    FOREIGN KEY (`IngredientID`)
    REFERENCES `brendasms`.`ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecipeLineItem_Recipe1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `brendasms`.`recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecipeLineItem_UnitOfMeasure1`
    FOREIGN KEY (`UnitOfMeasureID`)
    REFERENCES `brendasms`.`unitofmeasure` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`sale` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`sale` (
  `ID` INT(11) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `CustomerID` INT(11) NOT NULL,
  `EmployeeID` INT(11) NOT NULL,
  `ShopID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Sale_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_Sale_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Sale_Shop1_idx` (`ShopID` ASC),
  CONSTRAINT `fk_Sale_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `brendasms`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `brendasms`.`employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Shop1`
    FOREIGN KEY (`ShopID`)
    REFERENCES `brendasms`.`shop` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `brendasms`.`salelineitem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brendasms`.`salelineitem` ;

CREATE TABLE IF NOT EXISTS `brendasms`.`salelineitem` (
  `ID` INT(11) NOT NULL,
  `PurchaseID` INT(11) NOT NULL,
  `ProductID` INT(11) NOT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_SaleLineItem_Purchase1_idx` (`PurchaseID` ASC),
  INDEX `fk_SaleLineItem_Product1_idx` (`ProductID` ASC),
  CONSTRAINT `fk_SaleLineItem_Product1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `brendasms`.`product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleLineItem_Purchase1`
    FOREIGN KEY (`PurchaseID`)
    REFERENCES `brendasms`.`sale` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `brendasms` ;

-- -----------------------------------------------------
-- Placeholder table for view `brendasms`.`dailysales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `brendasms`.`dailysales` (`Date` INT, `Sales` INT, `Income` INT);

-- -----------------------------------------------------
-- function Hello
-- -----------------------------------------------------

USE `brendasms`;
DROP function IF EXISTS `brendasms`.`Hello`;

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

-- -----------------------------------------------------
-- procedure Shop_AverageDailyIncome
-- -----------------------------------------------------

USE `brendasms`;
DROP procedure IF EXISTS `brendasms`.`Shop_AverageDailyIncome`;

DELIMITER $$
USE `brendasms`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Shop_AverageDailyIncome`(IN id INT, OUT Average DECIMAL(10, 2))
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure test
-- -----------------------------------------------------

USE `brendasms`;
DROP procedure IF EXISTS `brendasms`.`test`;

DELIMITER $$
USE `brendasms`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN
	DECLARE mID INT;
	SELECT MAX(ID) INTO mID FROM employeelog;
    
    IF ISNULL(mID) THEN
		SET mID = 1;
	ELSE
		SET mID = (mID + 1);
	END IF;
    
    SELECT mID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `brendasms`.`dailysales`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `brendasms`.`dailysales` ;
DROP TABLE IF EXISTS `brendasms`.`dailysales`;
USE `brendasms`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `brendasms`.`dailysales` AS select `brendasms`.`sale`.`Date` AS `Date`,count(`brendasms`.`sale`.`Date`) AS `Sales`,sum((`brendasms`.`product`.`Price` * `brendasms`.`salelineitem`.`Quantity`)) AS `Income` from ((`brendasms`.`sale` join `brendasms`.`salelineitem` on((`brendasms`.`sale`.`ID` = `brendasms`.`salelineitem`.`PurchaseID`))) join `brendasms`.`product` on((`brendasms`.`salelineitem`.`ProductID` = `brendasms`.`product`.`ID`))) group by `brendasms`.`sale`.`Date` order by `brendasms`.`sale`.`Date`;
USE `brendasms`;

DELIMITER $$

USE `brendasms`$$
DROP TRIGGER IF EXISTS `brendasms`.`Employee_After_Delete` $$
USE `brendasms`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `brendasms`.`Employee_After_Delete`
AFTER DELETE ON `brendasms`.`employee`
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
END$$


USE `brendasms`$$
DROP TRIGGER IF EXISTS `brendasms`.`Employee_Before_Insertemployee` $$
USE `brendasms`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `brendasms`.`Employee_Before_Insertemployee`
BEFORE INSERT ON `brendasms`.`employee`
FOR EACH ROW
BEGIN
	SET NEW.Phone = REPLACE(NEW.Phone, '-', '');
    SET NEW.Phone = REPLACE(NEW.Phone, '(', '');
    SET NEW.Phone = REPLACE(NEW.Phone, ')', '');
    SET NEW.Phone = REPLACE(NEW.Phone, ' ', '');
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;