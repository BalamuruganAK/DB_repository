CREATE TABLE [dbo].[Inventory] (
    [iid]                  INT        NOT NULL,
    [bufferstock]          FLOAT (53) NOT NULL,
    [averageorderquantity] FLOAT (53) NULL,
    [ordercost]            FLOAT (53) NULL,
    [orderfrequencydays]   INT        NULL,
    [nextorderday]         INT        NULL,
    [nostockdays]          INT        NULL,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED ([iid] ASC)
);


GO

