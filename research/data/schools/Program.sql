-- TODO: This is almost guaranteed to not need to be in here.

CREATE TABLE [Schools].[Program] (
  [ProgramId] INT NOT NULL IDENTITY(1, 1),
  [Name] NVARCHAR(255) NOT NULL,
  [IsActive] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED ([ProgramId] ASC)
);