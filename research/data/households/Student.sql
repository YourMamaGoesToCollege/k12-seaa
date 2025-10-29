CREATE TABLE [Household].[Student] (
  [Id] UNIQUEIDENTIFIER NOT NULL,
  [StudentId] INT NULL,
  [HouseholdId] UNIQUEIDENTIFIER NOT NULL, 
  [ProgramTypeId] INT NULL,
  [IsDisabled] BIT NOT NULL DEFAULT(0),
  [DateCreated]   DATETIMEOFFSET (7) CONSTRAINT [DF__Household__Student__DateC__6BE40491] DEFAULT (sysdatetimeoffset()) NOT NULL,
  CONSTRAINT [PK_Household_Student] PRIMARY KEY CLUSTERED ([Id] ASC), 
  CONSTRAINT [FK_Household_Student_Person] FOREIGN KEY ([Id]) REFERENCES [K12].[Person] ([Id]),  
  CONSTRAINT [FK_Household_Household] FOREIGN KEY ([HouseholdId]) REFERENCES [Household].[Household] ([Id]),

);