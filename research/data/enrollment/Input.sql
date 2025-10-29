CREATE TABLE [Enrollment].[Input](
	[Id] [uniqueidentifier] NOT NULL,
	[PromptComponentId] [uniqueidentifier] NOT NULL,
	[Label] [nvarchar](max) NULL,
	[Key] [varchar](256) NULL,
	[Order] [int] NULL,
	[KeyPath] [varchar](max) NULL,
	[Instructions] [varchar](max) NULL,
	[InputType] [nvarchar](128) NULL,
	[DataType] [nvarchar](128) NULL,
	[IsRequired] [bit] NULL,
	[Min] [int] NULL,
	[Value] [varchar](256) NULL,
	[Icon] [varchar](256) NULL,
	[Max] [int] NULL,
	[FileSize] [int] NULL,
	[FileType] [varchar](max) NULL,
	[Placeholder] [varchar](max) NULL,
	[Link] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Enrollment].[Input] ADD  CONSTRAINT [pk_EnrollmentProgram_2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Enrollment].[Input]  WITH CHECK ADD  CONSTRAINT [fk_inputs_promptcomponents] FOREIGN KEY([PromptComponentId])
REFERENCES [Enrollment].[PromptComponent] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Enrollment].[Input] CHECK CONSTRAINT [fk_inputs_promptcomponents]
GO