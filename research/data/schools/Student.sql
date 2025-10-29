CREATE TABLE [Schools].[Student] (
  [StudentId] UNIQUEIDENTIFIER NOT NULL,
  [PersonId] UNIQUEIDENTIFIER NOT NULL,
  [ContactPersonId] UNIQUEIDENTIFIER NULL,
  [PersonalAddressId] UNIQUEIDENTIFIER NULL,
  [DateCreated]   DATETIMEOFFSET (7) CONSTRAINT [DF__School__Student__DateC__6BE40491] DEFAULT (sysdatetimeoffset()) NOT NULL,
  CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([StudentId] ASC),
  CONSTRAINT [FK_Student_Person] FOREIGN KEY ([PersonId]) REFERENCES [K12].[Person] ([Id]),
  CONSTRAINT [FK_Student_ContactPerson] FOREIGN KEY ([ContactPersonId]) REFERENCES [K12].[Person] ([Id]),
  CONSTRAINT [FK_Student_PersonalAddress] FOREIGN KEY ([PersonalAddressId]) REFERENCES [K12].[PersonalAddress] ([Id]),
);