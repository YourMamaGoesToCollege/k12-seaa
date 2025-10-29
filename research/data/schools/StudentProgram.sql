CREATE TABLE [Schools].[StudentProgram] (
  [StudentProgramId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [StudentEnrollmentId] UNIQUEIDENTIFIER NOT NULL,
  [ProgramId] INT NOT NULL,
  CONSTRAINT [PK_StudentProgram] PRIMARY KEY CLUSTERED ([StudentProgramId] ASC),
  CONSTRAINT [FK_StudentProgram_StudentEnrollment] FOREIGN KEY ([StudentEnrollmentId]) REFERENCES [Schools].[StudentEnrollment]([StudentEnrollmentId]),
  CONSTRAINT [FK_StudentProgram_Program] FOREIGN KEY ([ProgramId]) REFERENCES [Schools].[Program]([ProgramId])
);