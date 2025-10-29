CREATE TABLE [Enrollment].[EmployeeTherapy]
(
    [EmployeeId] UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    [LicenseNumber] VARCHAR(50) NOT NULL, 
    [IssuingState] CHAR(2) NOT NULL, 
    CONSTRAINT [FK_EmployeeTherapy_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [Enrollment].[Employee]([Id]) ON DELETE CASCADE
)
