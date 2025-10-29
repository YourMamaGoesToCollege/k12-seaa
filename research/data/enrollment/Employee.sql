CREATE TABLE [Enrollment].[Employee]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(), 
    [ApplicantId] UNIQUEIDENTIFIER NOT NULL, 
    [EmployeeTypeId] INT NOT NULL, 
    [ValidatedStatusId] INT NULL, 
    [FirstName] VARCHAR(50) NOT NULL, 
    [LastName] VARCHAR(50) NOT NULL, 
    [BirthDate] DATE NULL, 
    [DateCreated] DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    [DateDeleted] DATETIMEOFFSET NULL, 
    CONSTRAINT [FK_Employee_EmployeeType] FOREIGN KEY ([EmployeeTypeId]) REFERENCES [Enrollment].[EmployeeType]([Id]), 
    CONSTRAINT [FK_Employee_EmployeeValidatedStatus] FOREIGN KEY ([ValidatedStatusId]) REFERENCES [Enrollment].[EmployeeValidatedStatus]([Id]), 
    CONSTRAINT [FK_Employee_Applicant] FOREIGN KEY ([ApplicantId]) REFERENCES [Enrollment].[Applicant]([Id])
)
