USE [master]
GO
/****** Object:  Database [SocialWebsite]    Script Date: 5/1/2018 1:32:46 PM ******/
CREATE DATABASE [SocialWebsite]
 CONTAINMENT = NONE
 GO
ALTER DATABASE [SocialWebsite] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SocialWebsite].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SocialWebsite] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SocialWebsite] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SocialWebsite] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SocialWebsite] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SocialWebsite] SET ARITHABORT OFF 
GO
ALTER DATABASE [SocialWebsite] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SocialWebsite] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SocialWebsite] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SocialWebsite] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SocialWebsite] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SocialWebsite] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SocialWebsite] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SocialWebsite] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SocialWebsite] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SocialWebsite] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SocialWebsite] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SocialWebsite] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SocialWebsite] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SocialWebsite] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SocialWebsite] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SocialWebsite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SocialWebsite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SocialWebsite] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SocialWebsite] SET RECOVERY FULL 
GO
ALTER DATABASE [SocialWebsite] SET  MULTI_USER 
GO
ALTER DATABASE [SocialWebsite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SocialWebsite] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SocialWebsite] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SocialWebsite] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SocialWebsite', N'ON'
GO
USE [SocialWebsite]
GO
/****** Object:  User [sa]    Script Date: 5/1/2018 1:32:46 PM ******/
CREATE USER [sa] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa]
GO
/****** Object:  StoredProcedure [dbo].[AcceptRequest]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AcceptRequest]
	-- Add the parameters for the stored procedure here
	@requestedId uniqueidentifier,
	@requesterUsername nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Request 
	where Requested=@requestedId and Requester = 
	(select ID from Account where UserName=@requesterUsername)
	insert into Friend (Friend1, Friend2)
	values(@requestedId, (select ID from Account where UserName=@requesterUsername))
END
GO
/****** Object:  StoredProcedure [dbo].[CheckLike]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckLike]
	-- Add the parameters for the stored procedure here
	@accountId uniqueidentifier,
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select count(*) from PostLike 
	where PostID=@postId and AccountID=@accountId
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteLike]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteLike]
	-- Add the parameters for the stored procedure here
	@accountId uniqueidentifier,
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from PostLike 
	where AccountID=@accountId and PostID=@postId
END

GO
/****** Object:  StoredProcedure [dbo].[DeletePost]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeletePost] 
	-- Add the parameters for the stored procedure here
	@postId int,
	@accountId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Post
	where PostID=@postId and AccountID=@accountId
END

GO
/****** Object:  StoredProcedure [dbo].[EditPost]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditPost]
	-- Add the parameters for the stored procedure here
	@postId int,
	@accountId uniqueidentifier,
	@postContent nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Post
	set PostContent=@postContent
	where PostID=@postId and AccountID=@accountId
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllPosts]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllPosts] 
	-- Add the parameters for the stored procedure here
	@id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Post.*, Account.FullName, Account.UserName, ProfilePicture.ImageURL from Post 
	right join Account
	on Post.AccountID=Account.ID 
	left join ProfilePicture
	on ProfilePicture.AccountID=Account.ID
	where Post.AccountID  
	in 
	(select Friend2 as ID from Friend
	where Friend1 = @id 
	union
	select Friend1 from Friend
	where  Friend2=@id)
	or
	Post.AccountID = @id
	order by DateCreated desc
END
GO
/****** Object:  StoredProcedure [dbo].[GetComments]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetComments]
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Comment.*, Account.FullName, Account.UserName, ProfilePicture.ImageURL from Comment
	right join Account
	on CommenterID=Account.ID
	left join ProfilePicture
	on ProfilePicture.AccountID= Account.ID
	where Comment.PostID=@postId
END

GO
/****** Object:  StoredProcedure [dbo].[GetFriendList]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFriendList]
	-- Add the parameters for the stored procedure here
	@accountId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select FullName, UserName from account where ID 
	in (select Friend2 from Friend where Friend1=@accountId) 
	or
	ID in (select Friend1 from Friend where Friend2=@accountId)
END

GO
/****** Object:  StoredProcedure [dbo].[GetLikers]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLikers]
	-- Add the parameters for the stored procedure here
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT FullName, UserName from Account
	where ID in(select AccountID from PostLike where PostID=@postId)
END

GO
/****** Object:  StoredProcedure [dbo].[GetProfileData]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProfileData] 
	-- Add the parameters for the stored procedure here
	@id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Post.*, Account.FullName, Account.UserName, ProfilePicture.ImageURL from Post 
	right join Account
	on Post.AccountID=Account.ID 
	left join ProfilePicture
	on ProfilePicture.AccountID=Account.ID
	where Post.AccountID  =@id
	order by DateCreated desc
END

GO
/****** Object:  StoredProcedure [dbo].[InsertLike]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertLike]
	-- Add the parameters for the stored procedure here
	@accountId uniqueidentifier,
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into PostLike values (@accountId, @postId)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertPost]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertPost]
	-- Add the parameters for the stored procedure here
	@accountId uniqueidentifier,
	@content nvarchar(max),
	@dateCreate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Post (AccountID, PostContent, DateCreated) values (@accountId, @content, @dateCreate)
	select Post.*, Account.FullName, Account.UserName, ProfilePicture.ImageURL from Post 
	right join Account
	on Post.AccountID=Account.ID 
	left join ProfilePicture
	on ProfilePicture.AccountID=Account.ID
	where Post.AccountID  =@accountId and Post.DateCreated=@dateCreate
END

GO
/****** Object:  StoredProcedure [dbo].[LikesCount]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LikesCount]
	-- Add the parameters for the stored procedure here
	@postId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select count(*) from PostLike 
	where PostID=@postId
END

GO
/****** Object:  StoredProcedure [dbo].[RejectRequest]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RejectRequest]
	-- Add the parameters for the stored procedure here
	@requestedId uniqueidentifier,
	@requesterUsername nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Request 
	where Requested=@requestedId and Requester = 
	(select ID from Account where UserName=@requesterUsername)
END

GO
/****** Object:  StoredProcedure [dbo].[SearchAccounts]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchAccounts]
	-- Add the parameters for the stored procedure here
	@Name nvarchar(50),
	@id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Account.FullName, Account.UserName, Account.ID, ProfilePicture.ImageURL, 
	Friend.RelationshipID, Request.*
	from Account
	left join ProfilePicture 
	on Account.ID=ProfilePicture.AccountID 
	left join Friend 
	on (Friend.Friend1=Account.ID and Friend2=@id) or (Friend1=@id and Friend2=Account.ID)
	left join Request
	on (Request.Requester=@id and Request.Requested=Account.ID) or (Request.Requester=Account.ID and Request.Requested=@id)
	where Account.FullName 
	like'%'+@Name+'%' and Account.ID !=@id
END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Role] [nchar](50) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommenterID] [uniqueidentifier] NOT NULL,
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
	[PostID] [int] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Friend]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friend](
	[RelationshipID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Friend1] [uniqueidentifier] NOT NULL,
	[Friend2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Friend_1] PRIMARY KEY CLUSTERED 
(
	[Friend1] ASC,
	[Friend2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Post]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[AccountID] [uniqueidentifier] NOT NULL,
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[PostContent] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostLike]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostLike](
	[AccountID] [uniqueidentifier] NOT NULL,
	[PostID] [int] NOT NULL,
 CONSTRAINT [PK_PostLike] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC,
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProfilePicture]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfilePicture](
	[ImageURL] [nvarchar](max) NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Request]    Script Date: 5/1/2018 1:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Requested] [uniqueidentifier] NOT NULL,
	[Requester] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[Requested] ASC,
	[Requester] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', N'QuembyPratt', N'81dc9bdb52d04dc20036dbd8313ed055', N'Quemby Pratt', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', N'SageKing', N'81dc9bdb52d04dc20036dbd8313ed055', N'Maryam Boone', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'MiraWoodward', N'81dc9bdb52d04dc20036dbd8313ed055', N'Leah Cash', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'BoCarroll', N'81dc9bdb52d04dc20036dbd8313ed055', N'Hayfa Atkins', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'67ab886f-641d-497c-b67a-1f943f151a49', N'CyrusWyatt', N'81dc9bdb52d04dc20036dbd8313ed055', N'Sharon Cannon', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', N'DylanStewart', N'81dc9bdb52d04dc20036dbd8313ed055', N'Barbara Finley', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'HallBush', N'81dc9bdb52d04dc20036dbd8313ed055', N'Kylan Nicholson', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'tester', N'81dc9bdb52d04dc20036dbd8313ed055', N'Test Tester', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', N'DevinConley', N'81dc9bdb52d04dc20036dbd8313ed055', N'Devin Conley', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'IngaJoyce', N'81dc9bdb52d04dc20036dbd8313ed055', N'Inga Joyce', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', N'EatonBurks', N'81dc9bdb52d04dc20036dbd8313ed055', N'Willow Mullen', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'KarleighHorn', N'81dc9bdb52d04dc20036dbd8313ed055', N'Karleigh Horn', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1', N'MalachiRosa', N'81dc9bdb52d04dc20036dbd8313ed055', N'Valentine Mccarty', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'28c848ac-8773-48da-9b69-512c47ded0bc', N'TroyPena', N'81dc9bdb52d04dc20036dbd8313ed055', N'Molly Holden', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'KylynnBurris', N'81dc9bdb52d04dc20036dbd8313ed055', N'Kylynn Burris', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'32d2df60-65b4-4746-bbbd-5896da1df168', N'MeghanSchneider', N'81dc9bdb52d04dc20036dbd8313ed055', N'Meghan Schneider', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'CharissaNash', N'81dc9bdb52d04dc20036dbd8313ed055', N'Charissa Nash', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'1d4f496b-9686-4757-a587-5eb2f141c917', N'OlegShort', N'81dc9bdb52d04dc20036dbd8313ed055', N'Orson Hardy', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'3f0b765f-23ef-4b03-9aeb-62a5d136e414', N'ShanaCarter', N'81dc9bdb52d04dc20036dbd8313ed055', N'Ali Mack', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'SusanDurham', N'81dc9bdb52d04dc20036dbd8313ed055', N'Knox Barnes', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', N'KennedyErickson', N'81dc9bdb52d04dc20036dbd8313ed055', N'Kennedy Erickson', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'a915e003-d477-4c40-a775-7524fa5629c4', N'VeraKnight', N'81dc9bdb52d04dc20036dbd8313ed055', N'Kenyon Williams', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'049b5813-feb9-412d-86b6-8533d5fd4b41', N'TroyJohnson', N'81dc9bdb52d04dc20036dbd8313ed055', N'Troy Johnson', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'bce63148-ec11-4994-950b-8ce1e8c28a3d', N'PalomaDonovan', N'81dc9bdb52d04dc20036dbd8313ed055', N'Uriel Carey', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'012ed0e8-41b2-45c8-9509-8e0b4fa7855b', N'ElijahNeal', N'81dc9bdb52d04dc20036dbd8313ed055', N'Elijah Neal', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'ba532487-08a2-4ae0-b2d2-96c654ba1869', N'EchoCooley', N'81dc9bdb52d04dc20036dbd8313ed055', N'Ocean Melendez', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'31725c57-0393-41d6-9c21-aeab7e55212f', N'EvelynCross', N'81dc9bdb52d04dc20036dbd8313ed055', N'Odessa Houston', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'b349110f-0208-458b-981e-b2018a0f35f1', N'NigelMacias', N'81dc9bdb52d04dc20036dbd8313ed055', N'Giselle Miranda', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', N'DonnaFry', N'81dc9bdb52d04dc20036dbd8313ed055', N'Jameson Stephens', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'96a21276-dba9-4980-bce2-d0fe753d8962', N'HeatherBerg', N'81dc9bdb52d04dc20036dbd8313ed055', N'Heather Berg', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'988b110f-ec61-4d21-bb49-d201cbb34e22', N'RyderBarry', N'81dc9bdb52d04dc20036dbd8313ed055', N'Ryder Barry', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'c68a8c83-c903-493f-b593-d366fb972b73', N'SerenaDickerson', N'81dc9bdb52d04dc20036dbd8313ed055', N'Aphrodite Colon', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'c545696d-35ec-4189-a448-da4c2318350d', N'HardingSchmidt', N'81dc9bdb52d04dc20036dbd8313ed055', N'Harding Schmidt', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'PaulaVargas', N'81dc9bdb52d04dc20036dbd8313ed055', N'Paula Vargas', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'4e2661f3-056a-4d26-a607-e5494852590b', N'EzekielKidd', N'81dc9bdb52d04dc20036dbd8313ed055', N'EzekielKidd', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'73719d8e-c79d-4bc3-9b3d-e55fd6e97f88', N'SavannahHewitt', N'81dc9bdb52d04dc20036dbd8313ed055', N'Savannah Hewitt', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'1a29fd03-2192-4093-9aad-ed2a60486805', N'LeroyCarlson', N'81dc9bdb52d04dc20036dbd8313ed055', N'Leroy Carlson', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'c8c56412-607f-44f7-9bc6-f0ba1afe3b71', N'AubreyClark', N'81dc9bdb52d04dc20036dbd8313ed055', N'Aubrey Clark', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'ff56f086-a4d3-4a03-be8a-f0f89c92841e', N'HallaPark', N'81dc9bdb52d04dc20036dbd8313ed055', N'Justine Owens', NULL)
INSERT [dbo].[Account] ([ID], [UserName], [Password], [FullName], [Role]) VALUES (N'a498641f-484b-43ac-81aa-fdf888edab69', N'HildaWong', N'81dc9bdb52d04dc20036dbd8313ed055', N'Hilda Wong', NULL)
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 1, N'ghcvbcv', 1)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2, N'nvbnvb', 1)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 1003, N'Total investment in renewable energy reached $244 billion in 2012. ', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 1004, N'Renewable energy is energy which comes from natural resources', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 1005, N'Viewing a locally hosted website with your smartphone', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 1006, N'ou should now be able to access those sites on your iPhone via the IPs, e.g', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2003, N'fgh', 9)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2005, N'vbcvbcv', 2045)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2006, N'gfhfgh', 2039)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2007, N'bnb', 9)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2008, N'gfgbfgn', 9)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2009, N'cbcn', 9)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2010, N'xc    bcv', 9)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2011, N'123456789', 2044)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2012, N'123456', 2044)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2013, N'123', 2044)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2014, N'1234', 2044)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'a498641f-484b-43ac-81aa-fdf888edab69', 2015, N'123', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'a498641f-484b-43ac-81aa-fdf888edab69', 2016, N'1234', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'a498641f-484b-43ac-81aa-fdf888edab69', 2017, N'1235', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'a498641f-484b-43ac-81aa-fdf888edab69', 2018, N'Boot to advanced startup options, and click/tap on Troubleshoot.', 2022)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 3011, N'Tattoo artist surprises girlfriend with permanently-inked proposal', 1)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 3012, N'Tattoo artist surprises girlfriend with permanently-inked proposal', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 3016, N'xdxbvbbxb', 2061)
INSERT [dbo].[Comment] ([CommenterID], [CommentID], [CommentContent], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 3017, N'xdxbvbbxb', 2062)
SET IDENTITY_INSERT [dbo].[Comment] OFF
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'00000000-0000-0000-0000-000000000000', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ffc3d4bb-a695-4b4c-8024-0235ae611c50', N'049b5813-feb9-412d-86b6-8533d5fd4b41', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'a18b9471-78b7-4e28-ad8f-0475d21b7719', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ffb5018b-4ab8-4e9e-a782-0623aa19b8f7', N'67ab886f-641d-497c-b67a-1f943f151a49', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ce8bb543-7057-4192-b4b7-07aad2870ead', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'1c086959-208d-45a3-9a6c-0916acb5afff', N'3f0b765f-23ef-4b03-9aeb-62a5d136e414', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'b18c344a-b078-4a42-a62e-0a8e115c281b', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'906425b3-cd4b-4c06-9547-0aaaf695b284', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8ba0f260-bc6a-4bf2-8d49-0cfa6b401a70', N'8138b581-1c82-4129-848f-0d4f14694f33', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ade4a880-da55-4f74-b1fd-0ebb001cd24e', N'96a21276-dba9-4980-bce2-d0fe753d8962', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ce046ce8-e3e8-4414-93bb-131f15bb57d0', N'a915e003-d477-4c40-a775-7524fa5629c4', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9f3471fa-8eeb-462e-aa5d-14ff007b7ad7', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'b8e2e275-9235-4795-847b-1553adb89387', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'4a5556f6-0a99-4cab-9c22-169974b33a58', N'012ed0e8-41b2-45c8-9509-8e0b4fa7855b', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2d65d7ea-ff59-49b8-b2d6-1b392c7cedf0', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'153e6e2e-0efd-4bda-8bfd-1c269a9591c9', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'fb3758cd-12d0-4099-974e-1e1aa5f15d74', N'96a21276-dba9-4980-bce2-d0fe753d8962', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'4897be4c-d6d5-4072-8589-1e97c671d589', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'80f8a98e-d7c5-406d-a1a0-1ea41d045b37', N'bce63148-ec11-4994-950b-8ce1e8c28a3d', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'30764923-8a23-404f-91dd-1edab93170de', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'49c62292-16d8-4688-91b9-2098fd3a5ba7', N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c8f5384f-3214-477d-b41e-2485307ca4a4', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'af53dfe9-4e98-4b0c-a1bc-2a8af877dcaf', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'fd3abb18-0d14-4bb5-8b7c-2ab789dae936', N'67ab886f-641d-497c-b67a-1f943f151a49', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'38fcff0f-5f9f-4254-9930-2e4ff8253ad4', N'049b5813-feb9-412d-86b6-8533d5fd4b41', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'192bd591-2218-4ad7-b199-38775f7536b7', N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'31b6f5c2-af5b-45fe-b22a-395c38d02aef', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e10f55e7-3aaf-45ce-a98e-3c8471989d1e', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e24bcbe5-0906-4cbc-a6e7-3d05ac9b5ec9', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'0ba61c44-6026-44e9-be2c-3dc6a2ef8936', N'a915e003-d477-4c40-a775-7524fa5629c4', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'50d3b2ad-a233-4ce8-b4ae-3de8a465a433', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'4e5d01cc-76dd-4f8e-ac64-3f54a6d99312', N'a915e003-d477-4c40-a775-7524fa5629c4', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'dc128dc6-9878-4e9d-85ca-4155ac7aee1f', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'cad8d309-1577-4f31-8707-416b00e73a39', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c2e4f639-ded4-40a8-92b4-41d2edc904a8', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'92f155f6-9a23-45f0-a575-42675ed8db15', N'31725c57-0393-41d6-9c21-aeab7e55212f', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8a2e5a63-05fc-484f-9d58-4344a22ddd08', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c89a9a62-5721-454b-9c68-4457c789dfc0', N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'd8bcf930-1548-4aaa-8f93-45f46ed776c2', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9b13d2ea-4d3f-47b6-9fde-4d45b1f4b85b', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'baf0e889-4ec1-428a-b866-503862cdc0d0', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2bea23e9-9d25-438f-b12b-50e645822e41', N'c545696d-35ec-4189-a448-da4c2318350d', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'f9876fee-f116-4a94-bdbd-514358df9565', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ac53b83e-838b-411f-af6e-52d26a417a89', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'325719fe-b1a5-4890-a9a9-5510951747e7', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'4f89990c-67f5-484c-9810-5ae69b53c2b5', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c874400a-1551-42fc-8f37-5e56748a0cfb', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'a48d4c06-c037-4baf-94ef-602ce51fe2d3', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'3d902234-ede1-48c1-ad51-6353357ffb80', N'049b5813-feb9-412d-86b6-8533d5fd4b41', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c35be742-dc8a-402c-a2a2-654d3ca7bb7a', N'8138b581-1c82-4129-848f-0d4f14694f33', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'6f8113a5-8128-4272-ac5b-65f448142038', N'8138b581-1c82-4129-848f-0d4f14694f33', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'396aa19f-c47c-4db8-9741-664a70e7ce2c', N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'dcd24f0a-2988-4c8e-9519-6a274ffa5b85', N'31725c57-0393-41d6-9c21-aeab7e55212f', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8239b830-5d35-4da5-9b47-6a4b807ce2b1', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2fadaf96-bc2a-41b2-917c-6b023460df01', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2db2dad5-252e-447c-9394-6ccac2f8b6e6', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e7eba904-47c3-417b-9a7d-6db7ee8045a0', N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'eab81fdf-f1fa-4ac6-a514-7011141174da', N'8138b581-1c82-4129-848f-0d4f14694f33', N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8caba409-914b-4569-b76f-72004d16117d', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'848401fb-000b-4b04-868c-72b0e1b675b2', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8806c688-b4d3-4b7d-8b66-735ce34afcc2', N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'faac674f-b2a5-4047-b14e-7534eae2d634', N'8138b581-1c82-4129-848f-0d4f14694f33', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9fa664c1-1f83-4513-9d20-75c028bffd4e', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e58f1789-e7c7-41fb-b59a-769879307c2e', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'3750ec61-9c75-4fb9-8a08-82b2c80b3c64', N'67ab886f-641d-497c-b67a-1f943f151a49', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'f7c4f7bd-5b68-4b44-bc4b-85d09f4ffbb6', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'24595c42-4de9-46b5-aba7-88c0c9e3cb84', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'41e7b35d-3358-4ba4-98cd-88f3ea74e65a', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'439535d9-8a0a-4717-8f5f-8a95c312c17c', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e28e8201-0337-4ab0-9643-8bc3725fd5c2', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ae18270f-0ce8-4d1f-9c29-8c762776a3d0', N'a915e003-d477-4c40-a775-7524fa5629c4', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'01f278fe-fbe9-4a02-bcb1-8cc67b5ca387', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'4b732d10-ad25-4210-998c-91a34dec3e62', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'a24c185c-9f3c-4b04-b57c-927b72d79418', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'697a66d1-9c71-4c47-a79e-9424dce8748c', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'83424083-f2df-46cc-8dab-96f9c8f698ce', N'8138b581-1c82-4129-848f-0d4f14694f33', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'5f60ea26-45db-4335-a339-97b53fc26502', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'5e9bac49-b895-4a7f-becd-9ac012909d6f', N'a915e003-d477-4c40-a775-7524fa5629c4', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'3f6c5fb4-8763-45c7-9e05-9c1142142412', N'a915e003-d477-4c40-a775-7524fa5629c4', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'57e8165e-70c8-4606-96e1-9ea85948ea9c', N'b349110f-0208-458b-981e-b2018a0f35f1', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2f319ae0-68fc-438f-a381-9ffc705c2764', N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ed3236e6-de75-4991-ba94-a493e9d443d7', N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'57ca3298-355b-4490-86db-a8de5a45be84', N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'04dfecfd-b01e-4cb2-8807-ab9709b4e54e', N'31725c57-0393-41d6-9c21-aeab7e55212f', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e2019718-a69f-4532-bad1-abb52efa345a', N'a915e003-d477-4c40-a775-7524fa5629c4', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9acba509-aae5-4afd-ba6f-acda0710668d', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'074ffebd-65a1-46e4-b685-acea252379dd', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8831d284-f81f-4b5d-b7ab-af04388ec328', N'67ab886f-641d-497c-b67a-1f943f151a49', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'42274e50-5553-47ae-a662-af7c266a78f8', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'191354de-3bad-4222-bb58-b006ee2b23a4', N'988b110f-ec61-4d21-bb49-d201cbb34e22', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'cab4f58d-59b6-4188-8418-b313a1b38173', N'bce63148-ec11-4994-950b-8ce1e8c28a3d', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'1c06b86a-d659-4c43-b66c-b4af35aff4e0', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'd22a8e06-8c5d-42f2-8720-b60c39709745', N'67ab886f-641d-497c-b67a-1f943f151a49', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'f253c36f-1136-4587-a92f-b61262c52eec', N'b349110f-0208-458b-981e-b2018a0f35f1', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'1c52cb3f-8c08-4fc4-b28a-b891823ac240', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'80d8106e-7b29-4893-bfb0-b9343491e1ea', N'c545696d-35ec-4189-a448-da4c2318350d', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'aa1bf85c-c1fa-49f2-92d0-bb43e1dbcc1c', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'516e0743-3d03-418f-a4d7-bc35af3191fd', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8978fc1c-3fe2-4c72-b603-bd02bdcfce2e', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'3948efac-5b48-4616-8281-bd6be782df9e', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'96a21276-dba9-4980-bce2-d0fe753d8962')
GO
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'b7c48078-9307-426b-9cbe-bf9624af8098', N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'35b67d1b-2723-4ec7-84bd-bfef812273ca', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'a498641f-484b-43ac-81aa-fdf888edab69')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'34368f4c-080a-43a7-960c-c73d2280b9e8', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'3a232918-e4b9-41ce-9297-cb99f82428b7', N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9f011de1-3316-4456-aa17-ccf0334e3380', N'96a21276-dba9-4980-bce2-d0fe753d8962', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'd7554a6b-5022-4f0f-a1c5-ceed37e1c772', N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'7b0ea2c4-72d2-4dfb-a076-d1f6dee84963', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'157f880e-d85a-4280-b357-d23414d6fe2f', N'8138b581-1c82-4129-848f-0d4f14694f33', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'be53dfc5-181b-428c-bf07-d288df2626aa', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'0887d806-ee07-4bd4-8c4a-d4dc7efc1560', N'67ab886f-641d-497c-b67a-1f943f151a49', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'b6156c6b-10fa-4a7a-bdf2-d5facda52bdd', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'83ad61ae-45c1-4716-bacf-dc7178af7ee2', N'96a21276-dba9-4980-bce2-d0fe753d8962', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'ae01d479-77cf-485f-9e92-de07eec8dd8d', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'258f6fe5-b164-4829-8965-6d79f2f804b4')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'7db4e2cd-4746-4db6-bb55-df0c62e7220e', N'b349110f-0208-458b-981e-b2018a0f35f1', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'dc884368-6da1-4db5-8403-df3170c58f09', N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'e59819b2-9dc0-4483-a265-dfa9e301bfab', N'1d4f496b-9686-4757-a587-5eb2f141c917', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c8984d1b-57bd-4c6f-8633-e000dce6afe3', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', N'ff56f086-a4d3-4a03-be8a-f0f89c92841e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'7ba78e89-a3f3-489f-83a7-e28b3e44a74a', N'31725c57-0393-41d6-9c21-aeab7e55212f', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'aff70545-bc1a-41c6-8f62-e5d1a2efa4d3', N'b349110f-0208-458b-981e-b2018a0f35f1', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'8e6778c6-2bdf-4183-a632-e61af8036210', N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'0ec6e614-ba20-44c4-b81f-e6a149d059ca', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'5d6b2d1f-dc61-4074-97b4-e6c667fda1d2', N'32d2df60-65b4-4746-bbbd-5896da1df168', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'57586188-6f32-42e0-9cd4-ea762a3f5cad', N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'616d8f9c-5e7b-4612-94af-edb07f49a273', N'e9c2104c-b069-4fe0-8357-32ad03dddb90', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'071d3286-0342-4acf-b845-ef13458a7468', N'3f0b765f-23ef-4b03-9aeb-62a5d136e414', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'2ce4010d-b816-4151-9d57-f088bc984208', N'ba532487-08a2-4ae0-b2d2-96c654ba1869', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'd118971c-3f3c-4bfe-a00e-f100ac99db39', N'049b5813-feb9-412d-86b6-8533d5fd4b41', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'03925c1e-00bd-473c-afc7-f11d4affa7a6', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'c9f75cfc-aec6-457a-8f8f-f2d4b98fde87', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'cb661514-9c19-49fd-8c3d-f30e91a1251c', N'b349110f-0208-458b-981e-b2018a0f35f1', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'0c8e1f11-6516-4269-a016-f321a9d50d66', N'b349110f-0208-458b-981e-b2018a0f35f1', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'788a1da5-04bb-4782-b80c-f3fd4116fe4b', N'd7d45e12-33db-419b-b83d-14d77bcf3227', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'd27b1c87-0874-4eba-9748-f433e2d507f6', N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'cea5b5e0-9b5a-420f-a8ee-f454d780e122', N'8138b581-1c82-4129-848f-0d4f14694f33', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'54a0de47-122e-42ad-9622-f64e1cfc443d', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9953ccff-457f-4bcb-a2da-fa28b6e31abd', N'5fafdd6d-b1e1-4456-ae88-16069ed28d7d', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'0c9ca0dd-4633-4bd5-86e8-fb206b353ba5', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'7c15a671-e5ab-4f9b-bfcd-fc33c0a6c059', N'b349110f-0208-458b-981e-b2018a0f35f1', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'577ecc1d-80d6-4889-992f-fd135f448e8c', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Friend] ([RelationshipID], [Friend1], [Friend2]) VALUES (N'9595e454-c1b3-4ed8-a864-fdf18794187c', N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 1, N'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy.', CAST(0x0000A63300000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 6, N'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don''t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn''t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable.', CAST(0x0000A52B00000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 7, N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ', CAST(0x0000A54800000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 9, N'Adding an Administrative User with the ASP.NET Configuration site', CAST(0x0000A72F00000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'e9c2104c-b069-4fe0-8357-32ad03dddb90', 14, N'Quot numquam cotidieque no mei. Ignota latine explicari per ad, ut molestie moderatius concludaturque eos. Cu dicit deserunt gloriatur cum, per in utamur labitur deterruisset. An autem pericula quo, nam ea sumo mazim concludaturque. Noster denique consectetuer vel et. Usu ut tale primis eleifend, ne sed nihil essent. Reque mollis evertitur ex sit.
', CAST(0x0000A5FE00000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 15, N' Ignota persecuti te usu. Ea nec volumus volutpat comprehensam, nam ad sint habeo. Qui graecis offendit ex, sumo noster no usu. Et qui aliquando intellegebat, nam ea nostrud expetendis.
', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'581e7ccd-d2c3-4668-a070-5669f77e4ed0', 16, N' Et tacimates intellegam eos. Facer etiam pertinax ut vis, mucius regione bonorum has ut, case vide delicata pri ea. Iisque reformidans nam id, qui idque ullum libris no. Vidisse diceret in vel.
', CAST(0x0000A32300000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'75a3be1a-115d-47d2-a0a5-4bff30ce97d1', 17, N' Esse tritani democritum id sed. Ne eum soleat probatus mnesarchum, te noluisse perfecto eam, mucius cetero eam et. Harum feugiat usu et. Inani altera vim.', CAST(0x0000A6BB00000000 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2011, N'All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet....', CAST(0x0000A6BB00CCF330 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2015, N'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English.', CAST(0x0000A6BC00E209E7 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2016, N'The International Space Station is the most expensive thing ever built.', CAST(0x0000A705002F332B AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2018, N'AJAX is a technique for accessing web servers from a web page.

', CAST(0x0000A7090138C0DA AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2021, N'AJAX stands for Asyncronous JavaScript And XML.', CAST(0x0000A70A01393B08 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2022, N'Create a simple XMLHttpRequest, and retrieve data from a TXT file.

', CAST(0x0000A70B00E2DA77 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', 2023, N'Hello Developers, We are back with a new android firebase tutorial. This time we will discuss about Firebase Cloud Messaging (FCM)', CAST(0x0000A70C00F969D1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', 2024, N'Android push notification using Firebase Cloud Messaging Tutorial. In this post we ... In this post we will use FCM (Firebase Cloud Messaging).', CAST(0x0000A70C00F97DC6 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', 2025, N'ohnny Depp once mooned his teacher while in high school.', CAST(0x0000A70C00F98E00 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e', 2026, N'We can use a http/xmpp server to send the message to the FCM server but in our tutorial we use the handy tool provided by the FCM guys', CAST(0x0000A70C00F99E96 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2027, N'Finally, be strong in the Lord and in the strength of His might. -Ephesians 6:10', CAST(0x0000A70C00FA6EE0 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2028, N'Several recent studies show that chickens have self-control, distinct personalities, and the ability to logically reason.', CAST(0x0000A70C00FA7DD3 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2029, N'Today''s Relationships: You can touch each other but not each others phones.', CAST(0x0000A70C00FA88F1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2030, N'Worry increases pressure; prayer releases peace.', CAST(0x0000A70C00FAC1D4 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2031, N'Been given a baby goat for my office. Struggling to think of a name.', CAST(0x0000A70C00FADB71 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'67ab886f-641d-497c-b67a-1f943f151a49', 2032, N'This tutorial will help you to set up the skeleton for sending and receiving push notifications via FCM with instructions on server code.', CAST(0x0000A70C00FB9B63 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'67ab886f-641d-497c-b67a-1f943f151a49', 2033, N'In this tutorial, we will see how to configure and use Firebase Cloud ... Please note, implementing FCM requires android.permission.INTERNET', CAST(0x0000A70C00FBACBF AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'67ab886f-641d-497c-b67a-1f943f151a49', 2034, N'Collection of basic to advanced Android tutorials along with full source code at ... Android Push Notifications using Firebase Cloud Messaging FCM & PHP', CAST(0x0000A70C00FBBBE8 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', 2035, N'At its center, the Hiroshima nuclear explosion was estimated to be 300,000°C—over 300 times hotter than what it takes to cremate a body.', CAST(0x0000A70C00FC5FAE AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f77dc6d7-2306-4a79-8409-2bcfdb10dc18', 2036, N'Android provides many kinds of storage for applications to store their data. These storage places are shared preferences, internal and external storage, SQLite storage, and storage via network connection.', CAST(0x0000A70C00FC77E5 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', 2037, N'In this chapter we are going to look at the internal storage. Internal storage is the storage of the private data on the device memory.', CAST(0x0000A70C00FD4A62 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ca105ab0-ddaf-4e30-b1f6-444a89a6e5f5', 2038, N'By default these files are private and are accessed by only your application and get deleted , when user delete your application.', CAST(0x0000A70C00FD535F AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'32d2df60-65b4-4746-bbbd-5896da1df168', 2039, N'In order to use internal storage to write some data in the file, call the openFileOutput() method with the name of the file and the mode.', CAST(0x0000A70C00FE3753 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'32d2df60-65b4-4746-bbbd-5896da1df168', 2040, N'After that, you can call read method to read one character at a time from the file and then you can print it', CAST(0x0000A70C00FE4A84 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ad74e886-5dda-4e10-970f-5d61b54b803c', 2041, N'Apart from the the methods of write and close, there are other methods provided by the FileOutputStream class for better writing files.', CAST(0x0000A70C00FE7D81 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ad74e886-5dda-4e10-970f-5d61b54b803c', 2042, N'This method constructs a new FileOutputStream that writes to file.', CAST(0x0000A70C00FE9205 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'3f0b765f-23ef-4b03-9aeb-62a5d136e414', 2043, N'May the grace of the Lord Jesus Christ, & the love of God, & the fellowship of the Holy Spirit be with you all. -2Cor 13:14', CAST(0x0000A70C00FEE8DE AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'258f6fe5-b164-4829-8965-6d79f2f804b4', 2044, N'This method returns a write-only FileChannel that shares its position with this stream', CAST(0x0000A70C00FF46A8 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'258f6fe5-b164-4829-8965-6d79f2f804b4', 2045, N'This method returns the underlying file descriptor', CAST(0x0000A70C00FF502A AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', 2046, N'This method Writes count bytes from the byte array buffer starting at position offset to this stream', CAST(0x0000A70C00FF79EF AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', 2047, N'This method returns an estimated number of bytes that can be read or skipped without blocking for more input', CAST(0x0000A70C00FF87B1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'a915e003-d477-4c40-a775-7524fa5629c4', 2048, N'This method returns a read-only FileChannel that shares its position with this stream', CAST(0x0000A70C00FFAF6A AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'a915e003-d477-4c40-a775-7524fa5629c4', 2049, N'This method returns the underlying file descriptor

', CAST(0x0000A70C00FFB80C AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'049b5813-feb9-412d-86b6-8533d5fd4b41', 2050, N'This method reads at most length bytes from this stream and stores them in the byte array b starting at offset

', CAST(0x0000A70C00FFDD04 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'bce63148-ec11-4994-950b-8ce1e8c28a3d', 2051, N'Here is an example demonstrating the use of internal storage to store and read files. It creates a basic storage application that allows you to read and write from internal storage.

', CAST(0x0000A70C00FFFF04 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'bce63148-ec11-4994-950b-8ce1e8c28a3d', 2052, N'To experiment with this example, you can run this on an actual device or in an emulator.

', CAST(0x0000A70C01000779 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ba532487-08a2-4ae0-b2d2-96c654ba1869', 2053, N'You will use Android Studio IDE to create an Android application under a package com.example.sairamkrishna.myapplication.
', CAST(0x0000A70C01003ADD AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'ba532487-08a2-4ae0-b2d2-96c654ba1869', 2054, N'What Comic Artists Look Like In Real Life [Part 2]', CAST(0x0000A70C01004A10 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'31725c57-0393-41d6-9c21-aeab7e55212f', 2055, N'Modify src/MainActivity.java file to add necessary code.
', CAST(0x0000A70C01006FB1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'31725c57-0393-41d6-9c21-aeab7e55212f', 2056, N'Modify the res/layout/activity_main to add respective XML components
', CAST(0x0000A70C010076E0 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'b349110f-0208-458b-981e-b2018a0f35f1', 2057, N'Run the application and choose a running android device and install the application on it and verify the results
', CAST(0x0000A70C0100A999 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'b349110f-0208-458b-981e-b2018a0f35f1', 2058, N'Following is the content of the modified main activity file src/MainActivity.java.

', CAST(0x0000A70C0100B5A6 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', 2059, N'Let''s try to run our Storage application we just modified.', CAST(0x0000A70C01010EAF AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf', 2060, N'I assume you had created your AVD while doing environment setup.', CAST(0x0000A70C01011A30 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2061, N'Proof—a wearable electrochemical sensor—connects with an app to measure your blood alcohol levels and let you know when it''s safe to drive.', CAST(0x0000A70C010528F1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2062, N'Tattoo artist surprises girlfriend with permanently-inked proposal.', CAST(0x0000A7A70145339F AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2066, N'These raccoons entertain tourists in cafes, but they''d be so much happier in the wild.', CAST(0x0000A7B0016C5C36 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2067, N'Be strong and of good courage, do not fear... for it is the Lord your God who goes with you. -Deuteronomy 31.6', CAST(0x0000A7B0016D9836 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2070, N'The sum of all the numbers on a roulette wheel is 666.', CAST(0x0000A7B00171BDB1 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'e9c2104c-b069-4fe0-8357-32ad03dddb90', 2072, N'In 1989, a new blockbuster store was opening in America every 17 hours.', CAST(0x0000A7B0017CA899 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'e9c2104c-b069-4fe0-8357-32ad03dddb90', 2075, N'In 1989, a new blockbuster store was opening in America every 17 hours.', CAST(0x0000A7B00183CFA4 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2077, N'In 1989, a new blockbuster store was opening in America every 17 hours.', CAST(0x0000A7B00184B37B AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2079, N'Researchers from NASA say the perfect nap lasts for 26 minutes.', CAST(0x0000A7B100E6789C AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 2080, N'Steve Carell would try to make his family laugh when he was younger by dressing up as an alien and then sitting at the dinner table.', CAST(0x0000A83400FEE859 AS DateTime))
INSERT [dbo].[Post] ([AccountID], [PostID], [PostContent], [DateCreated]) VALUES (N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', 3081, N'Out in the garden, the moon seems very bright, Six saintly shrouded men move across the lawn slowly The seventh walks in front with a cross held high in hand.', CAST(0x0000A8CB017D6F6F AS DateTime))
SET IDENTITY_INSERT [dbo].[Post] OFF
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 1)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 6)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 9)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2034)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2037)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2038)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2057)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2058)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2061)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8138b581-1c82-4129-848f-0d4f14694f33', 2062)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 9)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2060)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2061)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'1cdd324b-67be-4ade-a3c9-12d1caa03a72', 2062)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 1)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 6)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 7)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 9)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 14)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 15)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2022)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2036)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2045)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2079)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab', 2080)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 9)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 2059)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 2060)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 2061)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'6b9e719e-7611-4811-a204-2f044a6cf451', 2062)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2062)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2066)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', 2077)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'96a21276-dba9-4980-bce2-d0fe753d8962', 2030)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'96a21276-dba9-4980-bce2-d0fe753d8962', 2031)
INSERT [dbo].[PostLike] ([AccountID], [PostID]) VALUES (N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', 2034)
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/8138b581-1c82-4129-848f-0d4f14694f33cover.jpg', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/1cdd324b-67be-4ade-a3c9-12d1caa03a72cover.jpg', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/f53a8ae1-f32b-4403-b87b-2ebe404d11abCover.jpg', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/6b9e719e-7611-4811-a204-2f044a6cf451Caspian - The Four Trees.jpg', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/e9c2104c-b069-4fe0-8357-32ad03dddb90ef-delusionsdegrandeur.png', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/dcb126fc-79d2-4ff3-8f0f-c019c0de0edfFoldr.jpg', N'dcb126fc-79d2-4ff3-8f0f-c019c0de0edf')
INSERT [dbo].[ProfilePicture] ([ImageURL], [AccountID]) VALUES (N'/Images/8518c092-885f-4da9-a6af-e0fe0a2aa37eCover.jpg', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'7c4c5714-83fe-41ce-a681-9dd0ab15495c', N'8138b581-1c82-4129-848f-0d4f14694f33', N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'9501f2d9-3dd5-484a-9f5a-a1080587d766', N'0e14889d-f80e-4f58-bf58-33fda8c55fb1', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'e68194c7-f63c-4e13-8ef6-073777052145', N'28c848ac-8773-48da-9b69-512c47ded0bc', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'50a44c35-0a58-4f2b-8880-70486b9c664e', N'ad74e886-5dda-4e10-970f-5d61b54b803c', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'b340ea04-e8ae-4444-b7a8-d52e9b1ca25e', N'258f6fe5-b164-4829-8965-6d79f2f804b4', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'99c34956-60f2-4408-9518-b391d2bde03e', N'e5d9faa7-4c16-43f8-b32e-6ff95c72aa7d', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'fdfad720-ed7d-4b87-8255-f7d3d901bb92', N'012ed0e8-41b2-45c8-9509-8e0b4fa7855b', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'0bcfe694-3054-48d9-91e9-9c4de4d9e75b', N'ba532487-08a2-4ae0-b2d2-96c654ba1869', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'38bc9cec-b724-4c7e-8842-0527f1d06f33', N'c68a8c83-c903-493f-b593-d366fb972b73', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'ded0e133-27c1-42b5-a059-47d20d099270', N'c545696d-35ec-4189-a448-da4c2318350d', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'd3b4edf5-57e4-4409-8281-6ee82ae63309', N'c545696d-35ec-4189-a448-da4c2318350d', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'48eb3e40-0880-4259-b6a5-3b3ecd14124d', N'c545696d-35ec-4189-a448-da4c2318350d', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'0452b4d2-005e-4d01-8110-f24be563bb49', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'93344d9b-060a-445e-b490-2987ad546b30', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'f53a8ae1-f32b-4403-b87b-2ebe404d11ab')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'c92b7c4d-5c37-472d-98d6-4e7c124fb1b3', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'04e065e4-303f-4fb3-a0c8-1655682ce2f0', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'b87f9e0a-a504-48b7-85ee-c15fa085ce8d', N'8518c092-885f-4da9-a6af-e0fe0a2aa37e', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'55a873b6-1952-492b-8d99-a19feafda797', N'73719d8e-c79d-4bc3-9b3d-e55fd6e97f88', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'86c23e4b-9d43-4ffa-983b-587c26753494', N'1a29fd03-2192-4093-9aad-ed2a60486805', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'609dde36-fa68-42e1-9c47-f4d4f8b75d38', N'1a29fd03-2192-4093-9aad-ed2a60486805', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'bb5b19f9-8d45-47fd-ab2a-feb81332fec6', N'1a29fd03-2192-4093-9aad-ed2a60486805', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'f7996ac3-5a54-4ba9-a3bf-4a47bbcc1fce', N'c8c56412-607f-44f7-9bc6-f0ba1afe3b71', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'5a6353ef-04da-49ca-8c9c-e60665474f0b', N'c8c56412-607f-44f7-9bc6-f0ba1afe3b71', N'6b9e719e-7611-4811-a204-2f044a6cf451')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'e74ad2bd-cb66-4b2c-820c-b197aaca07d9', N'ff56f086-a4d3-4a03-be8a-f0f89c92841e', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'7084f373-4998-4614-acec-41f45fe06b8e', N'ff56f086-a4d3-4a03-be8a-f0f89c92841e', N'ee3bd5d6-683c-4f10-8f2f-214975c36f2e')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'1e3ae4f1-0174-4ce1-8037-3cb43a75a864', N'ff56f086-a4d3-4a03-be8a-f0f89c92841e', N'e9c2104c-b069-4fe0-8357-32ad03dddb90')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'32dc13a8-1a25-41c3-8ce9-53a73944de94', N'ff56f086-a4d3-4a03-be8a-f0f89c92841e', N'96a21276-dba9-4980-bce2-d0fe753d8962')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'221aaec8-72fe-44d9-8751-1ce744e8b688', N'a498641f-484b-43ac-81aa-fdf888edab69', N'8138b581-1c82-4129-848f-0d4f14694f33')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'c83b2188-9f72-427e-8a12-b65758a111f6', N'a498641f-484b-43ac-81aa-fdf888edab69', N'1cdd324b-67be-4ade-a3c9-12d1caa03a72')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'0052544b-7293-4f41-bf34-b55fa5a7204e', N'a498641f-484b-43ac-81aa-fdf888edab69', N'd7d45e12-33db-419b-b83d-14d77bcf3227')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'47da29f4-57bf-41bd-8492-2c66d5808e54', N'a498641f-484b-43ac-81aa-fdf888edab69', N'67ab886f-641d-497c-b67a-1f943f151a49')
INSERT [dbo].[Request] ([RequestID], [Requested], [Requester]) VALUES (N'd81e359f-c672-419b-a8e9-67812301b3a4', N'a498641f-484b-43ac-81aa-fdf888edab69', N'96a21276-dba9-4980-bce2-d0fe753d8962')
/****** Object:  Index [UQ__Friend__31FEB8600F7AAA6B]    Script Date: 5/1/2018 1:32:46 PM ******/
ALTER TABLE [dbo].[Friend] ADD UNIQUE NONCLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Friend__31FEB8608C30815A]    Script Date: 5/1/2018 1:32:46 PM ******/
ALTER TABLE [dbo].[Friend] ADD UNIQUE NONCLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Post]    Script Date: 5/1/2018 1:32:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_Post] ON [dbo].[Post]
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_ID]  DEFAULT (newsequentialid()) FOR [ID]
GO
ALTER TABLE [dbo].[Friend] ADD  CONSTRAINT [DF_Friend_RelationshipID]  DEFAULT (newid()) FOR [RelationshipID]
GO
ALTER TABLE [dbo].[Request] ADD  CONSTRAINT [DF_Request_RequestID]  DEFAULT (newid()) FOR [RequestID]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Account] FOREIGN KEY([CommenterID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Account]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [FK_Friend_Account] FOREIGN KEY([Friend1])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [FK_Friend_Account]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [FK_Friend_Account1] FOREIGN KEY([Friend2])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [FK_Friend_Account1]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Account]
GO
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_Account]
GO
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_Post]
GO
ALTER TABLE [dbo].[ProfilePicture]  WITH CHECK ADD  CONSTRAINT [FK_ProfilePicture_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[ProfilePicture] CHECK CONSTRAINT [FK_ProfilePicture_Account]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Account] FOREIGN KEY([Requested])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_Account]
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Account1] FOREIGN KEY([Requester])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_Account1]
GO
USE [master]
GO
ALTER DATABASE [SocialWebsite] SET  READ_WRITE 
GO
