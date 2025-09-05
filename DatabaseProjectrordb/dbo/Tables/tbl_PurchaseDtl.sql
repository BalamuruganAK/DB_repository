CREATE TABLE [dbo].[tbl_PurchaseDtl] (
    [PurchaseDtlID] INT          NOT NULL,
    [PurchaseHdrID] INT          NULL,
    [Rate]          FLOAT (53)   NULL,
    [Brand]         VARCHAR (20) NULL,
    [Quantity]      INT          NULL,
    [UnitSize]      INT          NULL,
    [Price]         FLOAT (53)   NULL,
    [Amount]        FLOAT (53)   NULL
);


GO

