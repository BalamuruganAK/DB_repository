CREATE TABLE [dbo].[stockupdatedetail] (
    [stockupdatehdrid] INT           NOT NULL,
    [stockupdatedtlid] INT           NOT NULL,
    [stockupdatedate]  DATETIME      NULL,
    [iid]              INT           NULL,
    [actual]           FLOAT (53)    NULL,
    [available]        FLOAT (53)    NULL,
    [diff]             FLOAT (53)    NULL,
    [reason]           VARCHAR (150) NULL
);


GO

