CREATE TABLE [Schools].[EnrollmentStatus] (
  [EnrollmentStatusId] INT NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(1000) NULL,
  [IsActive] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [PK_EnrollmentStatus] PRIMARY KEY CLUSTERED ([EnrollmentStatusId] ASC)
);