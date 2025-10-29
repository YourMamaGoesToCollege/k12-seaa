CREATE TABLE [Awards].[OSLotterySettings](
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
[BaseFPLAmount] [decimal](10,2)  NULL,
[HouseholdIncrement] [decimal](10,2)  NULL,

[Tier1Threshold] [decimal](10,2)  NULL,
[Tier1AwardAmount] [decimal](10,2)  NULL,
[Tier2Threshold] [decimal](10,2)  NULL,
[Tier2AwardAmount] [decimal](10,2) NULL,
[Tier3Threshold]  [decimal](10,2)  NULL,
[Tier3AwardAmount][decimal](10,2) NULL,
[Tier4Threshold]  [decimal](10,2)  NULL,
[Tier4AwardAmount] [decimal](10,2) NULL,
[Completed] [bit] NOT NULL DEFAULT(0),

CONSTRAINT [PK_Awards_OSLotterySettings] PRIMARY KEY CLUSTERED([Id] ASC),
CONSTRAINT AK_Awards_OSLotteryAcademicYear UNIQUE(AcademicYearId), 
CONSTRAINT [FK_Awards_OSLotterySettings_AwardsAcademicYear] FOREIGN KEY (AcademicYearId) REFERENCES  [Awards].[AcademicYear] ([Id])
);
GO

CREATE UNIQUE INDEX [UIX_OSLotterySettings_AcademicYear] ON [Awards].[OSLotterySettings] ([AcademicYearId])
GO

CREATE NONCLUSTERED INDEX [IX_OSLotterySettings_StartEndAppWindowDate] ON [Awards].[OSLotterySettings]
(
[ApplicationWindowStartDate] ASC,
[ApplicationWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



CREATE NONCLUSTERED INDEX [IX_OSLotterySettings_StartEndPriorWindowDate] ON [Awards].[OSLotterySettings]
(
[PriorityWindowStartDate] ASC,
[PriorityWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



CREATE NONCLUSTERED INDEX [IX_OSLotterySettings_StartEndRenewalWindowDate] ON [Awards].[OSLotterySettings]
(
[RenewalWindowStartDate] ASC,
[RenewalWindowEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



