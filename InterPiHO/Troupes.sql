CREATE TABLE [dbo].[Troupes]
(
	[Id] INT NOT NULL PRIMARY KEY Identity(1,1), 
    [NomSection] NVARCHAR(50) NOT NULL, 
    [Lieu] NVARCHAR(50) NOT NULL, 
    [Mail] NVARCHAR(50) NOT NULL, 
    [Telephone] NVARCHAR(50) NOT NULL, 
    [NbrParticipants] INT NOT NULL, 
    [ListingParticipants] NVARCHAR(150) NULL 
    
)
