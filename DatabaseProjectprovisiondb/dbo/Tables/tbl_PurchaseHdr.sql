CREATE TABLE [dbo].[tbl_PurchaseHdr] (
    [PurchaseHdrID]     INT        NOT NULL,
    [PurchaseDate]      DATE       NULL,
    [StockInDate]       DATE       NULL,
    [Bag]               INT        NULL,
    [Oil]               INT        NULL,
    [AttaSugar]         INT        NULL,
    [Amount]            FLOAT (53) NULL,
    [PurchaseHdrHistID] INT        NULL
);


GO

