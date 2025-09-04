CREATE TABLE [dbo].[stock] (
    [iid]  INT        NOT NULL,
    [qty]  FLOAT (53) NOT NULL,
    [cost] FLOAT (53) NULL,
    CONSTRAINT [PK_stock] PRIMARY KEY CLUSTERED ([iid] ASC)
);


GO

