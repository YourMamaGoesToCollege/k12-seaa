CREATE TABLE [Enrollment].[EnrollmentBuilderHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[ProgramId] [uniqueidentifier] NULL,
	[PromptId] [uniqueidentifier] NULL,
	[CreatedDateTimeOffset] [datetimeoffset](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[Before] [nvarchar](max) NULL,
	[After] [nvarchar](max) NULL,
	[Changes] [nvarchar](max) NULL,
	[HistoryTypeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [Enrollment].[EnrollmentBuilderHistory] ADD  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [Enrollment].[EnrollmentBuilderHistory] ADD  DEFAULT (getutcdate()) FOR [CreatedDateTimeOffset]
GO

ALTER TABLE [Enrollment].[EnrollmentBuilderHistory]  WITH CHECK ADD  CONSTRAINT [FK_History_HistoryType] FOREIGN KEY([HistoryTypeId])
REFERENCES [Enrollment].[HistoryType] ([Id])
GO

ALTER TABLE [Enrollment].[EnrollmentBuilderHistory] CHECK CONSTRAINT [FK_History_HistoryType]
GO

CREATE INDEX idx_CreatedDateTimeOffset ON [Enrollment].[EnrollmentBuilderHistory] (CreatedDateTimeOffset);
GO
CREATE INDEX idx_ProgramId ON [Enrollment].[EnrollmentBuilderHistory] (ProgramId);
GO
CREATE INDEX idx_PromptId ON [Enrollment].[EnrollmentBuilderHistory] (PromptId);
GO

