CREATE TABLE [Enrollment].[EmployeeSubServiceType]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [EmployeeTypeId] INT NOT NULL, 
    [Name] VARCHAR(100) NOT NULL,
    [Description] VARCHAR(500) NULL, 
    CONSTRAINT [FK_EmployeeSubServiceTypes_EmployeeType] FOREIGN KEY ([EmployeeTypeId]) REFERENCES [Enrollment].[EmployeeType]([Id])
)
