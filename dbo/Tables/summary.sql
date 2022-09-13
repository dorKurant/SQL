CREATE TABLE [dbo].[summary] (
    [Year]         INT          NOT NULL,
    [Country]      VARCHAR (20) NOT NULL,
    [Office]       INT          NOT NULL,
    [Category]     INT          NOT NULL,
    [Total_Orders] INT          NULL,
    [Total_Amount] MONEY        NULL,
    PRIMARY KEY CLUSTERED ([Year] ASC, [Country] ASC, [Office] ASC, [Category] ASC)
);

