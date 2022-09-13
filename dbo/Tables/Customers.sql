CREATE TABLE [dbo].[Customers] (
    [CustomerID]  INT           NOT NULL,
    [CompanyName] VARCHAR (50)  NOT NULL,
    [ContactName] VARCHAR (50)  NOT NULL,
    [Address]     VARCHAR (100) NOT NULL,
    [City]        VARCHAR (50)  NOT NULL,
    [PostalCode]  VARCHAR (20)  NOT NULL,
    [Country]     VARCHAR (20)  NOT NULL,
    [Phone]       VARCHAR (20)  NOT NULL,
    [fax]         VARCHAR (20)  NULL,
    CONSTRAINT [pk_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC),
    CONSTRAINT [fk_customersCitys] FOREIGN KEY ([City]) REFERENCES [dbo].[citys] ([citysID])
);

