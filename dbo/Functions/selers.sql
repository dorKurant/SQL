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