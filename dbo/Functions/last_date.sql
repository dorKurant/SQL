create function 
last_date ( @input_pruductID int)
returns date
as begin
declare @output_date date

select @output_date=max(o.OrderDate)
from Details as d join Orders as o on o.OrderID=d.OrderID
where d.ProductID=@input_pruductID

return @output_date end