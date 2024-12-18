USE BlueWood;


--Paycheck Procedure

DROP Trigger AfterPaycheckUpdate

CREATE PROCEDURE CalculateTotalPay
    @CouncilorID INT,
    @HoursWorked DECIMAL(4,2),
    @TotalPay DECIMAL(10,2) OUTPUT
AS
BEGIN
    -- Calculate the total pay
    SET @TotalPay = @HoursWorked * 15.75;

    -- Optionally, you can include more business logic like taxes, bonuses, etc.
    -- For simplicity, this just calculates the base pay.
	RETURN @TotalPay
END;



--Paycheck Trigger
CREATE TRIGGER AfterPaycheckUpdate
ON Paycheck
AFTER UPDATE
AS
BEGIN
    DECLARE @CouncilorID INT;
    DECLARE @HoursWorked DECIMAL(4,2);
    DECLARE @HourlyRate DECIMAL(4,2);
    DECLARE @TotalPay DECIMAL(10,2);

    -- Get the CouncilorID, HoursWorked, and HourlyRate from the inserted row (new data after the update)
    SELECT 
        @CouncilorID = CouncilorID,
        @HoursWorked = HoursWorked
    FROM inserted;

    -- Call the procedure to calculate total pay
    EXEC @TotalPay = CalculateTotalPay @CouncilorID, @HoursWorked, @TotalPay OUTPUT;

	UPDATE Paycheck
    SET TotalPay = @TotalPay
    WHERE CouncilorID = @CouncilorID;
    -- Optionally, you could update the Paycheck table with the calculated total pay if needed
    -- UPDATE Paycheck
    -- SET TotalPay = @TotalPay
    -- WHERE CounselorID = @CounselorID;
END;


CREATE PROCEDURE GetCabinOccupancy
    @CabinID INT
AS
BEGIN
    DECLARE @Occupancy INT;

    -- Retrieve the current occupancy for the cabin
    SELECT @Occupancy = COUNT(*)
    FROM Camper
    WHERE CabinID = @CabinID;

    -- Return the occupancy count
    RETURN @Occupancy;
END;

CREATE TRIGGER AfterCamperInsert
ON Camper
AFTER INSERT
AS
BEGIN
    DECLARE @CabinID INT;
    DECLARE @Occupancy INT;
	DECLARE @MaxCapacity INT;
	DECLARE @NewCabinID INT;
	DECLARE @CamperID INT;
    -- Get the CabinID of the newly inserted camper

	SELECT 
    @CamperID = CamperID,
    @CabinID = CabinID
    FROM inserted;

	  SELECT 
        @MaxCapacity = MaxCapacity
    FROM Cabin
    WHERE CabinID = @CabinID;

    -- Call the procedure to get the updated occupancy and capture the return value
    EXEC @Occupancy = GetCabinOccupancy @CabinID;

	SELECT TOP 1 @NewCabinID = CabinID
    FROM Cabin
    WHERE MaxCapacity > (SELECT COUNT(*) FROM Camper WHERE CabinID = Cabin.CabinID)

    IF @Occupancy > @MaxCapacity
	BEGIN
		UPDATE Camper
        SET CabinID = @NewCabinID
        WHERE CamperID = @CamperID;
	END
END;

