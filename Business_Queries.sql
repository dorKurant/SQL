/#Which products are priced per product unit twice or more than the average price?
SELECT	ProductID, ProductName, UnitPrice, 
		[Average Price] = Round ((
			SELECT AVG (UnitPrice) FROM PRODUCTS
		), 2)
FROM		PRODUCTS 
WHERE		UnitPrice >= 2 * (
			SELECT AVG (UnitPrice) FROM PRODUCTS
		)
ORDER BY UnitPrice DESC


/#For each product - what is the statistical standard score of its inventory value in relation to all products?
select p.ProductID, p.ProductName, prudactbalue=p.UnitsInStock*p.UnitPrice, 
grade=round((p.UnitsInStock*p.UnitPrice-(select AVG(pp.UnitsInStock*pp.UnitPrice) from  Products as pp))/
(select StDev (ppp.UnitsInStock*ppp.UnitPrice) from  Products as ppp),2)
from Products as p
order by grade desc


/#In each office - what is the relative rate of all relative salaries paid to each job type (Title) in relation to the total annual salary paid by that office.
select e.Office,e.Title,[sumYearByOffice]=sum(e.YearSalary), shior=sum(e.YearSalary)/(
		select sum(ee.yearsalary)
		from EMPLOYEES as ee
		where ee.Office=e.Office)
from EMPLOYEES as e  
group by e.Title ,e.Office


/#Every month in 2008 - how many orders were made and in what total amount, for products that arrive from suppliers that offer 3 or more products
select p.Supplier,p.ProductID,p.ProductName,month= month(o.orderDate), total=count(distinct o.OrderID), Total_Amount = SUM (D.Quantity * D.UnitPrice)
from Orders as o join Details as d on o.OrderID=d.OrderID join Products as p on p.ProductID=d.ProductID
where year( o.OrderDate) = 2008 and o.ShipperID in (
	select Pp.Supplier
	from Products as pp
	group by pp.Supplier
	having count(*)>=3)
group by month (o.OrderDate), p.Supplier,p.ProductID,p.ProductName


/#For each customer - in which orders did the difference between the shipping fee (Freight) that the customer paid for that order,
/#and the average shipping fee that the same customer paid for all the orders he placed exceeded 20
select c.CustomerID, o.OrderID, o.OrderDate, o.Freight,memotha=(
	select avg(Freight)
	from Orders
	where CustomerID=c.CustomerID
	),
	pahar =o.Freight -(
	select avg(Freight)
	from Orders
	where CustomerID=c.CustomerID
	)
from Customers as c join Orders as o on c.CustomerID=o.CustomerID
where o.Freight -(
	select avg(Freight)
	from Orders
	where CustomerID=c.CustomerID
	)>20
group by c.CustomerID, o.OrderID, o.OrderDate, o.Freight


/#A nested data update query, the products must be categorized
alter table products add [status] varchar(40)
update Products set [status]=case
when (
select COUNT(*)
from Details as d 
where d.ProductID=Products.ProductID
) > 40 then 'popular'
when(
select COUNT(*)
from Details as d 
where d.ProductID=Products.ProductID
) < 10 then 'weak'
else 'regular' end

select ProductID,ProductName,[status]
from Products
Order by ProductID
