DROP DATABASE BlueWood;
CREATE DATABASE BlueWood;
USE BlueWood;

CREATE TABLE Cabin (
	CabinID int PRIMARY KEY IDENTITY(1,1),
	CabinName varchar(50) NOT NULL,
	MaxCapacity tinyint NOT NULL,
);

CREATE TABLE Country (
	CountryID int PRIMARY KEY IDENTITY(1,1),
	CountryName varchar(60) NOT NULL,
);

CREATE TABLE Province (
	ProvinceID int PRIMARY KEY IDENTITY(1,1),
	ProvinceName varchar(60) NOT NULL,
);

CREATE TABLE Activity (
	ActivityID int PRIMARY KEY IDENTITY(1,1),
	ActivityName varchar(100) NOT NULL UNIQUE,
	MaxCapacity tinyint NOT NULL,
);

CREATE TABLE Equipment (
	EquipmentID int PRIMARY KEY IDENTITY(1,1),
	EquipmentName varchar(100) NOT NULL,
	Quality varchar(10) NOT NULL,
	EquipmentDescription varchar(200),
	YearOFPurchase date,
);

CREATE TABLE ActivityEquipemnt (
	EquipmentID int NOT NULL,
	ActivityId int NOT NULL,
	PRIMARY KEY (EquipmentID, ActivityId),
	FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID),
	FOREIGN KEY (ActivityId) REFERENCES Activity(ActivityId),
);

CREATE TABLE EmergencyContact (
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
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
);

CREATE TABLE Camper (
	CamperID int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Age tinyint NOT NULL,
	YearsAtCamp tinyint NOT NULL,
	CabinID int NOT NULL,
	FOREIGN KEY (CabinID) REFERENCES Cabin(CabinID),
);

CREATE TABLE CamperEmergencyContact (
	CamperID int NOT NULL,
	EmergencyContactID int NOT NULL,
	PRIMARY KEY (CamperID,EmergencyContactID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (EmergencyContactID) REFERENCES EmergencyContact(EmergencyContactID),
);

-- Maybe remove not null
CREATE TABLE CamperActivity (
	CamperID int NOT NULL,
	ActivityID int NOT NULL,
	PRIMARY KEY (CamperID,ActivityID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
);

CREATE TABLE Allergy (
	AllergyID int PRIMARY KEY IDENTITY(1,1),
	AllergyName varchar(100) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
);

CREATE TABLE CamperAllergy (
	CamperID int NOT NULL,
	AllergyID int NOT NULL,
	PRIMARY KEY (CamperID, AllergyID),
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
	FOREIGN KEY (AllergyID) REFERENCES Allergy(AllergyID),
);

CREATE TABLE Medication (
	MedicationID int PRIMARY KEY IDENTITY(1,1),
	MedicationName varchar(100) NOT NULL,
	CamperID int NOT NULL,
	FOREIGN KEY (CamperID) REFERENCES Camper(CamperID),
);

CREATE TABLE Councilor (
	CouncilorID int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	[SIN] char(9) NOT NULL UNIQUE,
	PhoneNumber char(10) NOT NULL UNIQUE,
	StreetNumber smallint NOT NULL, 
	City varchar(50) NOT NULL, 
	ProvinceID int NOT NULL,
	CountryID int NOT NULL,
	CabinID int NOT NULL,
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
	FOREIGN KEY (CabinID) REFERENCES Cabin(CabinID),
);

CREATE TABLE Paycheck (
	PaycheckID int IDENTITY(1,1), 
	CouncilorID int,
	PRIMARY KEY (PaycheckID,CouncilorID),
	HoursWorked decimal(4,2)NOT NULL,
	SalaryPerHour decimal(4,2) NOT NULL,
	FOREIGN KEY (CouncilorID) REFERENCES Councilor(CouncilorID),
);

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

INSERT INTO Councilor (FirstName, LastName, [SIN], PhoneNumber, StreetNumber, City, ProvinceID, CountryID, CabinID) 
VALUES
('John', 'Doe', '123456789', '1234567890', 101, 'Toronto', 1, 1, 1),           -- Ontario, Canada, Cabin PineWood
('Jane', 'Smith', '987654321', '0987654321', 102, 'Vancouver', 2, 1, 2),       -- British Columbia, Canada, Cabin Evergreen
('Michael', 'Johnson', '111223344', '1122334455', 103, 'Calgary', 4, 1, 3),    -- Alberta, Canada, Cabin Summit
('Emily', 'Williams', '223344556', '2233445566', 104, 'Ottawa', 1, 1, 4),       -- Ontario, Canada, Cabin Wildwood
('David', 'Brown', '334455667', '3344556677', 105, 'Montreal', 2, 1, 5),       -- Quebec, Canada, Cabin Timber
('Sarah', 'Davis', '445566778', '4455667788', 106, 'Edmonton', 4, 1, 6),       -- Alberta, Canada, Cabin Cedar
('William', 'Miller', '556677889', '5566778899', 107, 'Halifax', 7, 1, 7),      -- Nova Scotia, Canada, Cabin Ridge
('Jessica', 'Wilson', '667788990', '6677889900', 108, 'Quebec City', 2, 1, 8),  -- Quebec, Canada, Cabin Lakeside
('Andrew', 'Moore', '778899001', '7788990011', 109, 'Winnipeg', 5, 1, 9),      -- Manitoba, Canada, Cabin Trailhead
('Olivia', 'Taylor', '889900112', '8899001122', 110, 'Victoria', 3, 1, 10),    -- British Columbia, Canada, Cabin Meadow
('James', 'Anderson', '990011223', '9900112233', 111, 'Toronto', 1, 1, 11),    -- Ontario, Canada, Cabin Campfire
('Isabella', 'Thomas', '100122334', '1001223344', 112, 'Vancouver', 2, 1, 12),  -- British Columbia, Canada, Cabin Haven
('Benjamin', 'Jackson', '211233445', '2112334455', 113, 'Calgary', 4, 1, 13),  -- Alberta, Canada, Cabin Creekside
('Charlotte', 'White', '322344556', '3223445566', 114, 'Ottawa', 1, 1, 14),    -- Ontario, Canada, Cabin Starlight
('Daniel', 'Harris', '433455667', '4334556677', 115, 'Montreal', 2, 1, 15),    -- Quebec, Canada, Cabin Shadow
('Amelia', 'Martin', '544566778', '5445667788', 116, 'Edmonton', 4, 1, 16),    -- Alberta, Canada, Cabin Foxwood
('Lucas', 'Lee', '655677889', '6556778899', 117, 'Halifax', 7, 1, 17),         -- Nova Scotia, Canada, Cabin Riverbend
('Mia', 'Walker', '766788990', '7667889900', 118, 'Quebec City', 2, 1, 18),    -- Quebec, Canada, Cabin Rustwood
('Ethan', 'Perez', '877899001', '8778990011', 119, 'Winnipeg', 5, 1, 19),      -- Manitoba, Canada, Cabin Hilltop
('Ava', 'Young', '988900112', '9889001122', 120, 'Victoria', 3, 1, 20);       -- British Columbia, Canada, Cabin Mossy


INSERT INTO Paycheck (CouncilorID, HoursWorked, SalaryPerHour)
VALUES
(1, 40.00, 15.50), (2, 38.50, 16.00), (3, 42.00, 14.75), (4, 39.00, 15.25), (5, 37.50, 16.50),
(6, 40.00, 15.00), (7, 41.00, 14.50), (8, 39.50, 15.75), (9, 38.00, 16.25), (10, 37.00, 14.25),
(11, 36.50, 16.00), (12, 42.00, 15.50), (13, 41.50, 15.75), (14, 40.00, 14.75), (15, 38.50, 16.25),
(16, 39.00, 15.00), (17, 37.50, 14.50), (18, 40.00, 15.25), (19, 42.50, 16.50), (20, 39.50, 15.75);