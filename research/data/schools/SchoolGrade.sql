CREATE TABLE [Schools].[SchoolGrade] (
  [SchoolGradeId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [ProgramPartnerId] UNIQUEIDENTIFIER NOT NULL,
  [GradeId] INT NOT NULL,
  [Cardinality] INT NOT NULL,
  CONSTRAINT [PK_SchoolGrade] PRIMARY KEY CLUSTERED ([SchoolGradeId] ASC),
  CONSTRAINT [FK_SchoolGrade.GradeId] FOREIGN KEY ([GradeId]) REFERENCES [Schools].[Grade]([GradeId]),
  CONSTRAINT [FK_SchoolGrade.ProgramPartner] FOREIGN KEY ([ProgramPartnerId]) REFERENCES [Partner].[SchoolDetail]([ProgramPartnerId]) ON DELETE CASCADE
);