USE BlueWood;


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


CREATE TRIGGER AfterCamperDelete_CascadeActivity
ON Camper
AFTER DELETE
AS
BEGIN
    -- Declare a variable to store the deleted CamperID
    DECLARE @CamperID INT;

    -- Select the CamperID of the deleted camper from the "deleted" table
    SELECT @CamperID = CamperID
    FROM deleted;

    -- Delete the activities associated with the deleted camper from CamperActivity table
    DELETE FROM CamperActivity
    WHERE CamperID = @CamperID;

    -- Optionally, log the deletion of activities (if required for auditing)
    -- INSERT INTO ActivityLog (CamperID, Action, Date)
    -- VALUES (@CamperID, 'Deleted Camper Activities', GETDATE());
END;


