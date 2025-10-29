CREATE TABLE [Enrollment].[EmployeeSubServices]
(
	EmployeeId UNIQUEIDENTIFIER NOT NULL,
    EmployeeSubServiceTypeId INT NOT NULL,
    CONSTRAINT PK_EmployeeSubServices PRIMARY KEY (EmployeeId, EmployeeSubServiceTypeId),
    CONSTRAINT FK_EmployeeSubServices_Employee FOREIGN KEY (EmployeeId) REFERENCES [Enrollment].[Employee]([Id]) ON DELETE CASCADE,
    CONSTRAINT FK_EmployeeSubServices_EmployeeSubService FOREIGN KEY (EmployeeSubServiceTypeId) REFERENCES [Enrollment].[EmployeeSubServiceType]([Id])    
)
