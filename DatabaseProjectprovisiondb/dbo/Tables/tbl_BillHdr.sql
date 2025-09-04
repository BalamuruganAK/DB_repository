CREATE TABLE [dbo].[tbl_BillHdr] (
    [BillHdrID]        INT        NOT NULL,
    [BillDateTime]     DATETIME   NULL,
    [ExecutiveId]      INT        NULL,
    [Phone]            BIGINT     NULL,
    [TotalAmount]      FLOAT (53) NULL,
    [Adjustment]       FLOAT (53) NULL,
    [Cash]             FLOAT (53) NULL,
    [SwipeCard]        FLOAT (53) NULL,
    [OnDelivery]       FLOAT (53) NULL,
    [TotalDuePaid]     FLOAT (53) NULL,
    [Due]              INT        NULL,
    [DeliveryRequired] INT        NULL,
    [Cancel]           INT        NULL
);


GO

