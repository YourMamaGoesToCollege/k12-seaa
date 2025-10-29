CREATE TABLE [Enrollment].[Account]
(
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Token]       VARCHAR(256)     NOT null,
    [ApplicantId] UNIQUEIDENTIFIER NOT NULL,
    [PersonaId]   INT              NOT NULL,
    [DateCreated] DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT [pk_Account] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_account_applicant] FOREIGN KEY ([ApplicantId]) REFERENCES [Enrollment].[Applicant] ([Id]),
    CONSTRAINT [unq_Account_token] UNIQUE NONCLUSTERED ([Token] ASC),
    CONSTRAINT [unq_Account_ApplicantId] UNIQUE NONCLUSTERED ([ApplicantId] ASC)
);