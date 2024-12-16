CREATE DATABASE BlueWood;
DROP DATABASE BlueWood;
USE BlueWood;
CREATE TABLE Cabin(
	CabinID int PRIMARY KEY IDENTITY(1,1),
	CabinName varchar(50) NOT NULL,
	MaxCapacity tinyint NOT NULL
	)
CREATE TABLE Country(
	CountryID int PRIMARY KEY IDENTITY(1,1),
	CountryName varchar(60) NOT NULL
	)
CREATE TABLE Province(
	ProvinceID int PRIMARY KEY IDENTITY(1,1),
	ProvinceName varchar(60) NOT NULL
	)
CREATE TABLE Activity(
	ActivityID int PRIMARY KEY IDENTITY(1,1),
	ActivityName varchar(100) NOT NULL UNIQUE,
	MaxCapacity tinyint NOT NULL
	)
CREATE TABLE Equipment(
	EquipmentID int PRIMARY KEY IDENTITY(1,1),
	EquipmentName varchar(100) NOT NULL,
	Quality varchar(10) NOT NULL,
	EquipmentDescription varchar(200),
	YearOFPurchase date
	)
CREATE TABLE ActivityEquipemnt(
	EquipmentID int NOT NULL,
	ActivityId int NOT NULL,
	PRIMARY KEY (EquipmentID, ActivityId),
	FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID),
	FOREIGN KEY (ActivityId) REFERENCES Activity(ActivityId)
	)

CREATE TABLE EmergencyContact(
	EmergencyContactID int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	PhoneNumber char(10) NOT NULL,
	CivicNumber smallint NOT NULL,
	StreetName varchar(50) NOT NULL,
	City varchar(100) NOT NULL,
	ProvinceID int NOT NULL,
	CountryID int NOT NULL,
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
	)
CREATE TABLE Camper(
	CamperID int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Age tinyint NOT NULL,
	YearsAtCamp tinyint NOT NULL,
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
	AllergyID int PRIMARY KEY IDENTITY(1,1),
	AllergyName varchar(100) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)
CREATE TABLE Medication(
	MedicationID int PRIMARY KEY IDENTITY(1,1),
	MedicationName varchar(100) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID)
	)
CREATE TABLE Councilor(
	CouncilorID int PRIMARY KEY IDENTITY(1,1),
	[SIN] char(9) NOT NULL UNIQUE,
	PhoneNumber char(10) NOT NULL UNIQUE,
	StreetNumber smallint NOT NULL, 
	City varchar(50) NOT NULL, 
	ProvinceID int NOT NULL,
	CountryID int NOT NULL,
	FOREIGN KEY (CouncilorID) REFERENCES Camper(CamperID),
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
	)
CREATE TABLE Paycheck(
	PaycheckID int IDENTITY(1,1), 
	CouncilorID int,
	PRIMARY KEY (PaycheckID,CouncilorID),
	HoursWorked decimal(4,2)NOT NULL,
	SalaryPerHour decimal(4,2) NOT NULL,
	FOREIGN KEY (CouncilorID) REFERENCES Councilor(CouncilorID)
	)

INSERT INTO Cabin(CabinName,MaxCapacity)
VALUES ('PineWood',10),('Evergreen',11),
('Summit',15),('Wildwood',10),
('Timber',12),('Cedar',14),
('Ridge',10),('Lakeside',11),
('Trailhead',13),('Meadow',16),
('Campfire',11),('Haven',9),
('Creekside',12),('Starlight',17),
('Shadow',16),('Foxwood',13),
('Riverbend',14),('Rustwood',14),
('Hilltop',12),('Mossy',10);

INSERT INTO Country(CountryName)
VALUES ('Canada'),('United States'),
('India'),('China'),('Philippines'),
('Nigeria'),('Pakistan'),('Iran'),
('Syria'),('France'),('South Korea'),
('Vietnam'),('Bangladesh'),('United Arab Emirates'),
('Mexico'),('Colombia'),('Lebanon'),('Jamaica'),
('Afghanistan'),('Egypt')



