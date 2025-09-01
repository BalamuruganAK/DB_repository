CREATE TABLE [dbo].[tbl_NewConjuction] (
    [PDate]     SMALLDATETIME NOT NULL,
    [KeyPlanet] TINYINT       NOT NULL,
    [KPlanet]   VARCHAR (50)  NULL,
    [KPosition] VARCHAR (50)  NULL,
    [XPlanet]   VARCHAR (50)  NULL,
    [XPosition] VARCHAR (50)  NULL,
    [YPlanet]   VARCHAR (50)  NULL,
    [YPosition] VARCHAR (50)  NULL,
    CONSTRAINT [PK_tbl_NewConjuction] PRIMARY KEY CLUSTERED ([KeyPlanet] ASC, [PDate] ASC)
);


GO

