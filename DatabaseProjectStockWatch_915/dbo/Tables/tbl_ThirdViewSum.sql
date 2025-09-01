CREATE TABLE [dbo].[tbl_ThirdViewSum] (
    [PDate] SMALLDATETIME  NOT NULL,
    [M]     NVARCHAR (250) NULL,
    [S]     NVARCHAR (250) NULL,
    [J]     NVARCHAR (250) NULL,
    [A]     NVARCHAR (250) NULL,
    CONSTRAINT [PK_tbl_ThirdViewSum] PRIMARY KEY CLUSTERED ([PDate] ASC)
);


GO

