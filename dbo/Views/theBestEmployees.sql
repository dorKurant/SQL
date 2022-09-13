create view theBestEmployees as
select e.EmployeeID,e.Office,o.OrderID,full_name=e.FirstName+' '+e.LastName,d.ProductID,
NetAmount =(1 - D.Discount )* D.UnitPrice * D.Quantity 
from EMPLOYEES as e join Orders as o on e.EmployeeID=o.EmployeeID
join Details as d on d.OrderID=o.OrderID