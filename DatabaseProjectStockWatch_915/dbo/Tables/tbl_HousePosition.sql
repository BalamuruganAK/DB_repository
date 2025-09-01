CREATE TABLE [dbo].[tbl_HousePosition] (
    [PDate]  SMALLDATETIME NOT NULL,
    [Planet] TINYINT       NOT NULL,
    [KP]     TINYINT       NULL,
    [MX]     TINYINT       NULL,
    [MXSub]  TINYINT       NULL,
    [MY]     TINYINT       NULL,
    [MYSub]  TINYINT       NULL,
    CONSTRAINT [PK_tbl_HousePosition] PRIMARY KEY CLUSTERED ([PDate] ASC, [Planet] ASC)
);


GO

