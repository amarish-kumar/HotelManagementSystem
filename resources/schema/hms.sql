-- MySQL Script generated by MySQL Workbench
-- Mon Oct 23 20:32:09 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hms
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hms` DEFAULT CHARACTER SET utf8 ;
USE `hms` ;

-- -----------------------------------------------------
-- Table `hms`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `currency` VARCHAR(3) NOT NULL,
  `price_night` DECIMAL(6,2) NOT NULL DEFAULT 0,
  `type` ENUM('standard', 'double') NOT NULL DEFAULT 'standard',
  `max_persons` INT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hms`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `type` ENUM('admin', 'user') NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hms`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(30) NULL,
  `mobile` VARCHAR(30) NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL,
  `organization` VARCHAR(50) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_user_id` (`user_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hms`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `arrival` DATETIME NOT NULL,
  `departure` DATETIME NOT NULL,
  `checkin` DATETIME NULL,
  `checkout` DATETIME NULL,
  `breakfast` TINYINT NULL DEFAULT 0,
  `nights` TINYINT NULL DEFAULT 1,
  `adults` INT NULL DEFAULT 1,
  `children` INT NULL DEFAULT 0,
  `comments` TEXT NULL,
  `room_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookings_room_id` (`room_id` ASC),
  INDEX `fk_bookings_customer_id` (`customer_id` ASC),
  INDEX `fk_bookings_user_id` (`user_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hms`.`cancellations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`cancellations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `comments` TEXT NOT NULL,
  `booking_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancellations_booking_id` (`booking_id` ASC),
  INDEX `fk_cancellations_user_id` (`user_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hms`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hms`.`payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(6,2) NOT NULL,
  `method` ENUM('cash', 'card', 'online') NOT NULL,
  `currency` VARCHAR(3) NOT NULL DEFAULT 'USD',
  `source` VARCHAR(50) NULL,
  `booking_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payments_booking_id` (`booking_id` ASC),
  INDEX `fk_payments_user_id` (`user_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
