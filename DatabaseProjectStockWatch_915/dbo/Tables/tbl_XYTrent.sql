CREATE TABLE [dbo].[tbl_XYTrent] (
    [XYTrent]  TINYINT      NOT NULL,
    [Nature]   TINYINT      NULL,
    [Trent]    TINYINT      NULL,
    [Retro]    TINYINT      NULL,
    [Movement] VARCHAR (20) NULL,
    [Symbol]   NCHAR (10)   NULL,
    CONSTRAINT [PK_tbl_XYTrent] PRIMARY KEY CLUSTERED ([XYTrent] ASC)
);


GO

