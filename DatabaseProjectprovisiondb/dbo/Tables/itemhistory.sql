CREATE TABLE [dbo].[itemhistory] (
    [iid]      INT           NOT NULL,
    [idate]    DATETIME      NOT NULL,
    [iname]    VARCHAR (100) NOT NULL,
    [quantity] FLOAT (53)    NULL,
    [price]    FLOAT (53)    NOT NULL,
    [discount] FLOAT (53)    NULL,
    [piid]     INT           NULL,
    [cid]      INT           NOT NULL,
    CONSTRAINT [PK_itemhistory] PRIMARY KEY CLUSTERED ([iid] ASC, [idate] ASC)
);


GO

