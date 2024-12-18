CREATE LOGIN [Avery] WITH PASSWORD = 'Avery123';
CREATE LOGIN [Nikolaos] WITH PASSWORD = 'Nikolaos123';
CREATE LOGIN [User1] WITH PASSWORD = 'User1';
CREATE LOGIN [User2] WITH PASSWORD = 'User2';
CREATE LOGIN [User3] WITH PASSWORD = 'User3';

CREATE USER [Avery] FOR LOGIN [Avery]
CREATE USER [Nikolaos] FOR LOGIN [Nikolaos]
CREATE USER [User1] FOR LOGIN [User1]
CREATE USER [User2] FOR LOGIN [User2]

CREATE ROLE Admin
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO Admin;
GRANT EXECUTE ON SCHEMA::dbo TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CabinDetails TO Admin
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.ActivityScheduler TO Admin
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.CamperInfo TO Admin


DROP ROLE Councilor
CREATE ROLE Councilor;
GRANT SELECT ON dbo.Camper TO Councilor;
GRANT SELECT ON dbo.Cabin TO Councilor;
GRANT SELECT ON dbo.Country TO Councilor;
GRANT SELECT ON dbo.Province TO Councilor;
GRANT SELECT ON dbo.Activity TO Councilor;
GRANT SELECT ON dbo.CamperEmergencyContact TO Councilor;
GRANT SELECT ON dbo.CamperActivity TO Councilor;
GRANT SELECT ON dbo.Allergy TO Councilor;
GRANT SELECT ON dbo.Paycheck TO Councilor;
GRANT SELECT ON dbo.CabinDetails TO Admin
GRANT SELECT ON dbo.ActivityScheduler TO Admin
GRANT SELECT ON dbo.CamperInfo TO Admin


CREATE ROLE EmergencyContact;
GRANT SELECT ON dbo.EmergencyContact TO EmergencyContact;


EXEC sp_addrolemember 'Admin', 'Avery';
EXEC sp_addrolemember 'Admin', 'Nikolaos';
EXEC sp_addrolemember 'Councilor', 'User1';
EXEC sp_addrolemember 'EmergencyContact', 'User2';