CREATE TABLE [Household].[Household] (
  [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [HouseHoldName] nvarchar(255) NOT NULL,
  [LegalGuardianPersonId] UNIQUEIDENTIFIER NOT NULL,
  [LegalGuardianAccountId] UNIQUEIDENTIFIER NOT NULL,
  [PersonalAddressId] UNIQUEIDENTIFIER NOT NULL,
  [DateCreated]   DATETIMEOFFSET (7) CONSTRAINT [DF__Household__DateC__6BE40491] DEFAULT (sysdatetimeoffset()) NOT NULL,
  CONSTRAINT [PK_Household] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_Household_LegalGuadianPerson] FOREIGN KEY ([LegalGuardianPersonId]) REFERENCES [K12].[Person] ([Id]), 
  CONSTRAINT [FK_Household_PersonalAddress] FOREIGN KEY ([PersonalAddressId]) REFERENCES [K12].[PersonalAddress] ([Id]),
  CONSTRAINT [FK_Household_Account] FOREIGN KEY ([LegalGuardianAccountId]) REFERENCES [K12].[Account] ([Id]),
);