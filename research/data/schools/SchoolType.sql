CREATE TABLE [Schools].[SchoolType] (
  [SchoolTypeId] INT NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [IsActive] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [PK_SchoolType] PRIMARY KEY CLUSTERED ([SchoolTypeId] ASC)
);