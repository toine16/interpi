USE [InterPiHO]
GO
/****** Object:  Table [dbo].[Edition]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Edition](
	[Annee] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Annee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EditionParticipants]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditionParticipants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdParticipant] [int] NOT NULL,
	[IdEdition] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EditionTroupe]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditionTroupe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTroupe] [int] NOT NULL,
	[IdEdition] [int] NOT NULL,
 CONSTRAINT [PK_EditionTroupe] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Participants]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	[Prenom] [nvarchar](50) NOT NULL,
	[Totem] [nvarchar](50) NOT NULL,
	[IdTroupe] [int] NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payement]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Montant] [decimal](18, 0) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[IdTroupe] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Troupes]    Script Date: 2/11/2018 14:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Troupes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NomSection] [nvarchar](50) NOT NULL,
	[Lieu] [nvarchar](50) NOT NULL,
	[Mail] [nvarchar](50) NOT NULL,
	[Telephone] [nvarchar](50) NOT NULL,
	[NbrParticipants] [int] NOT NULL,
	[ListingParticipants] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Payement] ADD  DEFAULT ((0.0)) FOR [Montant]
GO
ALTER TABLE [dbo].[EditionParticipants]  WITH CHECK ADD  CONSTRAINT [FK_EditionParticipants_Edition] FOREIGN KEY([IdEdition])
REFERENCES [dbo].[Edition] ([Annee])
GO
ALTER TABLE [dbo].[EditionParticipants] CHECK CONSTRAINT [FK_EditionParticipants_Edition]
GO
ALTER TABLE [dbo].[EditionParticipants]  WITH CHECK ADD  CONSTRAINT [FK_EditionParticipants_Participants] FOREIGN KEY([IdParticipant])
REFERENCES [dbo].[Participants] ([Id])
GO
ALTER TABLE [dbo].[EditionParticipants] CHECK CONSTRAINT [FK_EditionParticipants_Participants]
GO
ALTER TABLE [dbo].[EditionTroupe]  WITH CHECK ADD  CONSTRAINT [FK_EditionTroupe_Edition] FOREIGN KEY([IdEdition])
REFERENCES [dbo].[Edition] ([Annee])
GO
ALTER TABLE [dbo].[EditionTroupe] CHECK CONSTRAINT [FK_EditionTroupe_Edition]
GO
ALTER TABLE [dbo].[EditionTroupe]  WITH CHECK ADD  CONSTRAINT [FK_EditionTroupe_Troupes] FOREIGN KEY([IdTroupe])
REFERENCES [dbo].[Troupes] ([Id])
GO
ALTER TABLE [dbo].[EditionTroupe] CHECK CONSTRAINT [FK_EditionTroupe_Troupes]
GO
ALTER TABLE [dbo].[Participants]  WITH CHECK ADD  CONSTRAINT [FK_Participants_Troupes] FOREIGN KEY([IdTroupe])
REFERENCES [dbo].[Troupes] ([Id])
GO
ALTER TABLE [dbo].[Participants] CHECK CONSTRAINT [FK_Participants_Troupes]
GO
ALTER TABLE [dbo].[Payement]  WITH CHECK ADD  CONSTRAINT [FK_Payement_Troupes] FOREIGN KEY([IdTroupe])
REFERENCES [dbo].[Troupes] ([Id])
GO
ALTER TABLE [dbo].[Payement] CHECK CONSTRAINT [FK_Payement_Troupes]
GO
