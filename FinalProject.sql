CREATE DATABASE BlueWood;
DROP DATABASE BlueWood;
USE BlueWood;
CREATE TABLE Cabin(
	CabinID int PRIMARY KEY,
	CabinName varchar(500) NOT NULL,
	MaxCapacity int NOT NULL
	)

CREATE TABLE Country(
	CountryID int PRIMARY KEY,
	CountryName varchar(500) NOT NULL
	)
CREATE TABLE Province(
	ProvinceID int PRIMARY KEY,
	ProvinceName varchar(500) NOT NULL
	)
CREATE TABLE Activity(
	ActivityID int PRIMARY KEY,
	ActivityName varchar(500) NOT NULL,
	MaxCapacity int NOT NULL
	)
CREATE TABLE EmergencyContact(
	EmergencyContactID int PRIMARY KEY,
	FirstName varchar(500) NOT NULL,
	LastName varchar(500) NOT NULL,
	PhoneNumber char(10) NOT NULL,
	CivicNumber int NOT NULL,
	StreetName varchar(500) NOT NULL,
	City varchar(500) NOT NULL,
	ProvinceID int NOT NULL,
	CountryID int NOT NULL,
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
	)
CREATE TABLE Camper(
	CamperID int PRIMARY KEY,
	FirstName varchar(500) NOT NULL,
	LastName varchar(500) NOT NULL,
	Age int NOT NULL,
	YearsAtCamp smallint NOT NULL,
	CabinID int NOT NULL,
	FOREIGN KEY (CabinID) REFERENCES Cabin(CabinID)
	)
CREATE TABLE CamperEmergencyContact(
	CamperID int NOT NULL,
	EmergencyContactID int NOT NULL,
	PRIMARY KEY(CamperID,EmergencyContactID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (EmergencyContactID) REFERENCES EmergencyContact(EmergencyContactID)
	)
CREATE TABLE CamperActivity(
	CamperID int NOT NULL,
	ActivityID int NOT NULL,
	PRIMARY KEY(CamperID,ActivityID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID)
	)
CREATE TABLE Allergy(
	AllergyID int PRIMARY KEY,
	AllergyName varchar(500) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)
CREATE TABLE Medication(
	MedicationID int PRIMARY KEY,
	MedicationName varchar(500) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)