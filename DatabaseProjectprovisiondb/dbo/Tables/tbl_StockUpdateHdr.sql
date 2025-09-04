CREATE TABLE [dbo].[tbl_StockUpdateHdr] (
    [StockUpdateHdrID] INT        NOT NULL,
    [StockUpdateDate]  DATE       NULL,
    [TotalCount]       INT        NULL,
    [TakenCount]       INT        NULL,
    [BagCount]         INT        NULL,
    [LooseCount]       FLOAT (53) NULL,
    [BagDiff]          INT        NULL,
    [LooseDiff]        FLOAT (53) NULL
);


GO

