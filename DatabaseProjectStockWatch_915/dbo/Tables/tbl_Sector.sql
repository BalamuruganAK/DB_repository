CREATE TABLE [dbo].[tbl_Sector] (
    [SectorID] TINYINT      NOT NULL,
    [Sector]   VARCHAR (50) NULL,
    [Planets]  VARCHAR (50) NULL,
    CONSTRAINT [PK_tbl_Sector] PRIMARY KEY CLUSTERED ([SectorID] ASC)
);


GO

