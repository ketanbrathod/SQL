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
