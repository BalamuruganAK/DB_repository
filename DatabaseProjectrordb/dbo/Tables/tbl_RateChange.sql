CREATE TABLE [dbo].[tbl_RateChange] (
    [RateChangeID]       INT        NOT NULL,
    [RateChangeDateTime] DATETIME   NULL,
    [CurrentRate]        FLOAT (53) NULL,
    [CurrentBag]         INT        NULL,
    [CurrentLoose]       FLOAT (53) NULL,
    [NewRate]            FLOAT (53) NULL,
    [NewBag]             INT        NULL,
    [NewLoose]           FLOAT (53) NULL,
    [ChangeBag]          INT        NULL,
    [ChangeLoose]        FLOAT (53) NULL
);


GO

