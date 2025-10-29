CREATE TABLE [Schools].[OperationalScheduleType] (
  [OperationalScheduleTypeId] INT NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(1000) NULL,
  [IsActive] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [PK_OperationalScheduleType] PRIMARY KEY CLUSTERED ([OperationalScheduleTypeId] ASC)
);