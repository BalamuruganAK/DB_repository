CREATE TABLE [dbo].[tbl_Work] (
    [PDate]      SMALLDATETIME NOT NULL,
    [KeyPlanet]  TINYINT       NOT NULL,
    [DayLord]    TINYINT       NULL,
    [XPlanet]    TINYINT       NULL,
    [YPlanet]    TINYINT       NULL,
    [XPosition]  TINYINT       NULL,
    [YPosition]  TINYINT       NULL,
    [X1Planet]   TINYINT       NULL,
    [Y1Planet]   TINYINT       NULL,
    [X1Position] TINYINT       NULL,
    [Y1Position] TINYINT       NULL,
    [X2Planet]   TINYINT       NULL,
    [Y2Planet]   TINYINT       NULL,
    [X2Position] TINYINT       NULL,
    [Y2Position] TINYINT       NULL,
    [X3Planet]   TINYINT       NULL,
    [Y3Planet]   TINYINT       NULL,
    [X3Position] TINYINT       NULL,
    [Y3Position] TINYINT       NULL,
    [X4Planet]   TINYINT       NULL,
    [Y4Planet]   TINYINT       NULL,
    [X4Position] TINYINT       NULL,
    [Y4Position] TINYINT       NULL,
    CONSTRAINT [PK_tbl_Work] PRIMARY KEY CLUSTERED ([KeyPlanet] ASC, [PDate] ASC)
);


GO

