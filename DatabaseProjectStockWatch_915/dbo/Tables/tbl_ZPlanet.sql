CREATE TABLE [dbo].[tbl_ZPlanet] (
    [PDate]       SMALLDATETIME NOT NULL,
    [KeyPlanet]   TINYINT       NOT NULL,
    [ZPlanet]     TINYINT       NULL,
    [ZPosition]   TINYINT       NULL,
    [YPlanet]     TINYINT       NULL,
    [YPosition]   TINYINT       NULL,
    [ZConjuction] NVARCHAR (50) NULL,
    CONSTRAINT [PK_tbl_ZPlanet] PRIMARY KEY CLUSTERED ([KeyPlanet] ASC, [PDate] ASC)
);


GO

