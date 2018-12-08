/*
Script de déploiement pour InterPiHO

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "InterPiHO"
:setvar DefaultFilePrefix "InterPiHO"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de [dbo].[Edition]...';


GO
CREATE TABLE [dbo].[Edition] (
    [Annee] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Annee] ASC)
);


GO
PRINT N'Création de [dbo].[EditionParticipants]...';


GO
CREATE TABLE [dbo].[EditionParticipants] (
    [Id]            INT IDENTITY (1, 1) NOT NULL,
    [IdParticipant] INT NOT NULL,
    [IdEdition]     INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [dbo].[EditionTroupe]...';


GO
CREATE TABLE [dbo].[EditionTroupe] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [IdTroupe]  INT NOT NULL,
    [IdEdition] INT NOT NULL,
    CONSTRAINT [PK_EditionTroupe] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [dbo].[Participants]...';


GO
CREATE TABLE [dbo].[Participants] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Nom]      NVARCHAR (50) NOT NULL,
    [Prenom]   NVARCHAR (50) NOT NULL,
    [Totem]    NVARCHAR (50) NOT NULL,
    [IdTroupe] INT           NOT NULL,
    [Role]     NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [dbo].[Payement]...';


GO
CREATE TABLE [dbo].[Payement] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Montant]  DECIMAL (18)  NOT NULL,
    [Date]     DATETIME2 (7) NOT NULL,
    [IdTroupe] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [dbo].[Troupes]...';


GO
CREATE TABLE [dbo].[Troupes] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [NomSection]          NVARCHAR (50)  NOT NULL,
    [Lieu]                NVARCHAR (50)  NOT NULL,
    [Mail]                NVARCHAR (50)  NOT NULL,
    [Telephone]           NVARCHAR (50)  NOT NULL,
    [NbrParticipants]     INT            NOT NULL,
    [ListingParticipants] NVARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Payement]...';


GO
ALTER TABLE [dbo].[Payement]
    ADD DEFAULT 0.0 FOR [Montant];


GO
PRINT N'Création de [dbo].[FK_EditionParticipants_Participants]...';


GO
ALTER TABLE [dbo].[EditionParticipants]
    ADD CONSTRAINT [FK_EditionParticipants_Participants] FOREIGN KEY ([IdParticipant]) REFERENCES [dbo].[Participants] ([Id]);


GO
PRINT N'Création de [dbo].[FK_EditionParticipants_Edition]...';


GO
ALTER TABLE [dbo].[EditionParticipants]
    ADD CONSTRAINT [FK_EditionParticipants_Edition] FOREIGN KEY ([IdEdition]) REFERENCES [dbo].[Edition] ([Annee]);


GO
PRINT N'Création de [dbo].[FK_EditionTroupe_Troupes]...';


GO
ALTER TABLE [dbo].[EditionTroupe]
    ADD CONSTRAINT [FK_EditionTroupe_Troupes] FOREIGN KEY ([IdTroupe]) REFERENCES [dbo].[Troupes] ([Id]);


GO
PRINT N'Création de [dbo].[FK_EditionTroupe_Edition]...';


GO
ALTER TABLE [dbo].[EditionTroupe]
    ADD CONSTRAINT [FK_EditionTroupe_Edition] FOREIGN KEY ([IdEdition]) REFERENCES [dbo].[Edition] ([Annee]);


GO
PRINT N'Création de [dbo].[FK_Participants_Troupes]...';


GO
ALTER TABLE [dbo].[Participants]
    ADD CONSTRAINT [FK_Participants_Troupes] FOREIGN KEY ([IdTroupe]) REFERENCES [dbo].[Troupes] ([Id]);


GO
PRINT N'Création de [dbo].[FK_Payement_Troupes]...';


GO
ALTER TABLE [dbo].[Payement]
    ADD CONSTRAINT [FK_Payement_Troupes] FOREIGN KEY ([IdTroupe]) REFERENCES [dbo].[Troupes] ([Id]);


GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd89cd283-3d3d-4d39-bd05-cd10a0d787bf')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d89cd283-3d3d-4d39-bd05-cd10a0d787bf')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4e71acc7-18a8-46dd-89f7-acf6b8271d99')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4e71acc7-18a8-46dd-89f7-acf6b8271d99')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '388a7d48-d0e7-4c69-a9ad-30e2bc1a50dc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('388a7d48-d0e7-4c69-a9ad-30e2bc1a50dc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '02655a74-9919-468f-8902-ad559e8b91fe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('02655a74-9919-468f-8902-ad559e8b91fe')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'eb0922d2-8c43-4645-ae23-5ccbfba36324')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('eb0922d2-8c43-4645-ae23-5ccbfba36324')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
