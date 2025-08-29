--4. Find average order amount and count of order

Create Proc spGetAverageAmountWithCount
@averageamount INT output,
@Ordercount INT output
As
Begin
	Select @averageamount=AVG(Totalamount),
	@Ordercount=count(OrderID) from orders
End

Declare @Average INT,
        @Order INT
Exec spGetAverageAmountWithCount
	 @averageamount   = @Average Output,
     @Ordercount   =  @Order Output

Select @Average as Averagerevenue,
		@Order as TotalCount
	
--3. Get Customer and latest Order Information

Create Procedure spCustomerOrderdetails
@CustomerID INT,
@Customername varchar(20) Output,
@orderID INT Output,
@Totalamount INT Output
As
Begin
	Select Top 1
	@Customername  =c.Customername,
	@latestorderID = o.orderID,
	@Totalamount = o.Totalamount
	from customer c
	join orders o
	on c.CustomerID = o.CustomerID
	Where c.CustomerID = @CustomerID
	Order by o.orderdate desc
End

Declare @Custname Varchar(255),
        @latestoID INT,
		@Totalamt INT,

Exec spCustomerOrderdetails
	  @CustomerID = 1 ,
	  @Customername  = @Custname Out,
       @latestorderID = @latestoID Out,
		@Totalamount = @Totalamt Out
Select
	@Custname as CustomerName,
	@latestoID as LastestID,
	@Totalamt as Totalamount
	
--2. Calculate Total Spending for a City
Create Procedure TotalSpendingbyCity
@city varchar(255)
@TotalRevenue Decimal(10,2) Output
As
Begin
	Select @TotalRevenue = sum(o.Totalamount) from customer c
	join orders o on
	c.CustomerID = o.CustomerID
	Where c.city = @City

End

Declare @Citywise INT
Exec TotalSpendingbyCity 
		@City = 'vadodara'
		 @Totalrevenue = @Citywise output
Select @Citywise as total

-- Triggers
Select * from emp1
Create trigger tr_tblEmployee_ForUpdate
on EMP1
for Update
as
Begin
 Select * from deleted --old value/deleted value
 Select * from inserted --hold the updated/new value
End
Update EMP1
Set salary = 50000

-- Trigger example
-- Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Create EmployeeAudit table
CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY,
    EmpID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Trigger to log salary changes
CREATE TRIGGER trg_AuditSalaryChange
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmpID, OldSalary, NewSalary)
    SELECT 
        d.EmpID, 
        d.Salary AS OldSalary, 
        i.Salary AS NewSalary
    FROM deleted d
    INNER JOIN inserted i ON d.EmpID = i.EmpID
    WHERE d.Salary <> i.Salary;
END;


-- Trigger for delete
ALter TRIGGER tr_tblEmployee_ForDelete
ON tblEmployee
for DELETE
AS
BEGIN
    SELECT * FROM deleted;
    
    INSERT INTO EmployeeAudit (EmpID, OldSalary, ChangeDate)
    SELECT EmpID, Salary, GETDATE()
    FROM deleted;
END;

-- Trigger for INSERT
CREATE TRIGGER tr_tblEmployee_ForInsert
ON tblEmployee
FOR INSERT
AS
BEGIN
    PRINT 'A new employee has been added';
    SELECT * FROM inserted;   
END;

--Trigger for UPDATE
CREATE TRIGGER tr_tblEmployee_ForUpdate
ON tblEmployee
FOR UPDATE
AS
BEGIN
    PRINT 'Employee details updated!';
    SELECT * FROM deleted;  
    SELECT * FROM inserted; 
END;

--Trigger for DELETE
CREATE TRIGGER tr_tblEmployee_ForDelete
ON tblEmployee
FOR DELETE
AS
BEGIN
    PRINT 'An employee has been deleted!';
    SELECT * FROM deleted;   
END;

-- Prevent Negative Salary
CREATE TRIGGER tr_PreventNegativeSalary
ON tblEmployee
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Salary < 0)
    BEGIN
        ROLLBACK TRANSACTION;   
        PRINT 'You are not allowed to enter Negative amount';
    END
END;

--Auto Update "LastModified" Column

-- First add a column to track modification
ALTER TABLE tblEmployee ADD LastModified DATE;

CREATE TRIGGER tr_UpdateLastModified
ON tblEmployee
FOR UPDATE
AS
BEGIN
    UPDATE tblEmployee
    SET LastModified = GETDATE()
    WHERE EmpID IN (SELECT EmpID FROM inserted);
END;

Drop trigger ______
enable trigger ____ on tablename

-- INSTEAD OF Trigger

CREATE TRIGGER tr_InsteadOfUpdateSalary
ON tblEmployee
INSTEAD OF UPDATE
AS
BEGIN
    -- Block salary decrease
    IF EXISTS (SELECT 1 FROM inserted i
        JOIN deleted d ON i.EmpID = d.EmpID
        WHERE i.Salary < d.Salary
    )
    BEGIN
        RAISERROR('Error: Salary cannot be reduced!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Allow normal update
        UPDATE tblEmployee
        SET Name = i.Name,
            Salary = i.Salary
        FROM inserted i
        WHERE tblEmployee.EmpID = i.EmpID;
    END
END;

--Realtime example
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
Select * from Department
Insert into department values(10,'IT'),(11,'HR')
CREATE TABLE Employee1 (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT FOREIGN KEY REFERENCES Department(DeptID)
);
Insert into Employee1 values(1,'Suresh',10)

--Create a View that joins them
CREATE VIEW vwEmployeeDept
AS
SELECT e.EmpID, e.Name, d.DeptName
FROM Employee1 e
JOIN Department d ON e.DeptID = d.DeptID;

Select * from vwEmployeeDept
Update vwEmployeeDept
Set DeptName = 'HR'
Where EmpID = 1

Select * from employee1

CREATE TRIGGER tr_InsteadOfInsertOnView
ON vwEmployeeDept
INSTEAD OF INSERT
AS
BEGIN
    -- Insert new employees into Employee table
    INSERT INTO Employee1 (EmpID, Name, DeptID)
    SELECT i.EmpID, i.Name, d.DeptID
    FROM inserted i
    JOIN Department d ON i.DeptName = d.DeptName;
END;

-- INSTEAD OF DELETE Trigger
CREATE TRIGGER tr_InsteadOfDeleteOnView
ON vwEmployeeDept
INSTEAD OF DELETE
AS
BEGIN
    DELETE e
    FROM Employee e
    JOIN deleted d ON e.EmpID = d.EmpID;
END;

-- Trigger for Create & Drop

Create Trigger tr_blockToCreateNewTable
ON Database
For Create_Table
As
Begin
	Print 'You are not allowed to create new table on this Database'
	ROLLBACK TRANSACTION;
END

Create table Cloud
(EID INT,
Name Varchar(255))

Create Trigger tr_blockToDropTable
ON Database
For Drop_Table
As
Begin
	Print 'You are not allowed to Drop a table on this Database'
	ROLLBACK TRANSACTION;
END

Drop Table EMP1

Create Trigger tr_blockToCreateNewTableANDDropTable
ON ALL SERVER
For Create_Table, Drop_Table
As
Begin
	Print 'You are not allowed to create new table or delete on this SERVER'
	ROLLBACK TRANSACTION;
END

Drop trigger tr_blockToCreateNewTable on database

Disable Trigger tr_blockToDropTable on Database
Enable Trigger tr_blockToDropTable on Database

Disable Trigger tr_blockToDropTable on ALL SERVER
Enable Trigger tr_blockToDropTable on ALL SERVER
