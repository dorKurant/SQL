select c.City,number_of_cumpany=count(*), number_of_mikods=count (distinct c.PostalCode) 
from Customers as c
where c.CompanyName like '%e%' 
group by c.City
having COUNT (*) >1
order by  number_of_cumpany desc
