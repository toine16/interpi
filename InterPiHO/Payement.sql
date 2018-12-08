CREATE TABLE [dbo].[Payement]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1), 
    [Montant] DECIMAL NOT NULL DEFAULT 0.0, 
    [Date] DATETIME2 NOT NULL, 
    [IdTroupe] INT NOT NULL, 
    CONSTRAINT [FK_Payement_Troupes] FOREIGN KEY (IdTroupe) REFERENCES Troupes(Id)
)
