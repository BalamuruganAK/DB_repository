CREATE TABLE [dbo].[tbl_HistoryEQOldTemp] (
    [Symbol]                VARCHAR (50)    NOT NULL,
    [Series]                VARCHAR (5)     NOT NULL,
    [Date]                  SMALLDATETIME   NOT NULL,
    [Prev Close]            NUMERIC (18, 2) NULL,
    [Open Price]            NUMERIC (18, 2) NULL,
    [High Price]            NUMERIC (18, 2) NULL,
    [Low Price]             NUMERIC (18, 2) NULL,
    [Last Price]            NUMERIC (18)    NULL,
    [Close Price]           NUMERIC (18, 2) NULL,
    [Average Price]         NUMERIC (18, 2) NULL,
    [Total Traded Quantity] NUMERIC (18, 2) NULL,
    [Turnover]              NUMERIC (18, 2) NULL,
    [No. of Trades]         NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_tbl_HistoryEQOldTemp] PRIMARY KEY CLUSTERED ([Symbol] ASC, [Series] ASC, [Date] ASC)
);


GO

