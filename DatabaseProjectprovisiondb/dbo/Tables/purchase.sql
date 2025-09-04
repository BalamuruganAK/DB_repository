CREATE TABLE [dbo].[purchase] (
    [pid]     INT        NOT NULL,
    [pdate]   DATETIME   NOT NULL,
    [amt]     FLOAT (53) NOT NULL,
    [eid]     INT        NULL,
    [phistid] INT        NULL,
    CONSTRAINT [PK_purchase] PRIMARY KEY CLUSTERED ([pid] ASC)
);


GO

