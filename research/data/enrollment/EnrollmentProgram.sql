CREATE TABLE [Enrollment].[EnrollmentProgram] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Token]       VARCHAR (256)    NULL,
    [Name]        VARCHAR (256)    NULL,
    [Key]         VARCHAR (256)    NULL,
    [KeyPath]     VARCHAR (MAX)    NULL,
    [Version]     INT              NULL,
    [IsCurrent]   BIT              NOT NULL,
    [IsPublished] BIT              NOT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [RequiresPublish] BIT NOT NULL DEFAULT 1,
    CONSTRAINT [pk_EnrollmentProgram] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_EnrollmentProgram_Name] UNIQUE NONCLUSTERED ([Name])
);

