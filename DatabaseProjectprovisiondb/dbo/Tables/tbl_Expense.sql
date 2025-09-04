CREATE TABLE [dbo].[tbl_Expense] (
    [ExpenseID]       INT           NOT NULL,
    [ExpenseDateTime] DATETIME      NULL,
    [ExecutiveId]     INT           NULL,
    [ExpenseType]     VARCHAR (50)  NULL,
    [Advance]         FLOAT (53)    NULL,
    [Expense]         FLOAT (53)    NULL,
    [Balance]         FLOAT (53)    NULL,
    [Details]         VARCHAR (200) NULL,
    [Cancel]          INT           NULL
);


GO

