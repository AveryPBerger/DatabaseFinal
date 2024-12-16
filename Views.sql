CREATE VIEW CamperInfo AS


SELECT C.*
FROM Camper C LEFT JOIN CamperEmergencyContact CEC
ON C.CamperID = CEC.CamperID