CREATE TABLE [dbo].[tbl_Delivery] (
    [DeliveryID]       INT          NOT NULL,
    [BillHdrID]        INT          NULL,
    [ExecutiveId]      INT          NULL,
    [DeliveryDateTime] DATETIME     NULL,
    [Received]         FLOAT (53)   NULL,
    [Status]           VARCHAR (20) NULL
);


GO

