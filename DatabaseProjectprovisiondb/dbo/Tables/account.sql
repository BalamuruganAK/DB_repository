CREATE TABLE [dbo].[account] (
    [cid]         INT          NOT NULL,
    [adate]       DATETIME     NOT NULL,
    [transaction] VARCHAR (10) NOT NULL,
    [sid]         INT          NULL,
    [amt]         FLOAT (53)   NOT NULL,
    [accbalance]  FLOAT (53)   NOT NULL,
    [eid]         INT          NULL,
    [cancel]      INT          NULL
);


GO

