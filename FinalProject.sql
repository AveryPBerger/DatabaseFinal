DROP DATABASE BlueWood
CREATE DATABASE BlueWood
USE BlueWood

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
	CouncilorID int PRIMARY KEY,
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

INSERT INTO Country (CountryName) 
VALUES 
('Canada'), ('United States'), ('Mexico'), ('France'), ('Germany'), 
('Italy'), ('Spain'), ('Australia'), ('India'), ('China'), 
('Brazil'), ('South Africa'), ('Japan'), ('Russia'), ('Argentina'), 
('Norway'), ('Sweden'), ('Netherlands'), ('Switzerland'), ('New Zealand');

INSERT INTO Province (ProvinceName) 
VALUES ('Ontario'), ('Quebec'), ('British Columbia'),
('Alberta'), ('Manitoba'), ('Saskatchewan'), ('Nova Scotia'),
('New Brunswick'), ('Newfoundland and Labrador'), ('Prince Edward Island'), 
('Northwest Territories'), ('Yukon'), ('Nunavut'), ('California'), ('Texas'), 
('Florida'), ('New York'), ('Washington'), ('Maine'), ('Alaska');


INSERT INTO Activity (ActivityName, MaxCapacity) VALUES 
('Canoeing', 15),('Hiking', 25),('Rock Climbing', 10),
('Swimming', 20),('Archery', 12),('Fishing', 8),
('Yoga', 18),('Crafting', 10),('Campfire Stories', 30),
('Nature Walk', 20),('Orienteering', 15),('Bird Watching', 10),
('Mountain Biking', 8),('Star Gazing', 25),('Scavenger Hunt', 20),
('Kayaking', 12),('Sailing', 15),('Team Building Games', 30),
('Photography', 10),('Pottery', 8);


INSERT INTO Equipment (EquipmentName, Quality, EquipmentDescription, YearOfPurchase) VALUES 
('Life Jacket', 'High', 'Standard flotation device for water activities.', '2020-05-10'),
('Helmet', 'Medium', 'Protective headgear for climbing and biking.', '2019-07-15'),
('Fishing Rod', 'High', 'Lightweight fishing rod.', '2021-03-22'),
('Tent', 'High', 'Waterproof camping tent.', '2018-11-02'),
('Compass', 'Medium', 'Magnetic compass for navigation.', '2020-08-17'),
('Camera', 'High', 'DSLR camera for photography.', '2022-01-10'),
('Paddle', 'High', 'Carbon fiber kayak paddle.', '2021-06-05'),
('Bow and Arrow', 'Medium', 'Recreational archery set.', '2020-04-14'),
('Climbing Rope', 'High', 'Heavy-duty rope for climbing.', '2019-09-19'),
('Yoga Mats', 'High', 'Non-slip yoga mats.', '2022-03-12'),
('Fishing Net', 'Medium', 'Nylon fishing net.', '2021-10-25'),
('Mountain Bike', 'High', 'All-terrain bike.', '2020-12-11'),
('Flashlights', 'Medium', 'LED flashlights for night use.', '2019-05-04'),
('Cooking Set', 'High', 'Portable cooking equipment.', '2022-06-18'),
('Binoculars', 'High', 'Magnification optics for bird watching.', '2020-02-20'),
('Pottery Wheel', 'High', 'Electric pottery wheel.', '2021-08-29'),
('Sailing Kit', 'Medium', 'Basic sailing toolkit.', '2022-07-03'),
('Star Chart', 'Medium', 'Astronomy guide.', '2021-01-21'),
('Campfire Tools', 'High', 'Fire starters and utensils.', '2020-10-15'),
('Hiking Poles', 'Medium', 'Adjustable trekking poles.', '2021-12-09');

INSERT INTO Camper (FirstName, LastName, Age, YearsAtCamp, CabinID)
VALUES
('Liam', 'Smith', 12, 2, 1), ('Olivia', 'Johnson', 11, 1, 2),
('Noah', 'Brown', 13, 3, 3), ('Emma', 'Davis', 14, 4, 4),
('Oliver', 'Wilson', 12, 2, 5),('Sophia', 'Taylor', 13, 3, 6),
('James', 'Anderson', 11, 1, 7), ('Ava', 'Thomas', 10, 1, 8),
('William', 'Moore', 15, 5, 9),('Isabella', 'Martin', 14, 4, 10),
('Ethan', 'White', 13, 3, 11), ('Mia', 'Thompson', 12, 2, 12), 
('Mason', 'Garcia', 11, 1, 13), ('Charlotte', 'Martinez', 10, 1, 14),
('Logan', 'Hernandez', 15, 5, 15),('Amelia', 'Lopez', 14, 4, 16),
('Lucas', 'Gonzalez', 13, 3, 17), ('Harper', 'Perez', 12, 2, 18),
('Henry', 'Clark', 11, 1, 19), ('Evelyn', 'Rodriguez', 15, 5, 20);

INSERT INTO Allergy (AllergyName, CamperID)
VALUES
('Peanuts', 1), ('Shellfish', 2), ('Dairy', 3), ('Gluten', 4), ('Eggs', 5),
('Soy', 6), ('Tree Nuts', 7), ('Wheat', 8), ('Fish', 9), ('Sesame', 10),
('Corn', 11), ('Beef', 12), ('Pork', 13), ('Chicken', 14), ('Tomatoes', 15),
('Strawberries', 16), ('Citrus', 17), ('Bananas', 18), ('Chocolate', 19), ('Honey', 20);

INSERT INTO Medication (MedicationName, CamperID)
VALUES
('Epinephrine', 1), ('Ibuprofen', 2), ('Paracetamol', 3), ('Cetirizine', 4), ('Omeprazole', 5),
('Loratadine', 6), ('Amoxicillin', 7), ('Azithromycin', 8), ('Hydrocortisone', 9), ('Insulin', 10),
('Metformin', 11), ('Prednisone', 12), ('Diazepam', 13), ('Salbutamol', 14), ('Clindamycin', 15),
('Lisinopril', 16), ('Furosemide', 17), ('Aspirin', 18), ('Albuterol', 19), ('Gabapentin', 20);

SELECT * FROM Councilor
INSERT INTO Councilor (CouncilorID, SIN, PhoneNumber, StreetNumber, City, ProvinceID, CountryID)
VALUES
(1, '123456789', '9876543210', 123, 'Toronto', 1, 1),
(2, '234567890', '8765432109', 456, 'Vancouver', 3, 1),
(3, '345678901', '7654321098', 789, 'Montreal', 2, 1),
(4, '456789012', '6543210987', 321, 'Calgary', 4, 1),
(5, '567890123', '5432109876', 654, 'Edmonton', 5, 1),
(6, '678901234', '4321098765', 987, 'Ottawa', 1, 1),
(7, '789012345', '3210987654', 111, 'Winnipeg', 5, 1),
(8, '890123456', '2109876543', 222, 'Halifax', 7, 1),
(9, '901234567', '1098765432', 333, 'Fredericton', 8, 1),
(10, '012345678', '0987654321', 444, 'St. John', 9, 1),
(11, '111111111', '9876543201', 555, 'Charlottetown', 10, 1),
(12, '222222222', '8765432190', 666, 'Whitehorse', 12, 1),
(13, '333333333', '7654321987', 777, 'Yellowknife', 11, 1),
(14, '444444444', '6543219876', 888, 'Iqaluit', 13, 1),
(15, '555555555', '5432198765', 999, 'Los Angeles', 14, 2),
(16, '666666666', '4321987654', 101, 'New York', 17, 2),
(17, '777777777', '3219876543', 202, 'Miami', 16, 2),
(18, '888888888', '2109876432', 303, 'Seattle', 18, 2),
(19, '999999999', '1098765431', 404, 'Boston', 19, 2),
(20, '123123123', '0987654320', 505, 'Dallas', 15, 2);


INSERT INTO Paycheck (CouncilorID, HoursWorked, SalaryPerHour)
VALUES
(1, 40.00, 15.50), (2, 38.50, 16.00), (3, 42.00, 14.75), (4, 39.00, 15.25), (5, 37.50, 16.50),
(6, 40.00, 15.00), (7, 41.00, 14.50), (8, 39.50, 15.75), (9, 38.00, 16.25), (10, 37.00, 14.25),
(11, 36.50, 16.00), (12, 42.00, 15.50), (13, 41.50, 15.75), (14, 40.00, 14.75), (15, 38.50, 16.25),
(16, 39.00, 15.00), (17, 37.50, 14.50), (18, 40.00, 15.25), (19, 42.50, 16.50), (20, 39.50, 15.75);