CREATE TABLE [dbo].[stockupdatehdr] (
    [stockupdatehdrid] INT        NOT NULL,
    [stockupdatedate]  DATETIME   NULL,
    [totalcount]       INT        NULL,
    [takencount]       INT        NULL,
    [actual]           FLOAT (53) NULL,
    [available]        FLOAT (53) NULL,
    [diff]             FLOAT (53) NULL,
    [actualcost]       FLOAT (53) NULL,
    [diffcost]         FLOAT (53) NULL
);


GO

