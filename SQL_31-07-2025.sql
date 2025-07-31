--CREATING DATABASE
--Create DB <Name>

CREATE DATABASE RISEJULY
USE RISEJULY

ALTER DATABASE RISEJULY
MODIFY NAME = RISEJULY2025
-- Drop DB <Name>

DROP DATABASE RISEJULY2025
-- Creating a Table

-- Create table <Name>
( Col1 datatype,
Col2 datatype,
col3 datatype)

Create table EMP2
(EID INT, 
Ename varchar(255),
DOJ Datetime Default Getdate())
Select * from EMP2

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
-- Update EMP2
SET Salary = 25000
Where EID = 105

Update Employee 
Set Salary = 25000
Where EID IN (105,106)
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
--
--sp_rename 'TN.CN', 'CN'
sp_Rename 'EMP.Salary', 'Esalary'
Select * from EMP

-- Delete Method 1
Delete from EMP
where EID IN (2,3)
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
Where Department = 'IT' OR Eage = 22

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

Select ProductName, price, quantity, (Price * Quantity) AS TOTAL_SALES
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

--Identity (1

Set IDENTITY_INSERT EMP1 ON

Select * from EMP1

-- CHECK
Create Table EMP1
(EID INT NOT NULL ,UNIQUE,
Ename Varchar (255),
Department Varchar (255),
Salary Money NOT NULL)

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

Select Department, COUNT(*)
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
Select Department, Count(EID)
From EMP1
Group by Department
Having Count(EID) > 1

2. Calculate the average salary for employees in each department.
Select Department, AVG(Salary) AS AverageSalary
From EMP1
Group by Department
Order by AverageSalary DESC

3. Find the total quantity sold for each distinct product.
Select ProductName, SUM(Quantity)
From Sales
Group by ProductName

4. Maximum Price of a Product in Each Region
Select Region, MAX(Price) AS HighestPrice
From Sales
Group by Region
5. Minimum and Maximum Salary per Department
Select Department, MIN(Salary) As Lowest, MAX(Salary) As Highest
From EMP1
Group by Department

6. Total Sales Value per Region

Select Region, SUM(Price * Quantity) AS TotalSales
from Sales
Group by Region
Having SUM(Price * Quantity) > 8000
Order by Region DESC

-- Primary Key & Foreign Key 
-- Primary key is a combination of Unique + Not NULL constraint
--FK - It is used to establish a relationship between Parent & Child table
-- It is used to maintain refrential Integrity of Data
Drop table Department

Create table Department
(DID INT Primary key,
Dname varchar(255),
Location varchar(255))

Insert into Department values
(101, 'AI','SF'),
(102, 'Cloud','SF'),
(103, 'QA','FF')


Create table Emp4
(EID INT,
Ename varchar(255),
Salary money,
DID INT Foreign key references Department (DID) ON update cascade on delete cascade)

Insert into Emp4 values
(1,'Jayesh',32000,'101'),
(2,'Mahesh',30000,'102')

Drop table Department

Delete from Department
Where DID =102

Select * from Department
Select * from Emp4
Update Department
Set DID = 105
Where DID = 101

Create table Test
(EID INT,
Ename varchar(255))
Drop table test
Insert into test values
(3,'Suresh'),
(2,'Mahesh'),
(1,'Jayesh')
Select * from Test
Drop table Customer

Create table Customer
(CustomerID INT Primary Key,
CustomerName varchar(255),
EmailID varchar(255))

Insert into Customer values
(102,'Suresh','Suresh@gmail,com')

Create table Orders
(OrderID INT,
ProductName varchar(255),
CustomerID INT Foreign Key references Customer (CustomerID) 
On update cascade on delete cascade)

Insert into Orders values
(11,'Mobile',101)

Select * from Customer
Select * from Orders
Update Orders
Set CustomerID=101
Where CustomerID = 1011

Delete from Customer
where CustomerID=1011

-- Cascading rule (If you update/delete from Parent table
than automatically the same will ve reflected oin child table)

-- Subquery (Nested Query)
-- Outer query + Inner Query
-- Select * from <table name> = (Select * From <table name>)

--Query to find highest salary without using Subquery
Select Top 1 Ename, Salary from EMP1
Order by Salary desc
-- Using subquery (Outer + Inner)
--Using more than 1 Select statements

-- Syntax
Select  Colname from TN
Where ColName Operator
(Select ColName from TN)
Where ColName Operator
(Select ColName from TN)
-- Fetch Ename getting the Highest salary
MAX, MIN, AVG, SUM, COUNT - Group by or Subquery
Select Ename, Salary from EMP1
Where Salary = 
(Select MAX(Salary) from EMP1)



 -- Method 1
 Select Ename, Salary from EMP1 Where Salary =
 (Select Max(Salary) from EMP1)

 -- Method 2

 Select Ename,Salary
 from EMP1
 Order by Salary DESC
 OFFSET 1 ROW -- SKip 1 row
 Fetch Next 1 Row Only

 -- Query to fetch Second highest salary using Subquery

(Select Ename, Salary from EMP1 where Salary = 
(Select Max(Salary) from Emp1 Where Salary < 
(Select Max(Salary) from EMP1)))

Select Ename, Salary from EMP1 Where Salary=(Select MAX(Salary) from EMP1) OR Salary =(Select MIN(Salary) from EMP1)

-- Method2
Select Ename, Salary from Emp1 Where Salary=(Select Max(Salary) from EMP1)
Union ALL
Select Ename, Salary from Emp1 Where Salary=(Select Min(Salary) from EMP1)

Select * from EMP1

Select Ename, Department from EMP1 Where Department IN 
(Select Department from EMP1 
where Ename IN ('Suresh', 'Ramesh'))
Select * from Sales
Select Ename, Department from EMP1 Where Department IN('QA','AI')

--GROUP by (Assignment 4)
--1. Write a query to find the total number of employees in each department.
Select Department, Count(EID) as total_number_of_employees
From EMP1
Group by Department

2. Write a query to calculate the total sum of salaries paid to employees in each 
department.
Select department, SUM(Salary) as SumOFSalaries
From EMP1
Group by department

3. Write a query to find the average quantity of each product sold across all sales 
transactions.
Select ProductName, AVG(Quantity) as average_quantity
From Sales
Group by ProductName
4. Write a query to determine the highest salary paid within each department.
Select Department, MAX(Salary) as highest_salary
From EMP1
Group by Department

5. Write a query to calculate the total revenue (Quantity * Price) generated from sales 
in each region.
Select region, SUM(Quantity * Price) as total_revenue
From Sales
Group by region

-- Having (Assignment)
1. Write a query to list only those departments that have more than 2 employees.
Select Department, count(EID)
From EMP1
Group by Department
Having count(EID) >1

2. Write a query to find products where the total quantity sold across all transactions is 
less than 5.
Select ProductName, SUM(Quantity)
From Sales
Group by ProductName
Having SUM(Quantity) <5
3. Write a query to identify regions where the average Price of products sold is greater 
than 500.
Select region, AVG(Price)
From Sales
Group by region
Having AVG(Price) > 500

4. Write a query to show departments where the sum of salaries for all employees in 
that department is greater than 50,000.
Select department, SUM(Salary)
From EMP1
Group by department
Having SUM(Salary) > 50000
5. Write a query to list products that have been sold in more than one distinct region.
Select ProductName, Count(Distinct Region) 
From Sales
Group by ProductName
Having Count(Distinct Region) >1

-- Order by (Assignment)
1. Write a query to retrieve all employee details, sorted by their Salary in descending 
order.
Select *
From EMP1
Order by Salary DESC

2. Write a query to list all products, sorted alphabetically by ProductName.
Select ProductID, ProductName
From Sales
Order by ProductName 

3. Write a query to retrieve employee names and salaries, sorted primarily by 
Department in ascending order, and then by Salary in descending order within each 
department.
Select Ename, Department, Salary
From EMP1
Order by Department ASC, Salary DESC 

4. Write a query to list all sales transactions, sorted first by Quantity in descending 
order, and then by Price in ascending order for transactions with the same quantity.
Select *
From Sales
Order by Quantity DESC, Price ASC

5. Write a query to find the top 3 highest-paid employees (Ename and Salary)
Select Top 3 Ename, Salary
From EMP1
Order by Salary DESC

--Subquery
1. Write a query to find the Ename and Salary of all employees who earn more than the 
average salary of all employees.

Select Ename, Salary from EMP1 
Where Salary>
(Select AVG(Salary) From EMP1)

2. Write a query to list all ProductNames that have at least one sale recorded in the 
'Vadodara' region.

Select Distinct ProductName from Sales
Where ProductName IN
(Select ProductName From sales where region = 'Vadodara')

3. Write a query to find the names of departments that have at least one employee 
older than 30 years.
Select dEpartment from Employee
Where Department IN
(Select Ename from Employee Where Eage >22)

4. Write a query to find the Ename, Department, and Salary of employees who earn the 
maximum salary within their respective departments.
Select Ename, Department, Salary from emp1
WHere Salary IN 
(Select Max(Salary) from EMP1 Group by Department)

5. Write a query to retrieve all columns from the Sales table for products that have a 
Price greater than 1000
Select * from Sales
Where Price > 1000

-- JOINS
-- Combining more than 1 table
-- ANSI = ON & NON ANSI = Where (Equi & non-Equi)
-- It must have at least One matching column (Datatype)
Create  Table Course
(CID INT,
Cname Varchar(255),
Cfee INT)
Insert into Course values
(10,'FullStack',10000),
(20,'QA',10000),
(30,'Data Science',15000),
(40,'Data Analytics',10000)

Create Table Student
(SID INT, 
Sname Varchar(255),
Batch varchar(255),
CID INT)
Insert into Student values
(101, 'Suresh', 'July', 10),
(102,'Ramesh','July', 20),
(103,'Mahesh','July',50)

Select * from Course
Select * from Student
-- Left Join (Inner + Left)
Select * From Course C
Inner Join Student S
ON C.CID = S.CoureseID

Where C.CID IS NULL OR
S.CID IS NULL


Where C.CID is NULL OR
Student.CID is NULL 

--Cross Join
Select * from Course Cross join Student
Select * from Sales
Insert into Sales  values
(106,'Monitor',5000,2,'Surat')

--Non-Ansi Equi '='
Select * from Bank_Surat
Select * from Bank_Vadodara
Insert into Bank_Vadodara values
(104,'ICICI','Akota'),
(105,'Axis','Maneja')

Select * from Bank_Surat, Bank_Vadodara
Where Bank_Surat.BankID <> Bank_Vadodara.BankID

-- Natural join
--Not supported in SQL Server

Select * from Course Natural JOIN Student
-- Self Join (A combining a Table with Itself)
-- Fetch employee getting the same salary
Select * from EMP1
Select * from sales
Select e1.eid, e1.ename,e2.Salary From EMP1 e1
Join EMP1 e2
ON e1.Salary = e2.Salary
AND e1.EID <> e2.EID

Select s1.ProductID, s1.ProductName, s2.Price from Sales s1
Join sales s2
on s1.price = s2.price
AND s1.ProductName = s2.ProductName
Select * from sales
-- Fetch Only Employee & their Department Name
Select e.Ename, d.Dname
From Employee e
Join Department d 
ON e.DID = d.DID

-- Fetch ALL Employee & their Department name
Select e.Ename, d.Dname
From Employee e
Left Join Department d 
ON e.DID = d.DID

-- Fetch all Employees working on Project Cloud
Select e.ename, p.pname
From Employee e
Join Project p
ON e.EID = p.EID
Where P.pname = 'Cloud'
-- Fetch Employees & their Manager name
Select e.ename, m.mname
from Employee e
join manager m
on e.MID = m.MID

-- Fetch Employee name, manager name, department 
   name & project they are working on
Select e.ename, m.mname, d.dname, p.pname
from Employee e
Left Join Manager m
on e.MID = m.MID
Join department d
On e.DID = d. DID
Join Project p
On e.EID = p.EID

-- Fetch Employees not working on any Project
Select e.ename, p.pname 
from Employee e
Left join Project p
On e.EID = p.EID
Where P.pname is NULL
-- Employee e (EID, Ename, Salary, DID, MID) 
-- Department d (DID, Dname) 
-- Manager m (MID, Mname) 
-- Project p (PID, Pname, EID)
Select e.ename, d.dname, mname, pname
from Employee e
Join department d
On e.DID = d.DID
JOin Manager m
On m.MID = e.MID
Join Project p
On e.EID = p.EID

-- Find Average age of student enrolled in each courses
Select c.coursename, AVG(s.Age)
from Student s
Join Enrolled e
On s.SID = e.SID
Join Course C
On s.CID = c.CID
Group by c.coursename

-- SQL assessment(Query based) on 1st August & 8th August
-- Assessment syllabus - Upto Joins

-- Views
Select * from Student
Select * from Course
-- Views are just tempory result of an output query
ALter View StudentWithCourse 
AS
Select s.sname, c.cname
from Student s
Join Course c
On s.CID= c. CID

Update StudentWithCourse
Set cname = 'Cloud'
Where sname = 'Jayesh'

Select * from StudentWithCourse

Drop view StudentWithCourse



