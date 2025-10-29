CREATE TABLE [Awards].[ESALotterySettings](
[Id] [uniqueidentifier]  NOT NULL,
[AcademicYearId] [int]  NOT NULL,

[ApplicationWindowStartDate] [datetime] NOT NULL,
[ApplicationWindowEndDate] [datetime] NULL,

[PriorityWindowStartDate] [datetime] NULL,
[PriorityWindowEndDate] [datetime] NULL,

[RenewalWindowStartDate] [datetime] NULL,
[RenewalWindowEndDate] [datetime] NULL,

[AwardAcceptanceDeadlineDate] [datetime] NULL,

[FallEndorsementWindowStartDate] [DateTime] null,
[FallEndorsementWindowEndDate] [DateTime] null,

[SpringEndorsementWindowStartDate] [DateTime] null,
[SpringEndorsementWindowEndDate] [DateTime] null,

[CertificationWindowStartDate] [DateTime] null,
[CertificationWindowEndDate] [DateTime] null,

[SchoolChoiceDeadlineDate] [datetime] NULL,


[ESABaseAwardAmount] [decimal](10,2)  NULL,
[ESAEnhancedAwardAmount] [decimal](10,2) NULL,
[Completed] [bit] NOT NULL DEFAULT(0),

CONSTRAINT [PK_Awards_ESALotterySettings] PRIMARY KEY CLUSTERED([Id] ASC),
CONSTRAINT AK_Awards_ESALotteryAcademicYear UNIQUE(AcademicYearId), 
CONSTRAINT [FK_Awards_ESALotterySettings_AwardsAcademicYear] FOREIGN KEY (AcademicYearId) REFERENCES  [Awards].[AcademicYear] ([Id])
);
GO

CREATE UNIQUE INDEX [UIX_ESALotterySettings_AcademicYear] ON [Awards].[ESALotterySettings] ([AcademicYearId])
GO

CREATE NONCLUSTERED INDEX [IX_ESALotterySettings_StartEndAppWindowDate] ON [Awards].[ESALotterySettings]
(
[ApplicationWindowStartDate] ASC,
[ApplicationWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



CREATE NONCLUSTERED INDEX [IX_ESALotterySettings_StartEndPriorWindowDate] ON [Awards].[ESALotterySettings]
(
[PriorityWindowStartDate] ASC,
[PriorityWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



CREATE NONCLUSTERED INDEX [IX_ESALotterySettings_StartEndRenewalWindowDate] ON [Awards].[ESALotterySettings]
(
[RenewalWindowStartDate] ASC,
[RenewalWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



