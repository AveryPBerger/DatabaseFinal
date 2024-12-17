USE BlueWood;

--We need a way to insert millions of rows
Set statistics Time, IO on
DBCC FreeProcCache 
DBCC DropCleanBuffers;

-- Query 1
-- Finds all campers that registered before a specific date
SELECT CamperID, FirstName, LastName, YearsAtCamp
FROM Camper
WHERE YearsAtCamp < 5;

CREATE NONCLUSTERED INDEX IX_Returning_Campers
ON Camper (YearsAtCamp)
INCLUDE (CamperID, FirstName, LastName);

-- Query 2
-- Find activities that can hold a certain amount of campers
SELECT ActivityName, MaxCapacity
FROM Activity
WHERE MaxCapacity >= 20;

CREATE NONCLUSTERED INDEX IX_Activity_Capacity
ON Activity (MaxCapacity)
INCLUDE (ActivityName);
