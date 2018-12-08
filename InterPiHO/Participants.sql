CREATE TABLE [dbo].[Participants]
(
	[Id] INT NOT NULL PRIMARY KEY Identity(1,1), 
    [Nom] NVARCHAR(50) NOT NULL, 
    [Prenom] NVARCHAR(50) NOT NULL, 
    [Totem] NVARCHAR(50) NOT NULL, 
    [IdTroupe] INT NOT NULL, 
    [Role] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [FK_Participants_Troupes] FOREIGN KEY (IdTroupe) REFERENCES Troupes(Id), 

)
