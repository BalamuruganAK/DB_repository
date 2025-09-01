CREATE TABLE [dbo].[tbl_MoonOverlap] (
    [PDate]   SMALLDATETIME NOT NULL,
    [XY]      VARCHAR (50)  NULL,
    [ConjXY]  VARCHAR (50)  NULL,
    [ConjM]   VARCHAR (50)  NULL,
    [NewConj] VARCHAR (50)  NULL,
    [MOLap]   VARCHAR (100) NULL,
    CONSTRAINT [PK_tbl_MoonOverlap] PRIMARY KEY CLUSTERED ([PDate] ASC)
);


GO

