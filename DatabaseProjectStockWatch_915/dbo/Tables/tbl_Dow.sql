CREATE TABLE [dbo].[tbl_Dow] (
    [DowId]     SMALLINT      NOT NULL,
    [DowDesc]   NVARCHAR (50) NULL,
    [DowSymbol] NVARCHAR (10) NULL,
    CONSTRAINT [PK_tbl_Dow] PRIMARY KEY CLUSTERED ([DowId] ASC)
);


GO

