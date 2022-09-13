CREATE TABLE [dbo].[DETAILS] (
    [OrderID]   INT   NOT NULL,
    [ProductID] INT   NOT NULL,
    [UnitPrice] MONEY NULL,
    [Quantity]  INT   NULL,
    [Discount]  REAL  NULL,
    CONSTRAINT [pk_Details] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [fk_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [fk_Prodcuct] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);

