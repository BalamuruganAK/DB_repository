CREATE TABLE [dbo].[tbl_Retro] (
    [FPDate] SMALLDATETIME NOT NULL,
    [Planet] TINYINT       NOT NULL,
    [TPDate] SMALLDATETIME NULL,
    CONSTRAINT [PK_tbl_Retro] PRIMARY KEY CLUSTERED ([FPDate] ASC, [Planet] ASC)
);


GO

