--CREATING DATABASE
CREATE DATABASE RISEJULY
USE RISEJULY

ALTER DATABASE RISEJULY
MODIFY NAME = RISEJULY2025

DROP DATABASE RISEJULY2025
-- Creating a Table

Create Table Employee
(EID INT,
Ename varchar(255),
Eage INT,
Salary Money)

Select * from Employee
-- Insert method 1
Insert into Employee values
(101,'Suresh',20,2000)

-- Insert method 2
Insert into Employee (EID,Ename,Eage) 
values(102,'Ramesh',22)
--Insert method 3
Insert Employee values
(103,'Naresh',22,23000),
(104,'Jayesh',23,24000),
(105, 'Kamlesh',24,23000)

--Update method1
Update Employee 
Set Salary = 25000
Where EID = 105
-- Update method 2
Update Employee
SET Salary = 20000
Where Salary IS NULL
-- Update Method 3
Update Employee
SET Salary = 25000
-- Alter method
Alter Table Employee
Add EmailID varchar(255)

Alter Table Employee
Drop Column EmailID

ALter Table Employee
Alter Column EID INT
Insert into Employee 
Values (107,'Mahesh',25,24000)
-- Rename a Table name - sp_rename 'Old TN', 'New TN'
Sp_rename 'Employee', 'EMP'

--sp_rename 'TN.CN', 'CN'
sp_Rename 'EMP.Salary', 'Esalary'
Select * from EMP

-- Delete Method 1
Delete from EMP
where Esalary = 25000
-- Delete Method 2
Delete From EMP
Where ESalary is NULL
-- Delete Method 3
Delete From EMP
Select * From EMP

-- Create, alter, Drop DB
-- Create Table, alter, drop
-- Insert, Update, Delete, Alter, sp_rename
Drop table EMP
Select * from Employee
Select ename from Employee where salary = (Select min(Salary) from employee)

--Logical operator - AND, OR NOT
Select * from Employee
Where EID = 103 AND Eage = 22

Create table Sales
(ProductID INT,
ProductName Varchar(255),
Price Money,
Quantity INT,
Region Varchar (255))

Insert into sales values
(101, 'Laptop',40000,2,'Surat'),
(102, 'Mobile', 30000,5, 'Vadodara'),
(103, 'Earbuds', 1000, 10, 'Anand'),
(104, 'Charger',2000, 4, 'Ahmedabad'),
(105, 'Tablet', 5000, 6, 'Surat')

Select * from Sales
Where Region IN ('Anand','Surat')

Select ProductName, price from Sales
Where Price <> 1000

Select ProductName, price, quantity, (Price * Quantity) AS TOTALSALES
from Sales

--SET Operators
-- Union, Union All, Intersect, Except
-- Number of columns must be same in all Tables
-- Order of the column must be same
-- Datatype must be same

Create table Bank_Surat
(BankID INT,
BankName Varchar (20),
Location varchar(20))

Insert into Bank_Surat values
(101,'SBI', 'Atladra'),
(102,'HDFC','Varacha'),
(103, 'BOB', 'Udhana')

Select BankID, BankName from Bank_Vadodara
Union
Select BankID, BankName from Bank_Surat

Select * from Employee
Select Ename, Salary,(Salary +5000)as TotalSalary
from Employee




Select * 
from sales
Where Email IS NULL

--Arithematic operator +,-,*,/,%
--Comparison operator >,<,<=,>=,<>,=
--Special operator - Between, IN, like, IS NULL / IS NOT NULL WHERE Email LIKE '%@gmail.com'
-- Set OperatorSelect ProductName, (Price * Quantity) AS TotalValue
from sales

-- Delete/Drop/Truncate

Select EID, Ename as FirstName from Employee

Select * from Employee

Alter table Employee
Add  Email varchar(255)
Insert into Employee values
(107, 'Jayesh',23,120000,'Jayesh@gmail.com')

Update Employee
Set Email = 'naresh@outlook.com'
Where EID = 103

Select * from Employee
Where Email LIKE '%@gmail.com'

Select * from Employee
Where Ename like '%h'

Select * from Employee
Where Email IS NOT NULL

Select 'Ketan' as FirstName , 'Rathod' as Lastname, 'Ketan' + ' Rathod' as Fullname

Delete from Employee
Where EID =1
Truncate table Employee

-- Identity
Select name
from sys.tables
where type = 'U'

Create table EMP1
(EID INT IDENTITY,
Ename Varchar (255))
DROP TABLE emp1
Insert EMP1 values
('Jayesh')

Set IDENTITY_INSERT EMP1 ON

Select * from EMP1

-- CHECK
Create Table EMP1
(EID INT,
Ename Varchar (255),
Department Varchar (255),
Salary Money)

Drop table EMP1

Insert into EMP1 values
(1,'Suresh','QA',20000),
(2,'Mahesh','QA',22000),
(3,'Jayesh','Cloud',25000),
(4,'Naresh','AI',30000),
(5,'Ramesh','AI',30000),
(6,'Kamesh','FullStack',26000)
INSERT INTO EMP1 VALUES
(7,'Kamesh','GENAI',70000)

SELECT * FROM EMP1
-- Fetch number of employees in each department

-- Aggregate funtions - Count, SUM, MAX, MIN, AVG 
Select Department, COUNT(EID)
From EMP1
Group by Department
-- Fetch MAX SALARY in each department
Select  Department, MAX(SALARY)
From EMP1
Group by Department

Select department,MAX(Salary),MIN(Salary)
from EMP1
Group by department

Select * from EMP1

-- Constraints
-- NOT NULL, UNIQUE, PRIMARY KEY,FOREIGN KEY,CHECK,DEFAULT



1. Find out how many employees are in each department.
2. Calculate the average salary for employees in each department.
3. Find the total quantity sold for each distinct product.
4. Maximum Price of a Product in Each Region
5. Minimum and Maximum Salary per Department
6. Total Sales Value per Region
