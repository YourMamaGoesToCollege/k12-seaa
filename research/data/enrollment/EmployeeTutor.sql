CREATE TABLE [Enrollment].[EmployeeTutor]
(
    [EmployeeId] UNIQUEIDENTIFIER PRIMARY KEY NOT NULL, 
    [EmployeeSchoolId] INT NOT NULL, 
    [GraduationDate] DATE NULL, 
    [Ssn] CHAR(11) NOT NULL, 
    CONSTRAINT [FK_EmployeeTutor_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [Enrollment].[Employee]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EmployeeTutor_EmployeeSchool] FOREIGN KEY ([EmployeeSchoolId]) REFERENCES [Enrollment].[EmployeeSchool]([Id]) ON DELETE CASCADE
)
