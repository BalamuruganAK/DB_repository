CREATE TABLE [dbo].[tbl_HistoryIXTemp] (
    [Symbol]            VARCHAR (50)    NOT NULL,
    [Series]            VARCHAR (5)     NOT NULL,
    [Date]              SMALLDATETIME   NOT NULL,
    [Open]              NUMERIC (18, 2) NULL,
    [High]              NUMERIC (18, 2) NULL,
    [Low]               NUMERIC (18, 2) NULL,
    [Close]             NUMERIC (18, 2) NULL,
    [Shares Traded]     NUMERIC (18, 2) NULL,
    [Turnover (Rs. Cr)] NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_tbl_HistoryIXTemp] PRIMARY KEY CLUSTERED ([Symbol] ASC, [Series] ASC, [Date] ASC)
);


GO

