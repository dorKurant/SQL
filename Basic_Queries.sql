/#In which cities are there more than two customers (companies) whose names appear with the letter E?
select c.City,number_of_cumpany=count(*), number_of_mikods=count (distinct c.PostalCode) 
from Customers as c
where c.CompanyName like '%e%' 
group by c.City
having COUNT (*) >1
order by  number_of_cumpany desc


/#For which employees the difference between the salary they earn and the salary their manager earns is less than 4000
select e.EmployeeID,Employee_name=e.FirstName+' '+e.LastName,Employee_salary= e.YearSalary,manager_id=m.EmployeeID,manager_name=m.FirstName+' '+m.LastName, manager_salary=m.YearSalary, gap=m.YearSalary-e.YearSalary
from EMPLOYEES as E join EMPLOYEES as m on e.ReportsTo=m.EmployeeID
where m.YearSalary-e.YearSalary<4000
order by gap asc


/#Which customers (companies) who have a fax machine ordered more than 3 orders in the first quarter of 2007?
select c.CustomerID,c.CompanyName,c.Country,number_of_order=count(*), price_for_orders=sum (o.Freight)
from Customers as c join Orders as o on c.CustomerID=o.CustomerID
where c.fax is not null and YEAR (O.OrderDate) = 2007 AND Month (O.OrderDate) IN (1, 2, 3)
group by c.customerID,c.CompanyName,c.Country
having count(*)>3
order by number_of_order desc


/#What are the 5 products, for which the number of units in stock is less than the number of units ordered, whose total order amount is the highest?
select top 5 p.ProductID, p.ProductName, gap=p.UnitsOnOrder-p.UnitsInStock, Orders_Made = COUNT (Distinct D.OrderID),Total_Amount = SUM (D.UnitPrice * D.Quantity)
from Products as p join Details as d on p.ProductID=d.ProductID 
where p.UnitsInStock<p.UnitsOnOrder
group by p.ProductID, p.ProductName,P.UnitsInStock,P.UnitsOnOrder
order by Total_Amount desc


/#For each employee employed as a salesperson - for which customers (companies) located in Germany has he never made an order?
select e.EmployeeID, full_name=e.FirstName+' '+e.LastName, e.Title, c.CustomerID,c.CompanyName
from Customers as c cross join EMPLOYEES as e
where c.Country='Germany' and e.Title ='Sales Representative'
except
select e.EmployeeID, full_name=e.FirstName+' '+e.LastName, e.Title, c.CustomerID,c.CompanyName
from EMPLOYEES as e join Orders as o on e.EmployeeID=o.EmployeeID join Customers as c on c.CustomerID=o.CustomerID
where e.Title ='Sales Representative' and c.Country='Germany'



