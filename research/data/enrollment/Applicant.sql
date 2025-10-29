CREATE TABLE [Enrollment].[Applicant]
(
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [FirstName]      VARCHAR(100)     NULL,
    [LastName]       VARCHAR(100)     NULL,
    [Email]          VARCHAR(250)     NULL,
    [Phone]          VARCHAR(20)      NULL,
    [PhoneSecondary] VARCHAR(20)      NULL,
    [DateCreated]    DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT [pk_Applicant] PRIMARY KEY CLUSTERED ([Id] ASC)
);