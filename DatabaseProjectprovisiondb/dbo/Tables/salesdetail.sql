CREATE TABLE [dbo].[salesdetail] (
    [sid]      INT        NOT NULL,
    [sdid]     INT        NOT NULL,
    [iid]      INT        NOT NULL,
    [price]    FLOAT (53) NOT NULL,
    [discount] FLOAT (53) NULL,
    [rate]     FLOAT (53) NULL,
    [qty]      FLOAT (53) NOT NULL,
    [amt]      FLOAT (53) NOT NULL,
    CONSTRAINT [PK_salesdetail] PRIMARY KEY CLUSTERED ([sid] ASC, [sdid] ASC)
);


GO

