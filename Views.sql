USE BlueWood;

--LIST OF VIEWS 
--CamperInfo
--ActivityScheduler
--CabinDetails



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


CREATE VIEW ActivityScheduler AS

SELECT A.ActivityName, C.FirstName
FROM Activity A LEFT JOIN Councilor C
ON A.CouncilorID = C.CouncilorID
GROUP BY A.ActivityName, C.FirstName

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
