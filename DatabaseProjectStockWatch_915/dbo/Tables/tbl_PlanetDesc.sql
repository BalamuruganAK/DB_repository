CREATE TABLE [dbo].[tbl_PlanetDesc] (
    [Planet]          TINYINT       NOT NULL,
    [PlanetShortDesc] NVARCHAR (3)  NULL,
    [PlanetDesc]      NVARCHAR (20) NULL,
    CONSTRAINT [PK_tbl_PlantDesc] PRIMARY KEY CLUSTERED ([Planet] ASC)
);


GO

