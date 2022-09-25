SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Client` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `idClient_UNIQUE` (`idClient` ASC)  ,
  INDEX `fk_Client_Person2_idx` (`Person_idPerson` ASC)  ,
  CONSTRAINT `fk_Client_Person2`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Person` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(15) NOT NULL,
  `Identification` VARCHAR(15) NOT NULL,
  `Type` ENUM('Client', 'Worker') NOT NULL,
  PRIMARY KEY (`idPerson`),
  UNIQUE INDEX `idPerson_UNIQUE` (`idPerson` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service_Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Service_Order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Service_Order` (
  `idService_Order` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `Status` ENUM('Analyzed', 'In Progress', 'Ready', 'Authorized', 'Not Authorized') NOT NULL,
  `Ready_Until` DATETIME NOT NULL,
  `Priority` ENUM('Low', 'Medium', 'High', 'Urgent') NOT NULL,
  `Total_Cost` FLOAT NOT NULL,
  PRIMARY KEY (`idService_Order`),
  UNIQUE INDEX `idService_Order_UNIQUE` (`idService_Order` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Labor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Labor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Labor` (
  `idLabor` INT NOT NULL AUTO_INCREMENT,
  `Labor_Cost` FLOAT NOT NULL,
  PRIMARY KEY (`idLabor`),
  UNIQUE INDEX `idLabor_UNIQUE` (`idLabor` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Manager` (
  `idManager` INT NOT NULL AUTO_INCREMENT,
  `Worker_idWorker` INT NOT NULL,
  `Manager_Salary` FLOAT NOT NULL,
  PRIMARY KEY (`idManager`),
  UNIQUE INDEX `idManager_UNIQUE` (`idManager` ASC)  ,
  INDEX `fk_Manager_Worker1_idx` (`Worker_idWorker` ASC)  ,
  CONSTRAINT `fk_Manager_Worker1`
    FOREIGN KEY (`Worker_idWorker`)
    REFERENCES `mydb`.`Worker` (`idWorker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mechanic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mechanic` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mechanic` (
  `idMechanic` INT NOT NULL AUTO_INCREMENT,
  `Specialization` ENUM('Painter', 'General Repair', 'Specialized Repair') NOT NULL,
  `Worker_idWorker` INT NOT NULL,
  `Mechanic_Salary` FLOAT NOT NULL,
  PRIMARY KEY (`idMechanic`),
  UNIQUE INDEX `idMechanic_UNIQUE` (`idMechanic` ASC)  ,
  INDEX `fk_Mechanic_Worker1_idx` (`Worker_idWorker` ASC)  ,
  CONSTRAINT `fk_Mechanic_Worker1`
    FOREIGN KEY (`Worker_idWorker`)
    REFERENCES `mydb`.`Worker` (`idWorker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Parts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Parts` (
  `idParts` INT NOT NULL AUTO_INCREMENT,
  `Part_Name` VARCHAR(45) NOT NULL,
  `Part_Cost` VARCHAR(45) NOT NULL,
  `Part_Cost` FLOAT NOT NULL,
  PRIMARY KEY (`idParts`),
  UNIQUE INDEX `idParts_UNIQUE` (`idParts` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parts_has_Service_Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Parts_has_Service_Order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Parts_has_Service_Order` (
  `Parts_idParts` INT NOT NULL,
  `Service_Order_idService_Order` INT NOT NULL,
  PRIMARY KEY (`Parts_idParts`, `Service_Order_idService_Order`),
  INDEX `fk_Parts_has_Service_Order_Service_Order1_idx` (`Service_Order_idService_Order` ASC)  ,
  INDEX `fk_Parts_has_Service_Order_Parts1_idx` (`Parts_idParts` ASC)  ,
  CONSTRAINT `fk_Parts_has_Service_Order_Parts1`
    FOREIGN KEY (`Parts_idParts`)
    REFERENCES `mydb`.`Parts` (`idParts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Parts_has_Service_Order_Service_Order1`
    FOREIGN KEY (`Service_Order_idService_Order`)
    REFERENCES `mydb`.`Service_Order` (`idService_Order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Repairs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Repairs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Repairs` (
  `idRepairs` INT NOT NULL AUTO_INCREMENT,
  `Labor_idLabor` INT NOT NULL,
  `Description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idRepairs`),
  UNIQUE INDEX `idRepairs_UNIQUE` (`idRepairs` ASC)  ,
  INDEX `fk_Repairs_Labor1_idx` (`Labor_idLabor` ASC)  ,
  CONSTRAINT `fk_Repairs_Labor1`
    FOREIGN KEY (`Labor_idLabor`)
    REFERENCES `mydb`.`Labor` (`idLabor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Repair_Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Repair_Team` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Repair_Team` (
  `idRepair_Team` INT NOT NULL AUTO_INCREMENT,
  `Vehicle_idVehicle` INT NOT NULL,
  `Service_Order_idService_Order` INT NOT NULL,
  `Repairs_idRepairs` INT NOT NULL,
  `Mechanic_idMechanic` INT NOT NULL,
  PRIMARY KEY (`idRepair_Team`),
  UNIQUE INDEX `idRepair_Team_UNIQUE` (`idRepair_Team` ASC)  ,
  INDEX `fk_Repair_Team_Vehicle1_idx` (`Vehicle_idVehicle` ASC)  ,
  INDEX `fk_Repair_Team_Service_Order1_idx` (`Service_Order_idService_Order` ASC)  ,
  INDEX `fk_Repair_Team_Repairs1_idx` (`Repairs_idRepairs` ASC)  ,
  INDEX `fk_Repair_Team_Mechanic1_idx` (`Mechanic_idMechanic` ASC)  ,
  CONSTRAINT `fk_Repair_Team_Vehicle1`
    FOREIGN KEY (`Vehicle_idVehicle`)
    REFERENCES `mydb`.`Vehicle` (`idVehicle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Repair_Team_Service_Order1`
    FOREIGN KEY (`Service_Order_idService_Order`)
    REFERENCES `mydb`.`Service_Order` (`idService_Order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Repair_Team_Repairs1`
    FOREIGN KEY (`Repairs_idRepairs`)
    REFERENCES `mydb`.`Repairs` (`idRepairs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Repair_Team_Mechanic1`
    FOREIGN KEY (`Mechanic_idMechanic`)
    REFERENCES `mydb`.`Mechanic` (`idMechanic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Secretary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Secretary` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Secretary` (
  `idSecretary` INT NOT NULL AUTO_INCREMENT,
  `Typing_Speed` VARCHAR(45) NOT NULL,
  `Worker_idWorker` INT NOT NULL,
  `Secretary_Salary` FLOAT NOT NULL,
  PRIMARY KEY (`idSecretary`),
  UNIQUE INDEX `idSecretary_UNIQUE` (`idSecretary` ASC)  ,
  INDEX `fk_Secretary_Worker1_idx` (`Worker_idWorker` ASC)  ,
  CONSTRAINT `fk_Secretary_Worker1`
    FOREIGN KEY (`Worker_idWorker`)
    REFERENCES `mydb`.`Worker` (`idWorker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service_Order_has_Repairs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Service_Order_has_Repairs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Service_Order_has_Repairs` (
  `Service_Order_idService_Order` INT NOT NULL,
  `Repairs_idRepairs` INT NOT NULL,
  PRIMARY KEY (`Service_Order_idService_Order`, `Repairs_idRepairs`),
  INDEX `fk_Service_Order_has_Repairs_Repairs1_idx` (`Repairs_idRepairs` ASC)  ,
  INDEX `fk_Service_Order_has_Repairs_Service_Order1_idx` (`Service_Order_idService_Order` ASC)  ,
  CONSTRAINT `fk_Service_Order_has_Repairs_Service_Order1`
    FOREIGN KEY (`Service_Order_idService_Order`)
    REFERENCES `mydb`.`Service_Order` (`idService_Order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service_Order_has_Repairs_Repairs1`
    FOREIGN KEY (`Repairs_idRepairs`)
    REFERENCES `mydb`.`Repairs` (`idRepairs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vehicle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle` (
  `idVehicle` INT NOT NULL AUTO_INCREMENT,
  `Client_idClient` INT NOT NULL,
  `Brand` VARCHAR(20) NOT NULL,
  `Model` VARCHAR(30) NOT NULL,
  `License_Plate_No` VARCHAR(10) NOT NULL,
  `Weight` FLOAT NOT NULL,
  `isAutomatic` TINYINT NOT NULL,
  `isElectric` TINYINT NOT NULL,
  `Type` ENUM('Car', 'Truck', 'Motorcycle', 'Other') NOT NULL,
  `isAWD` TINYINT NOT NULL,
  PRIMARY KEY (`idVehicle`),
  UNIQUE INDEX `idVehicle_UNIQUE` (`idVehicle` ASC)  ,
  INDEX `fk_Vehicle_Client1_idx` (`Client_idClient` ASC)  ,
  UNIQUE INDEX `License_Plate_No_UNIQUE` (`License_Plate_No` ASC)  ,
  CONSTRAINT `fk_Vehicle_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.` Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Worker` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Worker` (
  `idWorker` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  `Started_at` DATETIME NOT NULL,
  `Birth_date` DATETIME NOT NULL,
  PRIMARY KEY (`idWorker`),
  UNIQUE INDEX `idWorker_UNIQUE` (`idWorker` ASC)  ,
  INDEX `fk_Worker_Person1_idx` (`Person_idPerson` ASC)  ,
  CONSTRAINT `fk_Worker_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
