CREATE TABLE [dbo].[tbl_BillDtl] (
    [BillDtlID] INT          NOT NULL,
    [BillHdrID] INT          NULL,
    [Item]      FLOAT (53)   NULL,
    [Quantity]  FLOAT (53)   NULL,
    [Discount]  FLOAT (53)   NULL,
    [Offer]     VARCHAR (20) NULL,
    [Amount]    FLOAT (53)   NULL
);


GO

