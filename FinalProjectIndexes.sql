USE BlueWood;


SELECT * FROM Camper

SELECT CONCAT (FirstName,' ',LastName) 'Camper Name', 
	(
	SELECT CabinName
	FROM Cabin
	WHERE Cabin.CabinID = Camper.CabinID
	) 'CabinName'
FROM Camper
ORDER BY CabinID ASC


SELECT FirstName,CabinID
FROM Camper

SELECT CONCAT(C.FirstName,' ',C.LastName) 'Name', A.AllergyName
FROM Camper C LEFT JOIN Allergy A
ON C.CamperID = A.CamperID
