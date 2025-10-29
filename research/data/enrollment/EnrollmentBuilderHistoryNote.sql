CREATE TABLE [Enrollment].[EnrollmentBuilderHistoryNote] (
    Id UniqueIdentifier PRIMARY KEY DEFAULT NEWID(),
    HistoryId UniqueIdentifier NOT NULL,
    Text NVARCHAR(MAX) NULL,
    CreatedDateTimeOffset DATETIMEOFFSET NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy NVARCHAR(256) NULL,
    UpdatedDateTimeOffset DATETIMEOFFSET NULL,
    UpdatedBy NVARCHAR(256) NULL,
    CONSTRAINT FK_HistoryNote_EnrollmentBuilderHistory FOREIGN KEY (HistoryId) 
        REFERENCES [Enrollment].[EnrollmentBuilderHistory] (Id)
        ON DELETE CASCADE
);
GO

-- Create an index for fast lookups by HistoryId
CREATE INDEX IDX_HistoryNote_HistoryId ON [Enrollment].[EnrollmentBuilderHistoryNote] (HistoryId);