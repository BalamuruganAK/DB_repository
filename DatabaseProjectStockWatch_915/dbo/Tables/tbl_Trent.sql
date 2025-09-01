CREATE TABLE [dbo].[tbl_Trent] (
    [Position]       TINYINT       NOT NULL,
    [Trent]          TINYINT       NULL,
    [Direction]      NVARCHAR (10) NULL,
    [ShortDirection] NCHAR (1)     NULL,
    CONSTRAINT [PK_tbl_Trent] PRIMARY KEY CLUSTERED ([Position] ASC)
);


GO

