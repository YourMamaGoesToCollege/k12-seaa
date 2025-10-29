CREATE TABLE [Enrollment].[ApplicantBusinessInfo]
(
    Id             UNIQUEIDENTIFIER NOT NULL,
    ApplicantId    UNIQUEIDENTIFIER NOT NULL,
    Name           NVARCHAR(255)    NOT NULL,
    FirstName      NVARCHAR(255)    NULL,
    LastName       NVARCHAR(255)    NULL,
    Email          NVARCHAR(255)    NULL,
    Phone          NVARCHAR(50)     NULL,
    PhoneSecondary NVARCHAR(50)     NULL,
    DateCreated    DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT PK_ApplicantBusinessInfo PRIMARY KEY (Id, ApplicantId), --only 1 business per applicant for now
    CONSTRAINT FK_ApplicantBusinessInfo_Applicant FOREIGN KEY (ApplicantId) REFERENCES [Enrollment].[Applicant] ([Id]) ON DELETE CASCADE
);