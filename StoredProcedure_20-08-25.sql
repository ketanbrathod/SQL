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

