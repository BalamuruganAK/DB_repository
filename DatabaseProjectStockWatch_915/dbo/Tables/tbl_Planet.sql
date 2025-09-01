CREATE TABLE [dbo].[tbl_Planet] (
    [PDate]   SMALLDATETIME NOT NULL,
    [Planet]  TINYINT       NOT NULL,
    [Degree]  INT           NULL,
    [FDegree] VARCHAR (10)  NULL,
    [Retro]   TINYINT       NULL,
    [Star]    TINYINT       NULL,
    [Sub]     TINYINT       NULL,
    CONSTRAINT [PK_tbl_Plant] PRIMARY KEY CLUSTERED ([PDate] ASC, [Planet] ASC)
);


GO

