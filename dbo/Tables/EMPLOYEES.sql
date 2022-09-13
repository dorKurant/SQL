CREATE TABLE [dbo].[EMPLOYEES] (
    [EmployeeID] INT          NOT NULL,
    [LastName]   VARCHAR (20) NOT NULL,
    [FirstName]  VARCHAR (20) NOT NULL,
    [Title]      VARCHAR (30) NOT NULL,
    [HireDate]   DATE         NOT NULL,
    [Office]     INT          NOT NULL,
    [Extension]  INT          NULL,
    [ReportsTo]  INT          NULL,
    [YearSalary] MONEY        NOT NULL,
    CONSTRAINT [pk_Employee] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [check_office] CHECK ([YearSalary]>(0)),
    CONSTRAINT [check_YearSalary] CHECK ([office]>(0)),
    CONSTRAINT [fk_employee] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[EMPLOYEES] ([EmployeeID]),
    CONSTRAINT [fk_employeesOffices] FOREIGN KEY ([Office]) REFERENCES [dbo].[offices] ([officesID])
);

