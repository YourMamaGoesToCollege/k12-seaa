/****** Object:  Table [[Enrollment]].[[AcademicYear]]    Script Date: 7/17/2025 4:49:45 AM ****/
/****** Story: K12-3268                                                                     ****/
/***** Author: Thomas Franey											                    ****/
/***********************************************************************************************/

CREATE TABLE [Awards].[AcademicYear](
[Id] [int]  IDENTITY(1,1) NOT NULL,
[StartDate] [DateTime] NOT NULL,
[EndDate] [DateTime] NOT NULL,
 CONSTRAINT [PK_Awards_AcademicYear] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_StartendDate] ON [Awards].[AcademicYear]
(
[StartDate] ASC,
[EndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO