CREATE TABLE [Enrollment].[Address]
(
    Id            UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    AddressTypeId INT              NOT NULL,
    ApplicantId   UNIQUEIDENTIFIER NOT NULL,
    Address1      NVARCHAR(255)    NOT NULL,
    Address2      NVARCHAR(255)    NULL,
    City          NVARCHAR(100)    NOT NULL,
    State         NVARCHAR(100)    NOT NULL,
    Zip           NVARCHAR(20)     NOT NULL,
    DateCreated   DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT FK_Address_AddressType FOREIGN KEY (AddressTypeId) REFERENCES [Enrollment].[AddressType] ([Id]) ON DELETE CASCADE,
    FOREIGN KEY (ApplicantId) REFERENCES [Enrollment].[Applicant] ([Id]) ON DELETE CASCADE
);