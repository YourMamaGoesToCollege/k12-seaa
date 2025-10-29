-- From: EmployeeSubServiceType.sql
-- Depends on Provider.EmployeeType
CREATE TABLE [Provider].[EmployeeSubServiceType]
(
    [Id]             INT          NOT NULL PRIMARY KEY IDENTITY,
    [EmployeeTypeId] INT          NOT NULL,
    [Name]           VARCHAR(100) NOT NULL,
    [Description]    VARCHAR(500) NULL,
    CONSTRAINT [FK_ProviderEmployeeSubServiceTypes_EmployeeType] FOREIGN KEY ([EmployeeTypeId]) REFERENCES [Provider].[EmployeeType] ([Id])
);
GO

-- From: Employee.sql
-- Depends on Provider.EmployeeType and Provider.EmployeeValidatedStatus
-- Also depends on tables in other schemas (K12, Partner)
CREATE TABLE [Provider].[Employee] (
    [Id]                UNIQUEIDENTIFIER   CONSTRAINT [DF__Employee__Id__756D6FFF] DEFAULT (newid()) NOT NULL,
    [ProgramPartnerId]  UNIQUEIDENTIFIER   NULL,
    [PersonId]          UNIQUEIDENTIFIER   NOT NULL,
    [PersonalAddressId] UNIQUEIDENTIFIER   NULL,
    [BusinessAddressId] UNIQUEIDENTIFIER   NULL,
    [EmployeeTypeId]    INT                NOT NULL,
    [ValidatedStatusId] INT                NULL,
    [Email]             VARCHAR (250)      NULL,
    [BirthDate]         DATE               NULL,
    [IsOwner]           BIT                DEFAULT ((0)) NOT NULL,
    [DateCreated]       DATETIMEOFFSET (7) CONSTRAINT [DF__Employee__DateCr__76619CCC] DEFAULT (sysdatetimeoffset()) NOT NULL,
    [DateDeleted]       DATETIMEOFFSET (7) NULL,
    CONSTRAINT [PK_ProviderEmployee] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Employee_Person] FOREIGN KEY ([PersonId]) REFERENCES [K12].[Person] ([Id]),
    CONSTRAINT [FK_Employee_ProgramPartner] FOREIGN KEY ([ProgramPartnerId]) REFERENCES [Partner].[ProgramPartner] ([Id]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ProviderEmployee_BusinessAddress] FOREIGN KEY ([BusinessAddressId]) REFERENCES [K12].[BusinessAddress] ([Id]),
    CONSTRAINT [FK_ProviderEmployee_EmployeeType] FOREIGN KEY ([EmployeeTypeId]) REFERENCES [Provider].[EmployeeType] ([Id]),
    CONSTRAINT [FK_ProviderEmployee_EmployeeValidatedStatus] FOREIGN KEY ([ValidatedStatusId]) REFERENCES [Provider].[EmployeeValidatedStatus] ([Id]),
    CONSTRAINT [FK_ProviderEmployee_PersonalAddress] FOREIGN KEY ([PersonalAddressId]) REFERENCES [K12].[PersonalAddress] ([Id])
);
GO
ALTER TABLE [Provider].[Employee] NOCHECK CONSTRAINT [FK_Employee_ProgramPartner];
GO

-- From: EmployeePhone.sql
-- Depends on Provider.Employee
CREATE TABLE [Provider].[EmployeePhone] (
    [EmployeeId]  UNIQUEIDENTIFIER NOT NULL,
    [PhoneId]     UNIQUEIDENTIFIER NOT NULL,
    [Extension]   NVARCHAR (8)     NULL,
    [Description] NVARCHAR (100)   NULL,
    [IsPrimary]   BIT              CONSTRAINT [DF__EmployeeP__IsPri__74794A92] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_EmployeePhone] PRIMARY KEY CLUSTERED ([EmployeeId] ASC, [PhoneId] ASC),
    CONSTRAINT [FK_EmployeePhone_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [Provider].[Employee] ([Id]) NOT FOR REPLICATION,
    CONSTRAINT [FK_EmployeePhone_Phone] FOREIGN KEY ([PhoneId]) REFERENCES [K12].[Phone] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [UQ_EmployeePhone_OnePrimary] UNIQUE NONCLUSTERED ([EmployeeId] ASC, [IsPrimary] ASC)
);
GO

-- From: EmployeeSubServices.sql
-- Depends on Provider.Employee and Provider.EmployeeSubServiceType
CREATE TABLE [Provider].[EmployeeSubServices]
(
	EmployeeId UNIQUEIDENTIFIER NOT NULL,
    EmployeeSubServiceTypeId INT NOT NULL,
    CONSTRAINT PK_EProvider_EmployeeSubServices PRIMARY KEY (EmployeeId, EmployeeSubServiceTypeId),
    CONSTRAINT FK_Provider_EmployeeSubServices_Employee FOREIGN KEY (EmployeeId) REFERENCES [Provider].[Employee]([Id]) NOT FOR REPLICATION,
    CONSTRAINT FK_Provider_EmployeeSubServices_EmployeeSubService FOREIGN KEY (EmployeeSubServiceTypeId) REFERENCES [Provider].[EmployeeSubServiceType]([Id])
);
GO

-- From: EmployeeTherapy.sql
-- Depends on Provider.Employee and Provider.TherapyLicenseType
CREATE TABLE [Provider].[EmployeeTherapy]
(
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    [TherapyLicenseTypeId] INT NULL,
    [LicenseNumber] VARCHAR(50) NOT NULL,
    [IssuingState] CHAR(2) NOT NULL,
    CONSTRAINT [PK_ProviderEmployeeTherapy] PRIMARY KEY CLUSTERED ([EmployeeId] ASC),
    CONSTRAINT [FK_ProviderEmployeeTherapy_LicenseType] FOREIGN KEY ([TherapyLicenseTypeId]) REFERENCES [Provider].[TherapyLicenseType]([Id]),
    CONSTRAINT [FK_ProviderEmployeeTherapy_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [Provider].[Employee]([Id])  NOT FOR REPLICATION
);
GO

-- From: EmployeeTutor.sql
-- Depends on Provider.Employee and Provider.EmployeeSchool
CREATE TABLE [Provider].[EmployeeTutor]
(
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeSchoolId] INT NOT NULL,
    [GraduationDate] DATE NULL,
    [SsnLast4] CHAR(4)  NULL,
    CONSTRAINT [PK_ProviderEmployeeTutor] PRIMARY KEY CLUSTERED ([EmployeeId] ASC),
    CONSTRAINT [FK_ProviderEmployeeTutor_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [Provider].[Employee]([Id])  NOT FOR REPLICATION,
    CONSTRAINT [FK_ProviderEmployeeTutor_EmployeeSchool] FOREIGN KEY ([EmployeeSchoolId]) REFERENCES [Provider].[EmployeeSchool]([Id]) ON DELETE CASCADE
);
GO