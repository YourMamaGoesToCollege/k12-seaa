CREATE TABLE [Schools].[PaymentStatus] (
  [PaymentStatusId] INT NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [IsActive] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED ([PaymentStatusId] ASC)
);