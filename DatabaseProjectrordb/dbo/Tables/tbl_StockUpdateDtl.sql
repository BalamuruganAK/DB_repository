CREATE TABLE [dbo].[tbl_StockUpdateDtl] (
    [StockUpdateDtlID]    INT          NOT NULL,
    [StockUpdateHdrID]    INT          NULL,
    [StockUpdateDate]     DATE         NULL,
    [StockUpdateDateTime] DATETIME     NULL,
    [Rate]                FLOAT (53)   NULL,
    [Bag]                 INT          NULL,
    [Loose]               FLOAT (53)   NULL,
    [AvailableBag]        INT          NULL,
    [AvailableLoose]      FLOAT (53)   NULL,
    [DifferenceBag]       INT          NULL,
    [DifferenceLoose]     FLOAT (53)   NULL,
    [ExecutiveId]         INT          NULL,
    [Reason]              VARCHAR (50) NULL
);


GO

