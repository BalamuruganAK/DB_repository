CREATE TABLE [dbo].[tbl_HistoryEQ] (
    [Symbol]   VARCHAR (50)    NOT NULL,
    [Series]   VARCHAR (5)     NOT NULL,
    [Date]     SMALLDATETIME   NOT NULL,
    [Open]     NUMERIC (18, 2) NULL,
    [High]     NUMERIC (18, 2) NULL,
    [Low]      NUMERIC (18, 2) NULL,
    [Close]    NUMERIC (18, 2) NULL,
    [Prev]     NUMERIC (18, 2) NULL,
    [Last]     NUMERIC (18)    NULL,
    [Average]  NUMERIC (18, 2) NULL,
    [Quantity] NUMERIC (18, 2) NULL,
    [Turnover] NUMERIC (18, 2) NULL,
    [Trades]   NUMERIC (18, 2) NULL,
    [POP]      NUMERIC (18, 2) NULL,
    [PCP]      NUMERIC (18, 2) NULL,
    [OCP]      NUMERIC (18, 2) NULL,
    [OHP]      NUMERIC (18, 2) NULL,
    [OLP]      NUMERIC (18, 2) NULL,
    [PHP]      NUMERIC (18, 2) NULL,
    [PLP]      NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_tbl_HistoryEQ] PRIMARY KEY CLUSTERED ([Symbol] ASC, [Series] ASC, [Date] ASC)
);


GO

