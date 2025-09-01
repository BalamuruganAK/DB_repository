CREATE TABLE [dbo].[tbl_Horary] (
    [Hno]     SMALLINT      NOT NULL,
    [Rasi]    NVARCHAR (50) NULL,
    [FromD]   NVARCHAR (12) NULL,
    [ToD]     NVARCHAR (12) NULL,
    [House]   NVARCHAR (50) NULL,
    [Star]    NVARCHAR (50) NULL,
    [Sub]     NVARCHAR (50) NULL,
    [HouseNo] SMALLINT      NULL,
    [FD]      INT           NULL,
    [TD]      INT           NULL,
    CONSTRAINT [PK_tbl_Horary] PRIMARY KEY CLUSTERED ([Hno] ASC)
);


GO

