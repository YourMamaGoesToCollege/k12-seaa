/****** Object:  Table [Awards].[Applications]    Script Date: 8/04/2025 4:49:45 AM ******/
/****** Story: K12-3371                                                             ******/
/****** Author: Mounisha Badarla    ******/
CREATE TABLE [Awards].[Applications](
[Id] UNIQUEIDENTIFIER NOT NULL,
[StudentId] UNIQUEIDENTIFIER NOT NULL,
[ProgramTypeId] INT NOT NULL,
[AcademicYearId] INT NOT NULL,
[ApplicationDate] DATETIME NOT NULL,
[Completed] BIT not null default(0)
 CONSTRAINT [PK_Awards_Applications] PRIMARY KEY CLUSTERED 
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [FK_Awards_Applications_LotteryStudents] FOREIGN KEY (StudentId) REFERENCES  [Awards].[LotteryStudents] ([Id]),
CONSTRAINT [FK_Awards_Applications_ProgramType] FOREIGN KEY (ProgramTypeId) REFERENCES  [Awards].[ProgramType] ([Id]),
CONSTRAINT [FK_Awards_Applications_AwardsAcademicYear] FOREIGN KEY (AcademicYearId) REFERENCES  [Awards].[AcademicYear] ([Id])
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Awards_Application_AcademicYear] ON [Awards].[Applications]
(
[AcademicYearId] ASC,
[ProgramTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_Awards_Application_Student] ON [Awards].[Applications]
(
[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_Awards_Application_Date] ON [Awards].[Applications]
(
[ApplicationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
