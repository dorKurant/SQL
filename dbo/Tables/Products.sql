CREATE TABLE [dbo].[Products] (
    [ProductID]       INT          NOT NULL,
    [ProductName]     VARCHAR (50) NOT NULL,
    [Supplier]        INT          NOT NULL,
    [Category]        INT          NOT NULL,
    [QuantityPerUnit] INT          NULL,
    [UnitPrice]       MONEY        NOT NULL,
    [UnitsInStock]    INT          NULL,
    [UnitsOnOrder]    INT          NULL,
    [status]          VARCHAR (40) NULL,
    CONSTRAINT [pk_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [ck_price] CHECK ([UnitPrice]>(0)),
    CONSTRAINT [ck_quantity] CHECK ([QuantityPerUnit]>(0)),
    CONSTRAINT [ck_units] CHECK ([UnitsInStock]>=(0)),
    CONSTRAINT [ck_unitsOnOrder] CHECK ([UnitsOnOrder]>=(0)),
    CONSTRAINT [fk_productsCategorys] FOREIGN KEY ([Category]) REFERENCES [dbo].[categorys] ([categorysID])
);

