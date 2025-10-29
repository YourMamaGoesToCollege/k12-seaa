CREATE TABLE Enrollment.PromptHierarchy (
    ParentPromptId UNIQUEIDENTIFIER NOT NULL,
    ChildPromptId UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_PromptHierarchy_Parent FOREIGN KEY (ParentPromptId) REFERENCES Enrollment.Prompt(Id),
    CONSTRAINT FK_PromptHierarchy_Child FOREIGN KEY (ChildPromptId) REFERENCES Enrollment.Prompt(Id),
    CONSTRAINT PK_PromptHierarchy PRIMARY KEY (ParentPromptId, ChildPromptId)
);
