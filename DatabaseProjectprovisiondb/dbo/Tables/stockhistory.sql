CREATE TABLE [dbo].[stockhistory] (
    [iid]       INT        NOT NULL,
    [stockdate] DATETIME   NOT NULL,
    [qty]       FLOAT (53) NOT NULL,
    [cost]      FLOAT (53) NULL,
    CONSTRAINT [PK_stockhistory] PRIMARY KEY CLUSTERED ([iid] ASC, [stockdate] ASC)
);


GO

