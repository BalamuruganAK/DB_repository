CREATE TABLE [dbo].[sales] (
    [sid]          INT        NOT NULL,
    [sdate]        DATETIME   NOT NULL,
    [total]        FLOAT (53) NOT NULL,
    [discount]     FLOAT (53) NULL,
    [amt]          FLOAT (53) NOT NULL,
    [cash]         FLOAT (53) NULL,
    [gpay]         FLOAT (53) NULL,
    [cards]        FLOAT (53) NULL,
    [salesbalance] FLOAT (53) NULL,
    [phone]        BIGINT     NULL,
    [cancel]       INT        NULL,
    [eid]          INT        NULL,
    CONSTRAINT [PK_sales] PRIMARY KEY CLUSTERED ([sid] ASC)
);


GO

