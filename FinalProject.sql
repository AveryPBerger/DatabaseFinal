

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
	CabinID int,
	FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID),
	FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
	FOREIGN KEY (CabinID) REFERENCES Cabin(CabinID),
);
CREATE TABLE Activity (
	ActivityID int PRIMARY KEY IDENTITY(1,1),
	ActivityName varchar(100) NOT NULL UNIQUE,
	MaxCapacity tinyint NOT NULL,
	CouncilorID int,
	FOREIGN KEY (CouncilorID) REFERENCES Councilor(CouncilorID)
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


INSERT INTO Activity (ActivityName, MaxCapacity,CouncilorID) VALUES 
('Canoeing', 15,1),('Hiking', 25,2),('Rock Climbing', 10,3),
('Swimming', 20,6),('Archery', 12,5),('Fishing', 8,4),
('Yoga', 18,7),('Crafting', 10,8),('Campfire Stories', 30,9),
('Nature Walk', 20,25),('Orienteering', 15,29),('Bird Watching', 10,10),
('Mountain Biking', 8,22),('Star Gazing', 25,28),('Scavenger Hunt', 20,11),
('Kayaking', 12,21),('Sailing', 15,19),('Team Building Games', 30,12),
('Photography', 10,20),('Pottery', 8,14);


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
('Henry', 'Clark', 11, 1, 19), ('Evelyn', 'Rodriguez', 15, 5, 20),
('Benjamin', 'Adams', 10, 1, 1), ('Ella', 'Baker', 11, 2, 1),
('Alexander', 'Carter', 12, 2, 2), ('Scarlett', 'Mitchell', 10, 1, 2),
('Sebastian', 'Scott', 13, 3, 3), ('Grace', 'Nelson', 14, 4, 3),
('Daniel', 'Ward', 11, 2, 4), ('Zoe', 'Turner', 12, 3, 4),
('Jack', 'Phillips', 13, 3, 5), ('Lily', 'Campbell', 10, 1, 5),
('Matthew', 'Parker', 12, 2, 6), ('Chloe', 'Evans', 14, 4, 6),
('David', 'Collins', 11, 1, 7), ('Ella', 'Stewart', 10, 1, 7),
('Joseph', 'Sanchez', 14, 4, 8), ('Nora', 'Morris', 12, 2, 8),
('Michael', 'Reed', 13, 3, 9), ('Emily', 'Bell', 11, 1, 9),
('Samuel', 'Cook', 15, 5, 10), ('Hannah', 'Morgan', 13, 3, 10),
('Gabriel', 'Bailey', 12, 2, 11), ('Lillian', 'Murphy', 10, 1, 11),
('Carter', 'Rivera', 14, 4, 12), ('Sofia', 'Cooper', 13, 3, 12),
('Wyatt', 'Richardson', 10, 1, 13), ('Victoria', 'Howard', 12, 2, 13),
('Owen', 'Cox', 13, 3, 14), ('Aubrey', 'Ward', 11, 1, 14),
('Julian', 'Torres', 14, 4, 15), ('Addison', 'Peterson', 12, 2, 15),
('Isaac', 'Gray', 11, 1, 16), ('Layla', 'Ramirez', 10, 1, 16),
('Luke', 'James', 12, 2, 17), ('Stella', 'Watson', 13, 3, 17),
('Anthony', 'Brooks', 15, 5, 18), ('Zoey', 'Sanders', 14, 4, 18),
('Dylan', 'Price', 11, 1, 19), ('Madison', 'Bennett', 12, 2, 19),
('Nathan', 'Wood', 13, 3, 20), ('Lucy', 'Barnes', 11, 1, 20);

INSERT INTO Allergy (AllergyName)
VALUES
('Peanuts'), ('Shellfish'), ('Dairy'), ('Gluten'), ('Eggs'),
('Soy'), ('Tree Nuts'), ('Wheat'), ('Fish'), ('Sesame'),
('Corn'), ('Beef'), ('Pork'), ('Chicken'), ('Tomatoes'),
('Strawberries'), ('Citrus'), ('Bananas'), ('Chocolate'), ('Honey');

INSERT INTO CamperAllergy (CamperID, AllergyID)
VALUES
(1, 1), (1, 3),  -- Liam Smith has Peanuts and Dairy allergies
(2, 2),          -- Olivia Johnson has Shellfish allergy
(3, 4),          -- Noah Brown has Gluten allergy
(4, 5), (4, 6),  -- Emma Davis has Eggs and Soy allergies
(5, 7),          -- Oliver Wilson has Tree Nuts allergy
(6, 8), (6, 9),  -- Sophia Taylor has Wheat and Fish allergies
(7, 10),         -- James Anderson has Sesame allergy
--(8, 0),          -- Ava Thomas has no allergies
(9, 11), (9, 12), -- William Moore has Corn and Beef allergies
(10, 13),        -- Isabela Martin has Pork allergy
(11, 14), (11, 15), -- Ethan White has Chicken and Tomatoes allergies
(12, 16),        -- Mia Thompson has Strawberries allergy
(13, 17),        -- Mason Garcia has Citrus allergy
(14, 18),        -- Charlotte Martinez has Bananas allergy
--(15, 0),         -- Logan Hernandez has no allergies
(16, 19),        -- Amelia Lopez has Chocolate allergy
--(17, 0),         -- Lucas Gonzalez has no allergies
(18, 20),        -- Harper Perez has Honey allergy
--(19, 0),         -- Henry Clark has no allergies
(20, 1),         -- Evelyn Rodriguez has Peanuts allergy
(21, 2),         -- Benjamin Adams has Shellfish allergy
(22, 4),         -- Ella Baker has Gluten allergy
(23, 5),         -- Alexander Carter has Eggs allergy
(24, 6),         -- Scarlett Mitchell has Soy allergy
(25, 7),         -- Sebastian Scott has Tree Nuts allergy
(26, 8),         -- Grace Nelson has Wheat allergy
(27, 9),         -- Daniel Ward has Fish allergy
(28, 10),        -- Zoe Turner has Sesame allergy
(29, 11),        -- Jack Phillips has Corn allergy
--(30, 0),         -- Lily Campbell has no allergies
(31, 12),        -- Matthew Parker has Beef allergy
(32, 13),        -- Chloe Evans has Pork allergy
(33, 14),        -- David Collins has Chicken allergy
(34, 15),        -- Ella Stewart has Tomatoes allergy
(35, 16),        -- Joseph Sanchez has Strawberries allergy
(36, 17),        -- Nora Morris has Citrus allergy
(37, 18),        -- Michael Reed has Bananas allergy
(38, 19),        -- Emily Bell has Chocolate allergy
(39, 20),        -- Samuel Cook has Honey allergy
(40, 1),         -- Hannah Morgan has Peanuts allergy
(41, 2),         -- Gabriel Bailey has Shellfish allergy
(42, 3),         -- Lillian Murphy has Dairy allergy
(43, 4),         -- Carter Rivera has Gluten allergy
(44, 5),         -- Sofia Cooper has Eggs allergy
(45, 6),         -- Wyatt Richardson has Soy allergy
(46, 7),         -- Victoria Howard has Tree Nuts allergy
(47, 8),         -- Owen Cox has Wheat allergy
(48, 9),         -- Aubrey Ward has Fish allergy
(49, 10);        -- Julian Torres has Sesame allergy
--(50, 0);         -- Addison Peterson has no allergies


INSERT INTO CamperActivity (CamperID, ActivityID)
VALUES
(1, 1), (1, 4),  -- Liam Smith does Canoeing and Swimming
(2, 2), (2, 3),  -- Olivia Johnson does Hiking and Rock Climbing
(3, 5), (3, 6),  -- Noah Brown does Archery and Fishing
(4, 8), (4, 9),  -- Emma Davis does Crafting and Campfire Stories
(5, 7), (5, 10), -- Oliver Wilson does Yoga and Nature Walk
(6, 1), (6, 11), -- Sophia Taylor does Canoeing and Bird Watching
(7, 12), (7, 13), -- James Anderson does Orienteering and Mountain Biking
(8, 14), (8, 15), -- Ava Thomas does Star Gazing and Scavenger Hunt
(9, 2), (9, 16), -- William Moore does Hiking and Kayaking
(10, 3), (10, 4), -- Isabella Martin does Rock Climbing and Swimming
(11, 5), (11, 6), -- Ethan White does Archery and Fishing
(12, 8), (12, 9), -- Mia Thompson does Crafting and Campfire Stories
(13, 7), (13, 10), -- Mason Garcia does Yoga and Nature Walk
(14, 1), (14, 11), -- Charlotte Martinez does Canoeing and Bird Watching
(15, 12), (15, 13), -- Logan Hernandez does Orienteering and Mountain Biking
(16, 14), (16, 15), -- Amelia Lopez does Star Gazing and Scavenger Hunt
(17, 2), (17, 3), -- Lucas Gonzalez does Hiking and Rock Climbing
(18, 4), (18, 5), -- Harper Perez does Swimming and Archery
(19, 6), (19, 7), -- Henry Clark does Fishing and Yoga
(20, 1), (20, 9), -- Evelyn Rodriguez does Canoeing and Campfire Stories
(21, 2), (21, 8), -- Benjamin Adams does Hiking and Crafting
(22, 3), (22, 10), -- Ella Baker does Rock Climbing and Nature Walk
(23, 4), (23, 15), -- Alexander Carter does Swimming and Scavenger Hunt
(24, 6), (24, 16), -- Scarlett Mitchell does Fishing and Kayaking
(25, 7), (25, 12), -- Sebastian Scott does Yoga and Orienteering
(26, 8), (26, 13), -- Grace Nelson does Crafting and Mountain Biking
(27, 9), (27, 5), -- Daniel Ward does Campfire Stories and Archery
(28, 10), (28, 11), -- Zoe Turner does Nature Walk and Bird Watching
(29, 12), (29, 16), -- Jack Phillips does Crafting and Kayaking
(30, 14), (30, 7), -- Lily Campbell does Star Gazing and Yoga
(31, 15), (31, 9), -- Matthew Parker does Sailing and Campfire Stories
(32, 8), (32, 4), -- Chloe Evans does Crafting and Swimming
(33, 13), (33, 10), -- David Collins does Orienteering and Nature Walk
(34, 3), (34, 12), -- Ella Stewart does Rock Climbing and Orienteering
(35, 5), (35, 15), -- Joseph Sanchez does Archery and Scavenger Hunt
(36, 7), (36, 11), -- Nora Morris does Yoga and Bird Watching
(37, 6), (37, 16), -- Michael Reed does Fishing and Kayaking
(38, 14), (38, 13), -- Emily Bell does Pottery and Mountain Biking
(39, 16), (39, 10), -- Samuel Cook does Scavenger Hunt and Nature Walk
(40, 17), (40, 9), -- Hannah Morgan does Photography and Campfire Stories
(41, 3), (41, 1), -- Gabriel Bailey does Rock Climbing and Canoeing
(42, 2), (42, 8), -- Lillian Murphy does Hiking and Crafting
(43, 4), (43, 7), -- Carter Rivera does Swimming and Yoga
(44, 6), (44, 9), -- Sofia Cooper does Fishing and Campfire Stories
(45, 7), (45, 10), -- Wyatt Richardson does Yoga and Nature Walk
(46, 8), (46, 13), -- Victoria Howard does Crafting and Mountain Biking
(47, 9), (47, 1), -- Owen Cox does Fishing and Canoeing
(48, 14), (48, 3), -- Aubrey Ward does Star Gazing and Rock Climbing
(49, 12), (49, 15), -- Julian Torres does Orienteering and Scavenger Hunt
(50, 17), (50, 10); -- Addison Peterson does Photography and Nature Walk


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
('Ava', 'Young', '988900112', '9889001122', 120, 'Victoria', 3, 1, 20),       -- British Columbia, Canada, Cabin Mossy
('Liam', 'Carter', '121212121', '1111111111', 201, 'Toronto', 1, 1, 1),         -- Ontario, Canada
('Sophia', 'Robinson', '232323232', '2222222222', 202, 'Vancouver', 2, 1, 2),   -- British Columbia, Canada
('Mason', 'Clark', '343434343', '3333333333', 203, 'Calgary', 4, 1, 3),         -- Alberta, Canada
('Isabella', 'Lopez', '454545454', '4444444444', 204, 'Ottawa', 1, 1, 4),       -- Ontario, Canada
('Elijah', 'Gonzalez', '565656565', '5555555555', 205, 'Montreal', 2, 1, 5),    -- Quebec, Canada
('Harper', 'Hill', '676767676', '6666666666', 206, 'Edmonton', 4, 1, 6),        -- Alberta, Canada
('Alexander', 'Baker', '787878787', '7777777777', 207, 'Halifax', 7, 1, 7),     -- Nova Scotia, Canada
('Ella', 'King', '898989898', '8888888888', 208, 'Quebec City', 2, 1, 8),       -- Quebec, Canada
('Oliver', 'Wright', '909090909', '9999999999', 209, 'Winnipeg', 5, 1, 9),      -- Manitoba, Canada
('Avery', 'Scott', '111222333', '1010101010', 210, 'Victoria', 3, 1, 10),       -- British Columbia, Canada
('Evelyn', 'Green', '222333444', '2020202020', 211, 'Toronto', 1, 1, 11),       -- Ontario, Canada
('Lucas', 'Adams', '333444555', '3030303030', 212, 'Vancouver', 2, 1, 12),      -- British Columbia, Canada
('Mila', 'Nelson', '444555666', '4040404040', 213, 'Calgary', 4, 1, 13),        -- Alberta, Canada
('Henry', 'Cox', '555666777', '5050505050', 214, 'Ottawa', 1, 1, 14),           -- Ontario, Canada
('Aria', 'Reed', '666777888', '6060606060', 215, 'Montreal', 2, 1, 15),         -- Quebec, Canada
('Sebastian', 'Foster', '777888999', '7070707070', 216, 'Edmonton', 4, 1, 16),  -- Alberta, Canada
('Madison', 'Collins', '888999000', '8080808080', 217, 'Halifax', 7, 1, 17),    -- Nova Scotia, Canada
('Eli', 'Stewart', '999000111', '9090909090', 218, 'Quebec City', 2, 1, 18),    -- Quebec, Canada
('Scarlett', 'Ross', '000111222', '1212121212', 219, 'Winnipeg', 5, 1, 19),     -- Manitoba, Canada
('Logan', 'Barnes', '111222334', '1313131313', 220, 'Victoria', 3, 1, 20);      -- British Columbia, Canada


INSERT INTO Paycheck (CouncilorID, HoursWorked, SalaryPerHour)
VALUES
(1, 40.00, 15.50), 
(2, 38.50, 16.00), 
(3, 42.00, 14.75), 
(4, 39.00, 15.25), 
(5, 37.50, 16.50),
(6, 40.00, 15.00), 
(7, 41.00, 14.50), 
(8, 39.50, 15.75), 
(9, 38.00, 16.25), 
(10, 37.00, 14.25),
(11, 36.50, 16.00), 
(12, 42.00, 15.50), 
(13, 41.50, 15.75), 
(14, 40.00, 14.75), 
(15, 38.50, 16.25),
(16, 39.00, 15.00), 
(17, 37.50, 14.50), 
(18, 40.00, 15.25), 
(19, 42.50, 16.50), 
(20, 39.50, 15.75),
(21, 40.00, 15.50), 
(22, 38.50, 16.00), 
(23, 42.00, 14.75), 
(24, 39.00, 15.25), 
(25, 37.50, 16.50),
(26, 40.00, 15.00), 
(27, 41.00, 14.50), 
(28, 39.50, 15.75), 
(29, 38.00, 16.25), 
(30, 37.00, 14.25),
(31, 36.50, 16.00), 
(32, 42.00, 15.50), 
(33, 41.50, 15.75), 
(34, 40.00, 14.75), 
(35, 38.50, 16.25),
(36, 39.00, 15.00), 
(37, 37.50, 14.50), 
(38, 40.00, 15.25), 
(39, 42.50, 16.50), 
(40, 39.50, 15.75);

INSERT INTO EmergencyContact (FirstName, LastName, PhoneNumber, CivicNumber, StreetName, City, ProvinceID, CountryID)
VALUES 
('John', 'Smith', '1234567890', 101, 'Maple Street', 'Toronto', 1, 1), -- Ontario, Canada
('Jane', 'Doe', '2345678901', 202, 'Oak Avenue', 'Vancouver', 3, 1), -- British Columbia, Canada
('Michael', 'Brown', '3456789012', 303, 'Pine Road', 'Montreal', 2, 1), -- Quebec, Canada
('Sarah', 'Johnson', '4567890123', 404, 'Birch Lane', 'Calgary', 4, 1), -- Alberta, Canada
('David', 'Lee', '5678901234', 505, 'Cedar Drive', 'Winnipeg', 5, 1), -- Manitoba, Canada
('Emily', 'Davis', '6789012345', 606, 'Spruce Street', 'Los Angeles', 14, 2), -- California, United States
('Chris', 'Miller', '7890123456', 707, 'Elm Street', 'Dallas', 15, 2), -- Texas, United States
('Olivia', 'Wilson', '8901234567', 808, 'Ash Road', 'New York City', 17, 2), -- New York, United States
('Sophia', 'Martinez', '9012345678', 909, 'Willow Lane', 'Miami', 16, 2), -- Florida, United States
('James', 'Anderson', '0123456789', 110, 'Poplar Drive', 'Seattle', 18, 2), -- Washington, United States
('Linda', 'Thompson', '1234509876', 210, 'Main Street', 'Paris', 1, 4), -- Ontario, France
('Henry', 'Garcia', '2345609871', 310, 'King Road', 'Berlin', 1, 5), -- Ontario, Germany
('Mason', 'Lopez', '3456709872', 410, 'Queen Avenue', 'Madrid', 1, 7), -- Ontario, Spain
('Isabella', 'Gonzalez', '4567809873', 510, 'Prince Street', 'Rome', 1, 6), -- Ontario, Italy
('Alexander', 'Scott', '5678909874', 610, 'Duke Road', 'Sydney', 1, 8), -- Ontario, Australia
('Chloe', 'Walker', '6789010985', 710, 'Smith Lane', 'Mumbai', 1, 9), -- Ontario, India
('Benjamin', 'Harris', '7890121986', 810, 'West Street', 'Shanghai', 1, 10), -- Ontario, China
('Evelyn', 'Carter', '8901232987', 910, 'East Avenue', 'Rio de Janeiro', 1, 11), -- Ontario, Brazil
('Lucas', 'Clark', '9012343988', 111, 'North Road', 'Cape Town', 1, 12), -- Ontario, South Africa
('Amelia', 'Young', '0123454989', 112, 'South Drive', 'Tokyo', 1, 13); -- Ontario, Japan


INSERT INTO CamperEmergencyContact (CamperID, EmergencyContactID) VALUES
(1, 1), (1, 2), 
(2, 3),           
(3, 1), (3, 4), 
(4, 5),           
(5, 6), (5, 7), 
(6, 8),           
(7, 9),           
(8, 10), (8, 11), 
(9, 12),           
(10,13),          
(11,14),          
(12,15),          
(13,16), (13, 17), 
(14,18),          
(15,19),          
(16,20);
