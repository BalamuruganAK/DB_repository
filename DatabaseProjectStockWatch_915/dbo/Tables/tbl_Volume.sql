CREATE TABLE [dbo].[tbl_Volume] (
    [Planet]          TINYINT       NOT NULL,
    [Retro]           TINYINT       NOT NULL,
    [Nature]          TINYINT       NULL,
    [NatureDesc]      NVARCHAR (20) NULL,
    [NatureShortDesc] NCHAR (3)     NULL,
    CONSTRAINT [PK_tbl_BBNature] PRIMARY KEY CLUSTERED ([Planet] ASC, [Retro] ASC)
);


GO

