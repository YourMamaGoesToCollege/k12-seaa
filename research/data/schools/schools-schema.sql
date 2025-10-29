-- From: Student.sql
CREATE TABLE [Schools].[Student] (
  [StudentId] UNIQUEIDENTIFIER NOT NULL,
  [PersonId] UNIQUEIDENTIFIER NOT NULL,
  [ContactPersonId] UNIQUEIDENTIFIER NULL,
  [PersonalAddressId] UNIQUEIDENTIFIER NULL,
  [DateCreated]   DATETIMEOFFSET (7) CONSTRAINT [DF__School__Student__DateC__6BE40491] DEFAULT (sysdatetimeoffset()) NOT NULL,
  CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([StudentId] ASC),
  CONSTRAINT [FK_Student_Person] FOREIGN KEY ([PersonId]) REFERENCES [K12].[Person] ([Id]),
  CONSTRAINT [FK_Student_ContactPerson] FOREIGN KEY ([ContactPersonId]) REFERENCES [K12].[Person] ([Id]),
  CONSTRAINT [FK_Student_PersonalAddress] FOREIGN KEY ([PersonalAddressId]) REFERENCES [K12].[PersonalAddress] ([Id])
);
GO

-- From: StudentEnrollment.sql
CREATE TABLE [Schools].[StudentEnrollment] (
  [StudentEnrollmentId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [StudentId] UNIQUEIDENTIFIER NOT NULL,
  [SchoolTermGradeId] UNIQUEIDENTIFIER NOT NULL,
  [CertificationDate] DATETIMEOFFSET NULL,
  [EndorsedDate] DATETIMEOFFSET NULL,
  [StartDate] DATETIMEOFFSET NOT NULL,
  [EndDate] DATETIMEOFFSET NULL,
  [EnrollmentStatusId] INT NOT NULL,
  [IsVerified] BIT NOT NULL DEFAULT 0,
  [StandardCosts] DECIMAL(18, 4) NOT NULL DEFAULT 0,
  [IndividualCosts] DECIMAL(18, 4) NOT NULL DEFAULT 0,
  [TermAward] DECIMAL(18, 4) NOT NULL DEFAULT 0,
  [PaymentStatusId] INT NOT NULL,
  CONSTRAINT [PK_StudentEnrollment] PRIMARY KEY CLUSTERED ([StudentEnrollmentId] ASC),
  CONSTRAINT [FK_StudentEnrollment.StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Schools].[Student]([StudentId]),
  CONSTRAINT [FK_StudentEnrollment.SchoolTermGradeId] FOREIGN KEY ([SchoolTermGradeId]) REFERENCES [Schools].[SchoolTermGrade]([SchoolTermGradeId]),
  CONSTRAINT [FK_StudentEnrollment.EnrollmentStatusId] FOREIGN KEY ([EnrollmentStatusId]) REFERENCES [Schools].[EnrollmentStatus]([EnrollmentStatusId]),
  CONSTRAINT [FK_StudentEnrollment.PaymentStatusId] FOREIGN KEY ([PaymentStatusId]) REFERENCES [Schools].[PaymentStatus]([PaymentStatusId])
);
GO

-- From: StudentProgram.sql
CREATE TABLE [Schools].[StudentProgram] (
  [StudentProgramId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [StudentEnrollmentId] UNIQUEIDENTIFIER NOT NULL,
  [ProgramId] INT NOT NULL,
  CONSTRAINT [PK_StudentProgram] PRIMARY KEY CLUSTERED ([StudentProgramId] ASC),
  CONSTRAINT [FK_StudentProgram_StudentEnrollment] FOREIGN KEY ([StudentEnrollmentId]) REFERENCES [Schools].[StudentEnrollment]([StudentEnrollmentId]),
  CONSTRAINT [FK_StudentProgram_Program] FOREIGN KEY ([ProgramId]) REFERENCES [Schools].[Program]([ProgramId])
);
GO