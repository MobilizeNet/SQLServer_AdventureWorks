SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[Illustration]') AND type in (N'U'))
BEGIN
CREATE TABLE [Production].[Illustration](
	[IllustrationID] [int] IDENTITY(1,1) NOT NULL,
	[Diagram] [xml] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Illustration_IllustrationID] PRIMARY KEY CLUSTERED 
(
	[IllustrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_Illustration_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[Illustration] ADD  CONSTRAINT [DF_Illustration_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
