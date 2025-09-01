CREATE TABLE [dbo].[tbl_DailyOHLC] (
    [d] SMALLDATETIME   NOT NULL,
    [o] NUMERIC (18, 2) NULL,
    [h] NUMERIC (18, 2) NULL,
    [l] NUMERIC (18, 2) NULL,
    [c] NUMERIC (18, 2) NULL,
    [s] NUMERIC (18)    NULL,
    [t] NUMERIC (18, 2) NULL,
    [n] NVARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_tbl_DailyOHLC] PRIMARY KEY CLUSTERED ([d] ASC, [n] ASC)
);


GO

