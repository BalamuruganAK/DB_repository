CREATE TABLE [dbo].[tbl_CorrelationSequence] (
    [PDate]    SMALLDATETIME NOT NULL,
    [CSType]   TINYINT       NOT NULL,
    [Sequence] INT           NOT NULL,
    [XPlanet]  TINYINT       NULL,
    [YPlanet]  TINYINT       NULL,
    CONSTRAINT [PK_tbl_Correlation] PRIMARY KEY CLUSTERED ([PDate] ASC, [CSType] ASC, [Sequence] ASC)
);


GO

