CREATE TABLE [Schools].[Institution] (
  [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
  [HDMAAccountId] UNIQUEIDENTIFIER NULL,
  [Name] NVARCHAR(255) NULL,
  [FederalEmployerID] NVARCHAR(255) NULL,
  [FiscalYearEndDate] DATETIME2 NULL,
  [BackgroundCheckValidatedDate] DATETIME2 NULL,
  [BackgroundCheckNameOnFile] NVARCHAR(255) NULL,
  [BusinessAddressId] UNIQUEIDENTIFIER NULL,
  CONSTRAINT [PK_Insitution] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_Insitution_HDMAAccount] FOREIGN KEY ([HDMAAccountId]) REFERENCES [K12].[Account] ([Id]),
  CONSTRAINT [FK_Insitution_BusinessAddress] FOREIGN KEY ([BusinessAddressId]) REFERENCES [K12].[BusinessAddress]([Id])
);