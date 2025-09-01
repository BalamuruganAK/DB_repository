CREATE TABLE [dbo].[tbl_Candle] (
    [CandleId]     SMALLINT      NOT NULL,
    [CandleDesc]   NVARCHAR (50) NULL,
    [CandleSymbol] NVARCHAR (10) NULL,
    CONSTRAINT [PK_tbl_Candle] PRIMARY KEY CLUSTERED ([CandleId] ASC)
);


GO

