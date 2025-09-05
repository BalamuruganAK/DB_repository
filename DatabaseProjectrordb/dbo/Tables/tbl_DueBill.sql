CREATE TABLE [dbo].[tbl_DueBill] (
    [DueBillID]       INT        NOT NULL,
    [BillHdrID]       INT        NULL,
    [PaymentDateTime] DATETIME   NULL,
    [DuePaid]         FLOAT (53) NULL
);


GO

