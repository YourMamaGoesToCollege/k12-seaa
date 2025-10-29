-- =================================================================
-- Independent Tables
-- These tables have no foreign key dependencies within this script.
-- =================================================================

-- From: Applicant.sql
CREATE TABLE [Enrollment].[Applicant]
(
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [FirstName]      VARCHAR(100)     NULL,
    [LastName]       VARCHAR(100)     NULL,
    [Email]          VARCHAR(250)     NULL,
    [Phone]          VARCHAR(20)      NULL,
    [PhoneSecondary] VARCHAR(20)      NULL,
    [DateCreated]    DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT [pk_Applicant] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- From: AddressType.sql
CREATE TABLE [Enrollment].[AddressType]
(
    Id   INT           NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
GO

-- From: EmployeeSchool.sql
CREATE TABLE [Enrollment].[EmployeeSchool](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchoolName] [varchar](max) NOT NULL,
	[SchoolCode] [varchar](50) NOT NULL,
	[DateCreated] [datetimeoffset] NOT NULL DEFAULT GETUTCDATE(),
	[DateDeleted] [datetimeoffset] NULL,
    CONSTRAINT [PK_EmployeeSchool] PRIMARY KEY CLUSTERED ([Id] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

-- From: EmployeeType.sql
CREATE TABLE [Enrollment].[EmployeeType]
(
	[Id] INT NOT NULL PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL
);
GO

-- From: EmployeeValidatedStatus.sql
CREATE TABLE [Enrollment].[EmployeeValidatedStatus]
(
	[Id] INT NOT NULL PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL
);
GO

-- From: EnrollmentProgram.sql
CREATE TABLE [Enrollment].[EnrollmentProgram] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Token]       VARCHAR (256)    NULL,
    [Name]        VARCHAR (256)    NULL,
    [Key]         VARCHAR (256)    NULL,
    [KeyPath]     VARCHAR (MAX)    NULL,
    [Version]     INT              NULL,
    [IsCurrent]   BIT              NOT NULL,
    [IsPublished] BIT              NOT NULL,
    [IsActive]    BIT              NOT NULL DEFAULT 1,
    [RequiresPublish] BIT          NOT NULL DEFAULT 1,
    CONSTRAINT [pk_EnrollmentProgram] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_EnrollmentProgram_Name] UNIQUE NONCLUSTERED ([Name])
);
GO

-- From: HistoryType.sql
CREATE TABLE [Enrollment].[HistoryType](
	[Id] [int] NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
) ON [PRIMARY];
GO

-- From: Persona.sql
CREATE TABLE [Enrollment].[Persona] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NULL,
    CONSTRAINT [pk_Persona] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- From: PromptIdFileUpload.sql
CREATE TABLE [Enrollment].[PromptIdFileUpload] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [PromptId]       VARCHAR (100) NOT NULL,
    [FileUploadName] VARCHAR (400) NOT NULL,
    [FileExtension]  VARCHAR (10)  NOT NULL,
    [FileName]       VARCHAR (400) NULL,
    CONSTRAINT [PK_PromptIdFileUpload] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- =================================================================
-- Dependent Tables
-- These tables have dependencies and are ordered to ensure
-- foreign key constraints are met.
-- =================================================================

-- From: Application.sql
-- Depends on Enrollment.EnrollmentProgram and Enrollment.Applicant
CREATE TABLE [Enrollment].[Application] (
    [Id]                   UNIQUEIDENTIFIER NOT NULL,
    [EnrollmentProgramId]  UNIQUEIDENTIFIER NOT NULL,
    [ApplicantId]          UNIQUEIDENTIFIER NOT NULL,
    [Status]               VARCHAR (50)     NULL,
    [CurrentPromptKeyPath] VARCHAR (MAX)    NULL,
    [LastPromptKeyPath]    VARCHAR (MAX)    NULL,
    CONSTRAINT [pk_EnrollmentSession] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_application] FOREIGN KEY ([EnrollmentProgramId]) REFERENCES [Enrollment].[EnrollmentProgram] ([Id]),
    CONSTRAINT [fk_application_applicant] FOREIGN KEY ([ApplicantId]) REFERENCES [Enrollment].[Applicant] ([Id])
);
GO


-- From: EmployeeSubServiceType.sql
-- Depends on Enrollment.EmployeeType
CREATE TABLE [Enrollment].[EmployeeSubServiceType]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [EmployeeTypeId] INT NOT NULL,
    [Name] VARCHAR(100) NOT NULL,
    [Description] VARCHAR(500) NULL,
    CONSTRAINT [FK_EmployeeSubServiceTypes_EmployeeType] FOREIGN KEY ([EmployeeTypeId]) REFERENCES [Enrollment].[EmployeeType]([Id])
);
GO

-- From: SemanticLayer.sql
-- Depends on Enrollment.EnrollmentProgram and Enrollment.Persona
CREATE TABLE [Enrollment].[SemanticLayer] (
    [Id]                  UNIQUEIDENTIFIER NOT NULL,
    [EnrollmentProgramId] UNIQUEIDENTIFIER NOT NULL,
    [PersonaId]           INT              NOT NULL,
    [Name]                VARCHAR (100)    NULL,
    [Version]             VARCHAR (50)     NULL,
    [IsCurrent]           BIT              NOT NULL,
    CONSTRAINT [pk_SemanticLayer] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_semanticlayer] FOREIGN KEY ([EnrollmentProgramId]) REFERENCES [Enrollment].[EnrollmentProgram] ([Id]),
    CONSTRAINT [fk_semanticlayer_persona] FOREIGN KEY ([PersonaId]) REFERENCES [Enrollment].[Persona] ([Id])
);
GO

-- From: Prompt.sql
-- Depends on Enrollment.EnrollmentProgram
CREATE TABLE [Enrollment].[Prompt] (
    [Id]                 UNIQUEIDENTIFIER NOT NULL,
    [ProgramId]          UNIQUEIDENTIFIER NOT NULL,
    [Token]              VARCHAR (256)    NOT NULL,
    [Name]               VARCHAR (256)    NOT NULL,
    [Key]                VARCHAR (256)    NULL,
    [KeyPath]            VARCHAR (MAX)    NULL,
    [Title]              VARCHAR(256)     NULL,
    [IsRequired]         BIT              NULL,
    [Header]             VARCHAR(256)     NULL,
    [SubHeader]          VARCHAR(MAX)     NULL,
    [Instructions]       VARCHAR(MAX)     NULL,
	[ConditionKeySource] NVARCHAR(255)    NULL,
	[ComparisonOperator] NVARCHAR(50)     NULL,
	[ConditionValueKey]  NVARCHAR(255)    NULL,
	[ConditionValue]     NVARCHAR(255)    NULL,
    CONSTRAINT [pk_EnrollmentProgram_0] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_prompts_enrollmentprogram] FOREIGN KEY ([ProgramId]) REFERENCES [Enrollment].[EnrollmentProgram] ([Id]) ON DELETE CASCADE,
    CONSTRAINT unique_ProgramId_Prompt_Name UNIQUE (ProgramId, [Name])
);
GO

-- From: SemanticLayerEvent.sql
-- Depends on Enrollment.SemanticLayer
CREATE TABLE [Enrollment].[SemanticLayerEvent] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [SemanticLayerId] UNIQUEIDENTIFIER NOT NULL,
    [EventType]       VARCHAR (50)     NOT NULL,
    [Detail]          TEXT             NULL,
    [EventDateTime]   DATETIME         NOT NULL,
    CONSTRAINT [pk_SemanticLayerEvent] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_semanticlayerevent] FOREIGN KEY ([SemanticLayerId]) REFERENCES [Enrollment].[SemanticLayer] ([Id])
);
GO

-- From: Measure.sql
-- Depends on Enrollment.SemanticLayer
CREATE TABLE [Enrollment].[Measure] (
    [Id]                     UNIQUEIDENTIFIER NOT NULL,
    [SemanticLayerId]        UNIQUEIDENTIFIER NOT NULL,
    [PromptComponentKeyPath] VARCHAR (MAX)    NOT NULL,
    [InputKey]               VARCHAR (50)     NULL,
    [Entity]                 VARCHAR (500)    NULL,
    [Attribute]              VARCHAR (500)    NULL,
    [ValueType]              VARCHAR (50)     NULL,
    [ValueFormat]            VARCHAR (MAX)    NULL,
    [IsCurrent]              BIT              NOT NULL,
    [CreatedDateTime]        DATETIME         NOT NULL,
    [UpdatedDateTime]        DATETIME         NULL,
    CONSTRAINT [pk_Measure] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_semanticlayer_measure] FOREIGN KEY ([SemanticLayerId]) REFERENCES [Enrollment].[SemanticLayer] ([Id])
);
GO

-- From: PromptHierarchy.sql
-- Depends on Enrollment.Prompt
CREATE TABLE [Enrollment].[PromptHierarchy] (
    ParentPromptId UNIQUEIDENTIFIER NOT NULL,
    ChildPromptId  UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_PromptHierarchy_Parent FOREIGN KEY (ParentPromptId) REFERENCES [Enrollment].[Prompt](Id),
    CONSTRAINT FK_PromptHierarchy_Child FOREIGN KEY (ChildPromptId) REFERENCES [Enrollment].[Prompt](Id),
    CONSTRAINT PK_PromptHierarchy PRIMARY KEY (ParentPromptId, ChildPromptId)
);
GO

-- From: PromptComponent.sql
-- Depends on Enrollment.Prompt
CREATE TABLE [Enrollment].[PromptComponent] (
    [Id]            UNIQUEIDENTIFIER NOT NULL,
    [PromptId]      UNIQUEIDENTIFIER NOT NULL,
    [Token]         VARCHAR (256)    NULL,
    [Name]          VARCHAR (256)    NULL,
    [Key]           VARCHAR (256)    NULL,
    [KeyPath]       VARCHAR (MAX)    NULL,
    [Order]         INT              NULL,
    [ComponentType] NVARCHAR(128)    NULL,
    [Header]        VARCHAR(256)     NULL,
    [Instructions]  VARCHAR(MAX)     NULL,
    [ButtonLabel]   NVARCHAR(MAX)    NULL,
    [Max]           INT              NULL,
    CONSTRAINT [pk_EnrollmentProgram_1] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_promptcomponents_prompts] FOREIGN KEY ([PromptId]) REFERENCES [Enrollment].[Prompt] ([Id]) ON DELETE CASCADE
);
GO

-- From: Input.sql
-- Depends on Enrollment.PromptComponent
CREATE TABLE [Enrollment].[Input](
	[Id]                UNIQUEIDENTIFIER NOT NULL,
	[PromptComponentId] UNIQUEIDENTIFIER NOT NULL,
	[Label]             NVARCHAR(MAX)    NULL,
	[Key]               VARCHAR(256)     NULL,
	[Order]             INT              NULL,
	[KeyPath]           VARCHAR(MAX)     NULL,
	[Instructions]      VARCHAR(MAX)     NULL,
	[InputType]         NVARCHAR(128)    NULL,
	[DataType]          NVARCHAR(128)    NULL,
	[IsRequired]        BIT              NULL,
	[Min]               INT              NULL,
	[Value]             VARCHAR(256)     NULL,
	[Icon]              VARCHAR(256)     NULL,
	[Max]               INT              NULL,
	[FileSize]          INT              NULL,
	[FileType]          VARCHAR(MAX)     NULL,
	[Placeholder]       VARCHAR(MAX)     NULL,
	[Link]              VARCHAR(MAX)     NULL,
    CONSTRAINT [pk_EnrollmentProgram_2] PRIMARY KEY CLUSTERED ([Id] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
ALTER TABLE [Enrollment].[Input] WITH CHECK ADD CONSTRAINT [fk_inputs_promptcomponents] FOREIGN KEY([PromptComponentId])
REFERENCES [Enrollment].[PromptComponent] ([Id])
ON DELETE CASCADE;
GO
ALTER TABLE [Enrollment].[Input] CHECK CONSTRAINT [fk_inputs_promptcomponents];
GO

-- From: InputOption.sql
-- Depends on Enrollment.Input
CREATE TABLE [Enrollment].[InputOption] (
    [Id]       UNIQUEIDENTIFIER NOT NULL,
    [InputId]  UNIQUEIDENTIFIER NOT NULL,
    [Label]    VARCHAR (256)    NULL,
    [Value]    VARCHAR (256)    NULL,
    [Order]    INT              NULL,
    [DataType] NVARCHAR(128)    NULL,
    CONSTRAINT [pk_EnrollmentProgram_3] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_inputoptions_input] FOREIGN KEY ([InputId]) REFERENCES [Enrollment].[Input] ([Id]) ON DELETE CASCADE
);
GO

-- From: PromptData.sql
-- Depends on Enrollment.Application
CREATE TABLE [Enrollment].[PromptData] (
    [Id]                     UNIQUEIDENTIFIER NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER NOT NULL,
    [PromptComponentKeyPath] VARCHAR (MAX)    NOT NULL,
    [InputKey]               VARCHAR (MAX)    NOT NULL,
    [Value]                  VARCHAR (MAX)    NOT NULL,
    CONSTRAINT [pk_PromptData] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_promptdata_application] FOREIGN KEY ([ApplicationId]) REFERENCES [Enrollment].[Application] ([Id]) ON DELETE CASCADE
);
GO