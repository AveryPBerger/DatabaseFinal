USE BlueWood;

-- Procedures
-- Calculates the salary of the Councilor
CREATE PROCEDURE CalculateCouncilorSalary @hoursWorked DECIMAL(4,2) AS
SELECT @hoursWorked * 15.75 AS 'Councilor Salary'
RETURN;

-- GPT cause i couldnt figure this out, this should be changed
CREATE PROCEDURE CabinMaxCapacity @numOfCouncilors INT AS
BEGIN
    DECLARE @maxCapacity INT;
    
    -- Calculate the maximum capacity based on the number of councilors
    SET @maxCapacity = @numOfCouncilors * 6;
    
    -- Return the calculated maximum capacity
    SELECT @maxCapacity AS 'Maxium Cabin Capacity';

	RETURN @maxCapacity;
END;

-- THE INSTRUCTIONS RUIN ONE OF OUR TRIGGERS, IT HAS TO RUN BEFORE DELETE
-- Triggers
-- When Camper is inserted its ID is added to the cabin 


CREATE TRIGGER CheckOvertimeAndCalculateSalary
ON Paycheck
AFTER INSERT, UPDATE
AS
BEGIN
    -- Declare variables for hoursWorked and CouncilorID
    DECLARE @HoursWorked DECIMAL(4, 2), @CouncilorID INT, @Salary DECIMAL(4, 2);
    
    -- Get the hoursWorked and CouncilorID from the inserted/updated row
    SELECT @HoursWorked = HoursWorked, @CouncilorID = CouncilorID FROM INSERTED;

    -- Check if hoursWorked exceeds 40
    IF @HoursWorked > 40
    BEGIN
        -- Calculate salary with 1.5x multiplier
        EXEC CalculateCouncilorSalary @HoursWorked;

		--IDK what to do from here
    END
END;
