CREATE TABLE [dbo].[balancesheet] (
    [bsdate]       DATETIME   NOT NULL,
    [capital]      FLOAT (53) NULL,
    [asset]        FLOAT (53) NULL,
    [stockvalue]   FLOAT (53) NULL,
    [salesrevenue] FLOAT (53) NULL,
    [receivable]   FLOAT (53) NULL,
    [expenses]     FLOAT (53) NULL,
    [cash]         FLOAT (53) NULL,
    CONSTRAINT [PK_balancesheet] PRIMARY KEY CLUSTERED ([bsdate] ASC)
);


GO

