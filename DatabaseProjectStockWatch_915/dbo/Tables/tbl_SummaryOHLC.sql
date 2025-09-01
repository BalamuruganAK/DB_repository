CREATE TABLE [dbo].[tbl_SummaryOHLC] (
    [d]        SMALLDATETIME   NOT NULL,
    [n]        NVARCHAR (50)   NOT NULL,
    [Sno]      BIGINT          NOT NULL,
    [o]        NUMERIC (18, 2) NULL,
    [h]        NUMERIC (18, 2) NULL,
    [l]        NUMERIC (18, 2) NULL,
    [c]        NUMERIC (18, 2) NULL,
    [s]        NUMERIC (18)    NULL,
    [avg]      NUMERIC (18, 2) NULL,
    [pc]       NUMERIC (18, 2) NULL,
    [gap]      NUMERIC (18, 2) NULL,
    [ccgain]   NUMERIC (18, 2) NULL,
    [chgain]   NUMERIC (18, 2) NULL,
    [clgain]   NUMERIC (18, 2) NULL,
    [ocgain]   NUMERIC (18, 2) NULL,
    [ohgain]   NUMERIC (18, 2) NULL,
    [olgain]   NUMERIC (18, 2) NULL,
    [CandleId] SMALLINT        NULL,
    [DowId]    SMALLINT        NULL,
    [Sup1]     SMALLINT        NULL,
    [Sup2]     SMALLINT        NULL,
    [Res1]     SMALLINT        NULL,
    [Res2]     SMALLINT        NULL,
    CONSTRAINT [PK_tbl_SummaryOHLC] PRIMARY KEY CLUSTERED ([d] ASC, [n] ASC, [Sno] ASC)
);


GO

