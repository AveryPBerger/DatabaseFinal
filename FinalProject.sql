CREATE DATABASE BlueWood;
DROP DATABASE BlueWood;
USE BlueWood;
CREATE TABLE Cabin(
	CabinID int PRIMARY KEY,
	CabinName varchar(500),
	MaxCapacity int
	)

CREATE TABLE Country(
	CountryID int PRIMARY KEY,
	CountryName varchar(500)
	)
CREATE TABLE Province(
	ProvinceID int PRIMARY KEY,
	ProvinceName varchar(500)
	)
CREATE TABLE Activity(
	ActivityID int PRIMARY KEY,
	ActivityName varchar(500),
	MaxCapacity int
	)
CREATE TABLE EmergencyContact(
	EmergencyContactID int PRIMARY KEY,
	FirstName varchar(500),
	LastName varchar(500),
	PhoneNumber char(10),
	CivicNumber int,
	StreetName varchar(500),
	City varchar(500),
	ProvinceID int,
	CountryID int,
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
	)
CREATE TABLE Camper(
	CamperID int PRIMARY KEY,
	FirstName varchar(500),
	LastName varchar(500),
	Age int,
	YearsAtCamp smallint,
	CabinID int,
	FOREIGN KEY (CabinID) REFERENCES Cabin(CabinID)
	)
CREATE TABLE CamperEmergencyContact(
	CamperID int,
	EmergencyContactID int,
	PRIMARY KEY(CamperID,EmergencyContactID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (EmergencyContactID) REFERENCES EmergencyContact(EmergencyContactID)
	)
CREATE TABLE CamperActivity(
	CamperID int,
	ActivityID int,
	PRIMARY KEY(CamperID,ActivityID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID)
	)
CREATE TABLE Allergie(
	AllergieID int,
	AllergieName varchar(500),
	CamperID int,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)
CREATE TABLE Medication(
	MedicationID int,
	MedicationName varchar(500),
	CamperID int,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)