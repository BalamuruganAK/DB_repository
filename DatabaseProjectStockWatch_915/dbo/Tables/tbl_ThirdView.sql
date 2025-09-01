CREATE TABLE [dbo].[tbl_ThirdView] (
    [PDate]  SMALLDATETIME NOT NULL,
    [Planet] TINYINT       NOT NULL,
    [KP]     NVARCHAR (50) NULL,
    [MSub]   NVARCHAR (50) NULL,
    [MX]     NVARCHAR (50) NULL,
    [MXStar] NVARCHAR (50) NULL,
    [MXSub]  NVARCHAR (50) NULL,
    [MY]     NVARCHAR (50) NULL,
    [MYStar] NVARCHAR (50) NULL,
    [MYSub]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_tbl_ThirdView] PRIMARY KEY CLUSTERED ([PDate] ASC, [Planet] ASC)
);


GO

