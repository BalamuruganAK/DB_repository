CREATE TABLE [dbo].[tbl_FinalTrent] (
    [PDate]         SMALLDATETIME NOT NULL,
    [KeyPlanet]     TINYINT       NOT NULL,
    [XTrent]        TINYINT       NULL,
    [YTrent]        TINYINT       NULL,
    [DayLordTrent]  TINYINT       NULL,
    [MoonTrent]     TINYINT       NULL,
    [ExchangeTrent] TINYINT       NULL,
    [X1Trent]       TINYINT       NULL,
    [Y1Trent]       TINYINT       NULL,
    [X2Trent]       TINYINT       NULL,
    [Y2Trent]       TINYINT       NULL,
    [CXTrent]       TINYINT       NULL,
    [CYTrent]       TINYINT       NULL,
    [CX1Trent]      TINYINT       NULL,
    [CY1Trent]      TINYINT       NULL,
    [CX2Trent]      TINYINT       NULL,
    [CY2Trent]      TINYINT       NULL,
    [Gap1]          TINYINT       NULL,
    [Gap2]          TINYINT       NULL,
    [Gap3]          TINYINT       NULL,
    CONSTRAINT [PK_tbl_FinalTrent] PRIMARY KEY CLUSTERED ([PDate] ASC, [KeyPlanet] ASC)
);


GO

