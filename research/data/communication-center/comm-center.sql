-- Combined SQL Scripts

-- From: AlertBannerType.sql
CREATE TABLE [Comms].[AlertBannerType] (
    [Id]   INT          NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_AlertBannerType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- From: CommunicationTemplateStatus.sql
CREATE TABLE [Comms].[CommunicationTemplateStatus] (
    [Id]   INT          NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CommunicationTemplateStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- From: CommunicationType.sql
CREATE TABLE [Comms].[CommunicationType] (
    [Id]   INT           NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CommunicationType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- From: CommunicationTemplate.sql
CREATE TABLE [Comms].[CommunicationTemplate] (
    [Id]                            UNIQUEIDENTIFIER   NOT NULL,
    [CommunicationTypeId]           INT                NULL,
    [ProgramPartnerTypeId]          INT                NULL,
    [CommunicationTemplateStatusId] INT                CONSTRAINT [DF_CommunicationTemplate_CommunicationTemplateStatusId] DEFAULT ((1)) NULL,
    [AlertBannerTypeId]             INT                NULL,
    [Name]                          VARCHAR (100)      NOT NULL,
    [SubjectTemplate]               NVARCHAR (255)     NOT NULL,
    [CommTemplateBody]              NVARCHAR (4000)    NOT NULL,
    [CommTemplateText]              NVARCHAR (4000)    NULL,
    [NotificationTemplateBody]      NVARCHAR (4000)    NULL,
    [Description]                   NVARCHAR (1000)    NULL,
    [CreatedBy]                     UNIQUEIDENTIFIER   NOT NULL,
    [ModifiedBy]                    UNIQUEIDENTIFIER   NULL,
    [DateCreated]                   DATETIMEOFFSET (7) CONSTRAINT [DF_CommunicationTemplate_DateCreated] DEFAULT (getdate()) NOT NULL,
    [DateModified]                  DATETIMEOFFSET (7) NULL,
    [DatePublished]                 DATETIMEOFFSET (7) NULL,
    [DateArchived]                  DATETIMEOFFSET (7) NULL,
    CONSTRAINT [PK_CommunicationTemplate] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CommunicationTemplate_AccountCreated] FOREIGN KEY ([CreatedBy]) REFERENCES [K12].[Account] ([Id]),
    CONSTRAINT [FK_CommunicationTemplate_AccountModified] FOREIGN KEY ([ModifiedBy]) REFERENCES [K12].[Account] ([Id]),
    CONSTRAINT [FK_CommunicationTemplate_AlertBannerType] FOREIGN KEY ([AlertBannerTypeId]) REFERENCES [Comms].[AlertBannerType] ([Id]),
    CONSTRAINT [FK_CommunicationTemplate_CommunicationTemplateStatus] FOREIGN KEY ([CommunicationTemplateStatusId]) REFERENCES [Comms].[CommunicationTemplateStatus] ([Id]),
    CONSTRAINT [FK_CommunicationTemplate_CommunicationType] FOREIGN KEY ([CommunicationTypeId]) REFERENCES [Comms].[CommunicationType] ([Id]),
    CONSTRAINT [FK_CommunicationTemplate_ProgramPartnerType] FOREIGN KEY ([ProgramPartnerTypeId]) REFERENCES [Partner].[ProgramPartnerType] ([Id])
);

-- From: Communication.sql
CREATE TABLE [Comms].[Communication] (
    [Id]                      UNIQUEIDENTIFIER   CONSTRAINT [DF_Communication_Id] DEFAULT (newid()) NOT NULL,
    [Name]                    VARCHAR (100)      NOT NULL,
    [Description]             NVARCHAR (500)     NULL,
    [CommunicationTemplateId] UNIQUEIDENTIFIER   NOT NULL,
    [StartDate]               DATETIMEOFFSET (7) NULL,
    [EndDate]                 DATETIMEOFFSET (7) NULL,
    [CreatedBy]               UNIQUEIDENTIFIER   NOT NULL,
    [CreateDate]              DATETIMEOFFSET (7) CONSTRAINT [DF_Communication_CreateDate] DEFAULT (sysdatetimeoffset()) NOT NULL,
    [ModifiedBy]              UNIQUEIDENTIFIER   NULL,


-- Combined SQL Scripts

-- From: MergeFieldPartition.sql
CREATE TABLE [Comms].[MergeFieldPartition] (
    [Id]   INT          NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_MergeFieldPartition] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- From: MergeFieldSource.sql
CREATE TABLE [Comms].[MergeFieldSource] (
    [Id]                    INT          NOT NULL,
    [MergeFieldPartitionId] INT          NOT NULL,
    [Name]                  VARCHAR (50) NOT NULL,
    [Prefix]                VARCHAR (5)  NOT NULL,
    CONSTRAINT [PK_MergeFieldSource] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_MergeFieldSource_MergeFieldPartition] FOREIGN KEY ([MergeFieldPartitionId]) REFERENCES [Comms].[MergeFieldPartition] ([Id])
);

-- From: MergeField.sql
CREATE TABLE [Comms].[MergeField] (
    [Id]                 INT            NOT NULL,
    [MergeFieldSourceId] INT            NULL,
    [DisplayName]        VARCHAR (100)  NOT NULL,
    [Placeholder]        VARCHAR (100)  NOT NULL,
    [Description]        VARCHAR (1000) NULL,
    CONSTRAINT [PK_MergeField] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_MergeField_MergeFieldSource] FOREIGN KEY ([MergeFieldSourceId]) REFERENCES [Comms].[MergeFieldSource] ([Id])
);

GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_MergeField]
    ON [Comms].[MergeField]([MergeFieldSourceId] ASC, [Placeholder] ASC);

GO

-- From: MessageParentCategory.sql
CREATE TABLE [Comms].[MessageParentCategory] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Name]        VARCHAR (400)    NOT NULL,
    [Description] VARCHAR (MAX)    NOT NULL,
    [Ordinal]     INT              NOT NULL,
    [ProgramPartnerTypeId] INT     NULL, --NULL intentionally to allow for generic ones that apply to all
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- From: MessageChildCategory.sql
CREATE TABLE [Comms].[MessageChildCategory] (
    [Id]            UNIQUEIDENTIFIER NOT NULL,
    [ParentCategoryId] UNIQUEIDENTIFIER NOT NULL