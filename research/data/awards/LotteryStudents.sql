/****** Object:  Table [Awards].[LotteryStudents]    Script Date: 7/31/2025 4:49:45 AM ******/
/****** Story: K12-3171                                                             ******/
/****** Author: Mounisha Badarla    ******/
CREATE TABLE [Awards].[LotteryStudents](
[Id] UNIQUEIDENTIFIER NOT NULL,
[FirstName] NVARCHAR (255) NOT NULL,
[LastName] NVARCHAR (255) NOT NULL,
[HouseHoldId] UNIQUEIDENTIFIER NOT NULL,
[EsaLotteryNumber] INT NULL,
[OsLotteryNumber] INT NULL,
 CONSTRAINT [PK_Awards_LotteryStudents] PRIMARY KEY CLUSTERED 
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [IX_Awards_LotteryStudent_Household] ON [Awards].[LotteryStudents]
(
[HouseHoldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
