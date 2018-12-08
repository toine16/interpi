CREATE TABLE [dbo].[EditionTroupe]
(
	[Id] INT NOT NULL  IDENTITY, 
    [IdTroupe] INT NOT NULL, 
    [IdEdition] INT NOT NULL, 
    CONSTRAINT [PK_EditionTroupe] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_EditionTroupe_Troupes] FOREIGN KEY ([IdTroupe]) REFERENCES Troupes(Id), 
    CONSTRAINT [FK_EditionTroupe_Edition] FOREIGN KEY (IdEdition) REFERENCES Edition(Annee)
)
