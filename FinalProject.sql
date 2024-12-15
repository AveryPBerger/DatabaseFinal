CREATE DATABASE BlueWood;

USE BlueWood;

CREATE TABLE Cabins(
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

CREATE TABLE Activities(
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
