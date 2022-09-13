CREATE TABLE [dbo].[Orders] (
    [OrderID]    INT   NOT NULL,
    [OrderDate]  DATE  NOT NULL,
    [CustomerID] INT   NOT NULL,
    [EmployeeID] INT   NOT NULL,
    [ShipperID]  INT   NOT NULL,
    [Freight]    MONEY NOT NULL,
    [total]      MONEY NULL,
    CONSTRAINT [pk_orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [ck_freight] CHECK ([Freight]>(0)),
    FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[EMPLOYEES] ([EmployeeID]),
    CONSTRAINT [fk_orderShipper] FOREIGN KEY ([ShipperID]) REFERENCES [dbo].[shippers] ([shipperID])
);


GO
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