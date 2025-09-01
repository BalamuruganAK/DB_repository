CREATE TABLE [dbo].[tbl_DayPosition] (
    [PDate]        SMALLDATETIME NOT NULL,
    [CPlanet]      VARCHAR (200) NULL,
    [CPosition]    VARCHAR (200) NULL,
    [SPlanet]      VARCHAR (200) NULL,
    [SPosition]    VARCHAR (200) NULL,
    [S30Planet]    VARCHAR (200) NULL,
    [S30Position]  VARCHAR (200) NULL,
    [StarPlanet]   VARCHAR (200) NULL,
    [StarPosition] VARCHAR (200) NULL,
    [RPlanet]      VARCHAR (200) NULL,
    [MSPosition]   VARCHAR (2)   NULL,
    [SMPosition]   VARCHAR (2)   NULL,
    [TS]           VARCHAR (1)   NULL,
    [TSTime]       VARCHAR (6)   NULL,
    CONSTRAINT [PK_tbl_DayPosition] PRIMARY KEY CLUSTERED ([PDate] ASC)
);


GO

