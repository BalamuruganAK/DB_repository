CREATE TABLE [dbo].[tbl_Stock] (
    [StockID] TINYINT      NOT NULL,
    [Stock]   VARCHAR (50) NULL,
    [Sector]  VARCHAR (50) NULL,
    [Planets] VARCHAR (50) NULL,
    [Active]  TINYINT      NULL,
    CONSTRAINT [PK_tbl_Stock] PRIMARY KEY CLUSTERED ([StockID] ASC)
);


GO

