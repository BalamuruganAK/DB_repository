CREATE TABLE [dbo].[cashbalance] (
    [cbid]          INT        NOT NULL,
    [cbdate]        DATETIME   NULL,
    [openbalance]   FLOAT (53) NULL,
    [cashfromsales] FLOAT (53) NULL,
    [purchase]      FLOAT (53) NULL,
    [expensesnonm]  FLOAT (53) NULL,
    [closebalance]  FLOAT (53) NULL,
    CONSTRAINT [PK_casebalance] PRIMARY KEY CLUSTERED ([cbid] ASC)
);


GO

