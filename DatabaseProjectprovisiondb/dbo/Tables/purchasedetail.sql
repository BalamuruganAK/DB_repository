CREATE TABLE [dbo].[purchasedetail] (
    [pid]  INT        NOT NULL,
    [pdid] INT        NOT NULL,
    [iid]  INT        NOT NULL,
    [qty]  FLOAT (53) NOT NULL,
    [amt]  FLOAT (53) NOT NULL,
    [cost] FLOAT (53) NULL,
    CONSTRAINT [PK_purchasedetail] PRIMARY KEY CLUSTERED ([pid] ASC, [pdid] ASC)
);


GO

