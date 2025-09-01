CREATE TABLE [dbo].[tbl_Element] (
    [PDate] SMALLDATETIME NOT NULL,
    [MKE]   TINYINT       NULL,
    [SKE]   TINYINT       NULL,
    [JKE]   TINYINT       NULL,
    [TKE]   TINYINT       NULL,
    [MSE]   TINYINT       NULL,
    [SSE]   TINYINT       NULL,
    [JSE]   TINYINT       NULL,
    [TSE]   TINYINT       NULL,
    [MCE]   TINYINT       NULL,
    [SCE]   TINYINT       NULL,
    [JCE]   TINYINT       NULL,
    [TCE]   TINYINT       NULL,
    [KSumD] VARCHAR (4)   NULL,
    [SSumD] VARCHAR (4)   NULL,
    [CSumD] VARCHAR (4)   NULL,
    [KSum]  VARCHAR (4)   NULL,
    [SSum]  VARCHAR (4)   NULL,
    [CSum]  VARCHAR (4)   NULL,
    [SumOr] VARCHAR (4)   NULL,
    [CSKOr] VARCHAR (4)   NULL,
    [CSOr]  VARCHAR (4)   NULL,
    [CKOr]  VARCHAR (4)   NULL,
    CONSTRAINT [PK_tbl_Element] PRIMARY KEY CLUSTERED ([PDate] ASC)
);


GO

