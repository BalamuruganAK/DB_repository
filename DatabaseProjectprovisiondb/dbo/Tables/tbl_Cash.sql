CREATE TABLE [dbo].[tbl_Cash] (
    [CashID]        INT          NOT NULL,
    [CashDateTime]  DATETIME     NULL,
    [ExecutiveId]   INT          NULL,
    [Thousand]      INT          NULL,
    [FiveHundrad]   INT          NULL,
    [Hundrad]       INT          NULL,
    [Fifty]         INT          NULL,
    [Twenty]        INT          NULL,
    [Ten]           INT          NULL,
    [Five]          INT          NULL,
    [Two]           INT          NULL,
    [One]           INT          NULL,
    [Opening]       FLOAT (53)   NULL,
    [Sales]         FLOAT (53)   NULL,
    [Expense]       FLOAT (53)   NULL,
    [Net]           FLOAT (53)   NULL,
    [Card]          FLOAT (53)   NULL,
    [GPay]          FLOAT (53)   NULL,
    [Cash]          FLOAT (53)   NULL,
    [Salesbalance]  FLOAT (53)   NULL,
    [Locker]        FLOAT (53)   NULL,
    [Closing]       FLOAT (53)   NULL,
    [CashBoxAmount] FLOAT (53)   NULL,
    [CashByAccount] FLOAT (53)   NULL,
    [CashStatus]    VARCHAR (50) NULL,
    [Received]      FLOAT (53)   NULL,
    [MonthExpense]  FLOAT (53)   NULL
);


GO

