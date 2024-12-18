USE BlueWood;

CREATE VIEW CamperInfo AS
SELECT 
    CONCAT(EC.FirstName, ' ', EC.LastName) AS 'EmergencyContactName',
    EC.PhoneNumber AS 'EmergencyContactNumber',
    C.CamperID,
    C.FirstName AS 'CamperFirstName',
    C.LastName AS 'CamperLastName',
    C.Age,
    C.YearsAtCamp,
    CAB.CabinID,
    CAB.CabinName,
    CAB.MaxCapacity AS CabinMaxCapacity
FROM Camper C INNER JOIN CamperEmergencyContact CEC 
ON C.CamperID = CEC.CamperID INNER JOIN EmergencyContact EC 
ON CEC.EmergencyContactID = EC.EmergencyContactID INNER JOIN Cabin CAB 
ON C.CabinID = CAB.CabinID;

SELECT *
FROM CamperInfo


-- This doesnt work i think one of the joins has to be with CamperActivty many to many table
-- Assuming a 'Councilor' table exists with columns like 'CouncilorID', 'FirstName', 'LastName', and 'CabinID'.
--Idk if i have 1 extra join here but this runs
CREATE VIEW ActivityScheduler AS
SELECT A.ActivityName, C.FirstName
FROM Activity A LEFT JOIN Councilor C
ON A.CouncilorID = C.CouncilorID
GROUP BY A.ActivityName, C.FirstName

SELECT *
FROM ActivityScheduler

SELECT * 
FROM Councilor


CREATE VIEW CabinDetails AS
SELECT 
    CAB.CabinID,
    CAB.CabinName,
    CAB.MaxCapacity,
    CO.CouncilorID,
    CONCAT(CO.FirstName, ' ', CO.LastName) AS 'Councilor Name',
    C.CamperID,
    CONCAT(C.FirstName, ' ', C.LastName) AS 'Camper Name'
FROM Cabin CAB INNER JOIN Councilor CO 
ON CAB.CabinID = CO.CabinID LEFT JOIN Camper C 
ON CAB.CabinID = C.CabinID;



SELECT AllergyName 
FROM Allergy
WHERE AllergyID IN
	(
	SELECT AllergyID
	FROM CamperAllergy
	GROUP BY CamperID, AllergyID
	HAVING CamperID = 1
	)
