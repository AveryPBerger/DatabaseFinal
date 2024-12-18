USE BlueWood;

-- Procedure 1
--Paycheck Procedure
DROP Trigger AfterPaycheckUpdate

CREATE PROCEDURE CalculateTotalPay
    @CouncilorID INT,
    @HoursWorked DECIMAL(4,2),
    @TotalPay DECIMAL(10,2) OUTPUT
AS
BEGIN

    SET @TotalPay = @HoursWorked * 15.75;

	RETURN @TotalPay
END;

-- Trigger 1
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

    SELECT 
        @CouncilorID = CouncilorID,
        @HoursWorked = HoursWorked
    FROM inserted;

    EXEC @TotalPay = CalculateTotalPay @CouncilorID, @HoursWorked, @TotalPay OUTPUT;

	UPDATE Paycheck
    SET TotalPay = @TotalPay
    WHERE CouncilorID = @CouncilorID;

END;

-- Procedure 2
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

-- Trigger 2
CREATE TRIGGER AfterCamperDelete_CascadeActivity
ON Camper
AFTER DELETE
AS
BEGIN
    DECLARE @CamperID INT;

    SELECT @CamperID = CamperID
    FROM deleted;

    DELETE FROM CamperActivity
    WHERE CamperID = @CamperID;

END;
