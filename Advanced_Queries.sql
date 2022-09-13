/#VIEW must be implemented to help answer the following business question:
  In each office - what is the rating of the employees in terms of sales performance,
  and what is the best-selling product by each employee?

drop view theBestEmployees
create view theBestEmployees as
select e.EmployeeID,e.Office,o.OrderID,full_name=e.FirstName+' '+e.LastName,d.ProductID,
NetAmount =(1 - D.Discount )* D.UnitPrice * D.Quantity 
from EMPLOYEES as e join Orders as o on e.EmployeeID=o.EmployeeID
join Details as d on d.OrderID=o.OrderID

SELECT V.Office, V.EmployeeID, V.full_name, 
	Sold_Products = COUNT (DISTINCT V.ProductID),
	Total_Amount = Round (SUM (V.NetAmount), 2) , 
	Rank = 1 + (    
			SELECT COUNT (*) 
			FROM (
				SELECT 	VV.EmployeeID
				FROM    	theBestEmployees as VV
				WHERE		VV.Office = V.Office
				GROUP BY	VV.EmployeeID
				HAVING 	SUM (VV.NetAmount) > SUM (V.NetAmount)
				) AS X				
			) 
FROM   theBestEmployees as V
GROUP BY Office, EmployeeID, full_name
ORDER BY Office, Rank


/#A scalar function must be implemented that receives as a parameter a product ID
  and returns the last date it was sold

create function 
last_date ( @input_pruductID int)
returns date
as begin
declare @output_date date

select @output_date=max(o.OrderDate)
from Details as d join Orders as o on o.OrderID=d.OrderID
where d.ProductID=@input_pruductID

return @output_date end

select p.ProductID, [last_date]=dbo.last_date(p.ProductID)
from Products as p



/#A tabular function must be implemented that accepts as parameters an employee ID and a date range
 and returns a sales report for that employee

create function selers (@employeesId int,@date_start date,@date_end date)
returns table
as return 
	select e.EmployeeID,e.FirstName,
		o.OrderID,o.OrderDate,o.CustomerID, c.CompanyName,o.ShipperID,
		o.Freight, numOflist=count(o.OrderID), SUMOflist=sum(d.UnitPrice)
	from
		EMPLOYEES as e join Orders as o on e.EmployeeID=o.EmployeeID
		join Customers as c on c.CustomerID = o.CustomerID
		join Details as d on d.OrderID=o.OrderID
	where o.OrderDate between @date_start and @date_end and e.EmployeeID=@employeesId
	group by e.EmployeeID, o.OrderID,o.OrderDate,o.CustomerID,c.CompanyName,o.OrderID,
		o.Freight,e.FirstName,o.ShipperID
	

select *
from  dbo.selers (2,'7/1/2006','12/31/2006')




/#A Trigger must be implemented in the DETAILS table that updates the total order amount when the order items are updated
• With the help of an appropriate ALTER TABLE command, a column named Total of type Money must be added to the order table
• The total amount: the amount charged for the product items included in the order, minus the discount, plus the shipping fee

alter table orders add total money

create trigger total_money_order 
on orders
for update,insert,delete
as 
update orders
set total= orders.Freight+ (
	select sum((1-d.Discount)*d.UnitPrice*d.Quantity)
	from details as d 
	where Orders.OrderID= d.orderId
)
where OrderID in (
	select distinct OrderID from inserted
	union 
	select distinct OrderID from deleted
	)

DELETE FROM ORDERS WHERE OrderID = 123456
INSERT INTO ORDERS (OrderID, OrderDate, CustomerID, EmployeeID, ShipperID, Freight) Values (123456, '1/1/2020', 1, 1, 1, 80)

SELECT * FROM ORDERS WHERE OrderID = 123456

DELETE FROM DETAILS WHERE OrderID = 123456 
INSERT INTO DETAILS (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (123456, 1, 10, 3, 0.05), (123456, 2, 20, 2, 0.10)

SELECT * FROM ORDERS WHERE OrderID = 123456
