-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pc_hardware_catalog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pc_hardware_catalog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pc_hardware_catalog` DEFAULT CHARACTER SET utf8 ;
USE `pc_hardware_catalog` ;

-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`brand` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `short_name` VARCHAR(10) NOT NULL,
  `long_name` VARCHAR(45) NULL,
  `url` VARCHAR(320) NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE INDEX `brand_name_UNIQUE` (`short_name` ASC) VISIBLE,
  UNIQUE INDEX `long_name_UNIQUE` (`long_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`pc_component`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`pc_component` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`pc_component` (
  `pc_component_id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `model_number` VARCHAR(45) NULL,
  `release_date_year` SMALLINT(4) NULL,
  `release_date_month` TINYINT(2) NULL,
  `release_date_day` TINYINT(2) NULL,
  PRIMARY KEY (`pc_component_id`),
  INDEX `fk_pc_component_brand1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_pc_component_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `pc_hardware_catalog`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`socket_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`socket_type` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`socket_type` (
  `socket_type_id` INT NOT NULL AUTO_INCREMENT,
  `acronym` VARCHAR(3) NULL,
  `name` VARCHAR(45) NULL,
  `release_date_year` SMALLINT(4) NULL,
  PRIMARY KEY (`socket_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`cpu_socket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`cpu_socket` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`cpu_socket` (
  `cpu_socket_id` INT NOT NULL AUTO_INCREMENT,
  `pc_component_id` INT NOT NULL,
  `socket_type_id` INT NOT NULL,
  `pin_count` SMALLINT(5) NULL,
  PRIMARY KEY (`cpu_socket_id`),
  INDEX `fk_cpu_socket_pc_component1_idx` (`pc_component_id` ASC) VISIBLE,
  INDEX `fk_cpu_socket_socket_type1_idx` (`socket_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_cpu_socket_pc_component1`
    FOREIGN KEY (`pc_component_id`)
    REFERENCES `pc_hardware_catalog`.`pc_component` (`pc_component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpu_socket_socket_type1`
    FOREIGN KEY (`socket_type_id`)
    REFERENCES `pc_hardware_catalog`.`socket_type` (`socket_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`chipset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`chipset` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`chipset` (
  `chipset_id` INT NOT NULL AUTO_INCREMENT,
  `pc_component_id` INT NOT NULL,
  `cpu_socket_id` INT NOT NULL,
  PRIMARY KEY (`chipset_id`),
  INDEX `fk_chipset_pc_component1_idx` (`pc_component_id` ASC) VISIBLE,
  INDEX `fk_chipset_cpu_socket1_idx` (`cpu_socket_id` ASC) VISIBLE,
  CONSTRAINT `fk_chipset_pc_component1`
    FOREIGN KEY (`pc_component_id`)
    REFERENCES `pc_hardware_catalog`.`pc_component` (`pc_component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chipset_cpu_socket1`
    FOREIGN KEY (`cpu_socket_id`)
    REFERENCES `pc_hardware_catalog`.`cpu_socket` (`cpu_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`motherboard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`motherboard` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`motherboard` (
  `motherboard_id` INT NOT NULL AUTO_INCREMENT,
  `pc_component_id` INT NOT NULL,
  `chipset_id` INT NOT NULL,
  PRIMARY KEY (`motherboard_id`),
  INDEX `fk_motherboard_pc_component1_idx` (`pc_component_id` ASC) VISIBLE,
  INDEX `fk_motherboard_chipset1_idx` (`chipset_id` ASC) VISIBLE,
  CONSTRAINT `fk_motherboard_pc_component1`
    FOREIGN KEY (`pc_component_id`)
    REFERENCES `pc_hardware_catalog`.`pc_component` (`pc_component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motherboard_chipset1`
    FOREIGN KEY (`chipset_id`)
    REFERENCES `pc_hardware_catalog`.`chipset` (`chipset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`cpu_family`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`cpu_family` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`cpu_family` (
  `cpu_family_id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `code_name` VARCHAR(45) NULL,
  `technology_node` VARCHAR(45) NULL,
  `release_date_year` SMALLINT(4) NULL,
  `release_date_month` TINYINT(2) NULL,
  `release_date_day` TINYINT(2) NULL,
  PRIMARY KEY (`cpu_family_id`),
  INDEX `fk_cpu_family_brand1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_cpu_family_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `pc_hardware_catalog`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`cpu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`cpu` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`cpu` (
  `cpu_id` INT NOT NULL AUTO_INCREMENT,
  `pc_component_id` INT NOT NULL,
  `cpu_socket_id` INT NOT NULL,
  `cpu_family_id` INT NOT NULL,
  `code_name` VARCHAR(45) NULL,
  `speed` VARCHAR(45) NULL,
  `max_tdp` DECIMAL NULL,
  `specification` VARCHAR(45) NULL,
  `cores` INT NULL,
  `threads` INT NULL,
  PRIMARY KEY (`cpu_id`, `cpu_socket_id`),
  INDEX `fk_cpu_pc_component1_idx` (`pc_component_id` ASC) VISIBLE,
  INDEX `fk_cpu_cpu_socket1_idx` (`cpu_socket_id` ASC) VISIBLE,
  INDEX `fk_cpu_cpu_family1_idx` (`cpu_family_id` ASC) VISIBLE,
  CONSTRAINT `fk_cpu_pc_component1`
    FOREIGN KEY (`pc_component_id`)
    REFERENCES `pc_hardware_catalog`.`pc_component` (`pc_component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpu_cpu_socket1`
    FOREIGN KEY (`cpu_socket_id`)
    REFERENCES `pc_hardware_catalog`.`cpu_socket` (`cpu_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpu_cpu_family1`
    FOREIGN KEY (`cpu_family_id`)
    REFERENCES `pc_hardware_catalog`.`cpu_family` (`cpu_family_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`motherboard_cpu_socket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`motherboard_cpu_socket` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`motherboard_cpu_socket` (
  `motherboard_id` INT NOT NULL,
  `cpu_socket_id` INT NOT NULL,
  INDEX `fk_motherboard_cpu_socket_motherboard1_idx` (`motherboard_id` ASC) VISIBLE,
  INDEX `fk_motherboard_cpu_socket_cpu_socket1_idx` (`cpu_socket_id` ASC) VISIBLE,
  CONSTRAINT `fk_motherboard_cpu_socket_motherboard1`
    FOREIGN KEY (`motherboard_id`)
    REFERENCES `pc_hardware_catalog`.`motherboard` (`motherboard_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motherboard_cpu_socket_cpu_socket1`
    FOREIGN KEY (`cpu_socket_id`)
    REFERENCES `pc_hardware_catalog`.`cpu_socket` (`cpu_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`ram_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`ram_type` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`ram_type` (
  `ram_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ram_type_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`expansion_slot_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`expansion_slot_type` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`expansion_slot_type` (
  `expansion_slot_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`expansion_slot_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`expansion_slot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`expansion_slot` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`expansion_slot` (
  `expansion_slot_id` INT NOT NULL,
  `expansion_slot_type_id` INT NOT NULL,
  `version` DECIMAL NULL,
  PRIMARY KEY (`expansion_slot_id`),
  INDEX `fk_expansion_slot_expansion_slot_type1_idx` (`expansion_slot_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_expansion_slot_expansion_slot_type1`
    FOREIGN KEY (`expansion_slot_type_id`)
    REFERENCES `pc_hardware_catalog`.`expansion_slot_type` (`expansion_slot_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`motherboard_expansion_slot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`motherboard_expansion_slot` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`motherboard_expansion_slot` (
  `motherboard_id` INT NOT NULL,
  `expansion_slot_id` INT NOT NULL,
  INDEX `fk_motherboard_expansion_slot_motherboard1_idx` (`motherboard_id` ASC) VISIBLE,
  INDEX `fk_motherboard_expansion_slot_expansion_slot1_idx` (`expansion_slot_id` ASC) VISIBLE,
  CONSTRAINT `fk_motherboard_expansion_slot_motherboard1`
    FOREIGN KEY (`motherboard_id`)
    REFERENCES `pc_hardware_catalog`.`motherboard` (`motherboard_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motherboard_expansion_slot_expansion_slot1`
    FOREIGN KEY (`expansion_slot_id`)
    REFERENCES `pc_hardware_catalog`.`expansion_slot` (`expansion_slot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`ram_slot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`ram_slot` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`ram_slot` (
  `ram_slot_id` INT NOT NULL AUTO_INCREMENT,
  `ram_type_id` INT NOT NULL,
  PRIMARY KEY (`ram_slot_id`),
  INDEX `fk_ram_slot_ram_type1_idx` (`ram_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_ram_slot_ram_type1`
    FOREIGN KEY (`ram_type_id`)
    REFERENCES `pc_hardware_catalog`.`ram_type` (`ram_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`motherboard_ram_slot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`motherboard_ram_slot` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`motherboard_ram_slot` (
  `motherboard_id` INT NOT NULL,
  `ram_slot_id` INT NOT NULL,
  INDEX `fk_motherboard_has_ram_slot_motherboard1_idx` (`motherboard_id` ASC) VISIBLE,
  INDEX `fk_motherboard_has_ram_slot_ram_slot1_idx` (`ram_slot_id` ASC) VISIBLE,
  CONSTRAINT `fk_motherboard_has_ram_slot_motherboard1`
    FOREIGN KEY (`motherboard_id`)
    REFERENCES `pc_hardware_catalog`.`motherboard` (`motherboard_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motherboard_has_ram_slot_ram_slot1`
    FOREIGN KEY (`ram_slot_id`)
    REFERENCES `pc_hardware_catalog`.`ram_slot` (`ram_slot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_hardware_catalog`.`motherboard_supported_cpu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pc_hardware_catalog`.`motherboard_supported_cpu` ;

CREATE TABLE IF NOT EXISTS `pc_hardware_catalog`.`motherboard_supported_cpu` (
  `motherboard_id` INT NOT NULL,
  `cpu_id` INT NOT NULL,
  PRIMARY KEY (`motherboard_id`, `cpu_id`),
  INDEX `fk_motherboard_has_cpu_cpu1_idx` (`cpu_id` ASC) VISIBLE,
  INDEX `fk_motherboard_has_cpu_motherboard1_idx` (`motherboard_id` ASC) VISIBLE,
  CONSTRAINT `fk_motherboard_has_cpu_motherboard1`
    FOREIGN KEY (`motherboard_id`)
    REFERENCES `pc_hardware_catalog`.`motherboard` (`motherboard_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motherboard_has_cpu_cpu1`
    FOREIGN KEY (`cpu_id`)
    REFERENCES `pc_hardware_catalog`.`cpu` (`cpu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
