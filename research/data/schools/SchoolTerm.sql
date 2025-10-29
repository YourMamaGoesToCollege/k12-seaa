CREATE TABLE [Schools].[SchoolTerm] (
  [SchoolTermId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [ProgramPartnerId] UNIQUEIDENTIFIER NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [Cardinality] INT NOT NULL,
  [StartDate] DATETIME2 NOT NULL,
  [EndDate] DATETIME2 NOT NULL,
  CONSTRAINT [PK_SchoolTerm] PRIMARY KEY CLUSTERED ([SchoolTermId] ASC),
  CONSTRAINT [FK_SchoolTerm.ProgramPartner] FOREIGN KEY ([ProgramPartnerId]) REFERENCES [Partner].[SchoolDetail]([ProgramPartnerId]) ON DELETE CASCADE
);