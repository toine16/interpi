CREATE TABLE [dbo].[EditionParticipants]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1), 
    [IdParticipant] INT NOT NULL, 
    [IdEdition] INT NOT NULL, 
    CONSTRAINT [FK_EditionParticipants_Participants] FOREIGN KEY (IdParticipant) REFERENCES Participants(Id), 
    CONSTRAINT [FK_EditionParticipants_Edition] FOREIGN KEY (IdEdition) REFERENCES Edition(Annee)
)
