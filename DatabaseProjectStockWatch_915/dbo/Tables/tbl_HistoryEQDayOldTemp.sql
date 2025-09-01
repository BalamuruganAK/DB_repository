CREATE TABLE [dbo].[tbl_HistoryEQDayOldTemp] (
    [Symbol]              VARCHAR (50)    NOT NULL,
    [Date]                SMALLDATETIME   NOT NULL,
    [Open]                NUMERIC (18, 2) NULL,
    [High]                NUMERIC (18, 2) NULL,
    [Low]                 NUMERIC (18, 2) NULL,
    [Last Traded Price]   NUMERIC (18)    NULL,
    [Traded Volume(lacs)] NUMERIC (18, 2) NULL,
    [Traded Value(crs)]   NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_tbl_HistoryEQDayOldTemp] PRIMARY KEY CLUSTERED ([Symbol] ASC, [Date] ASC)
);


GO

