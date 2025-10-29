CREATE TABLE [Schools].[SchoolTermGrade] (
  [SchoolTermGradeId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [SchoolGradeId] UNIQUEIDENTIFIER NOT NULL,
  [SchoolTermId] UNIQUEIDENTIFIER NOT NULL,
  [Tuition] DECIMAL(10, 2) NULL DEFAULT 0,
  [Fees] DECIMAL(10, 2) NULL DEFAULT 0,
  CONSTRAINT [PK_SchoolTermGrade] PRIMARY KEY CLUSTERED ([SchoolTermGradeId] ASC),
  CONSTRAINT [FK_SchoolTermGrade.SchoolGradeId] FOREIGN KEY ([SchoolGradeId]) REFERENCES [Schools].[SchoolGrade]([SchoolGradeId]),
  CONSTRAINT [FK_SchoolTermGrade.SchoolTermId] FOREIGN KEY ([SchoolTermId]) REFERENCES [Schools].[SchoolTerm]([SchoolTermId]),
);