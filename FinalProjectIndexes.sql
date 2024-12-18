USE BlueWood;

-- Clear buffers
Set statistics Time, IO on
DBCC FreeProcCache 
DBCC DropCleanBuffers;

-- Insert millions of data
INSERT INTO Camper (FirstName, LastName, Age, YearsAtCamp, CabinID)
SELECT FirstName, LastName, Age, YearsAtCamp, CabinID FROM Camper;

SELECT TOP 1 CamperID FROM Camper ORDER BY CamperID DESC;
-- Include number of logical reads, time, use of indexes, and number of rows read. 

-- Query 1
-- Finds all campers that registered before a specific date
SELECT FirstName, LastName, YearsAtCamp
FROM Camper
WHERE YearsAtCamp > 1
ORDER BY YearsAtCamp;

CREATE NONCLUSTERED INDEX IX_Returning_Campers
ON Camper (YearsAtCamp)
INCLUDE (FirstName, LastName);

-- BEFORE: 
-- Logical Reads: 18172
-- Elapsed time: 20335ms
-- Indexes: 1 CLUSTERED Index
-- 3932160 rows read

-- AFTER:
-- Logical Reads: 9528
-- Elapsed time: 16456ms
-- Indexes: 1 NON-CLUSTERED Index
-- 2686976 rows read


-- Insert millions of Cabins
INSERT INTO Cabin(CabinName, MaxCapacity)
SELECT CabinName, MaxCapacity FROM Cabin;

SELECT TOP 1 CabinID FROM Cabin ORDER BY CabinID DESC;

-- Query 2
-- Find activities that can hold a certain amount of campers
SELECT CabinName, MaxCapacity
FROM Cabin
WHERE MaxCapacity > 10
ORDER BY MaxCapacity DESC;

CREATE NONCLUSTERED INDEX IX_Cabin_Capacity
ON Cabin (MaxCapacity)
INCLUDE (CabinName);

-- BEFORE: 
-- Logical Reads: 16620
-- Elapsed time: 28489ms
-- Indexes: 1 CLUSTERED Index
-- 5242880 rows read

-- AFTER:
-- Logical Reads: 10955
-- Elapsed time: 25236ms
-- Indexes: 1 NON-CLUSTERED Index
-- 3932160 rows read