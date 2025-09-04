CREATE TABLE [dbo].[expenses] (
    [epid]  INT        NOT NULL,
    [eptid] INT        NOT NULL,
    [edate] DATETIME   NOT NULL,
    [amt]   FLOAT (53) NOT NULL,
    [eid]   INT        NULL
);


GO

