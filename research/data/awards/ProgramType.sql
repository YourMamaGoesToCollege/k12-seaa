/****** Object:  Table [Awards].[ProgramType]    Script Date: 7/17/2025 4:49:45 AM     *****/
/***** Story: K12-3269                                                           *****/
/***** Author: Thomas Franey														*****/
/***********************************************************************************/
CREATE TABLE [Awards].[ProgramType](
[Id] [int] NOT NULL,
[Code] nvarchar(4) NOT NULL,
[Title] nvarchar(255) NOT NULL,
 CONSTRAINT [PK_Awards_ProgramType] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]




