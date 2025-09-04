CREATE TABLE [dbo].[cashbook] (
    [cdate]     DATETIME   NOT NULL,
    [copen]     FLOAT (53) NOT NULL,
    [cclose]    FLOAT (53) NOT NULL,
    [ptm]       FLOAT (53) NOT NULL,
    [gpay]      FLOAT (53) NOT NULL,
    [cards]     FLOAT (53) NOT NULL,
    [toaccount] FLOAT (53) NOT NULL,
    CONSTRAINT [PK_cashbook] PRIMARY KEY CLUSTERED ([cdate] ASC)
);


GO

