CREATE TABLE [dbo].[customer] (
    [cid]      INT           NOT NULL,
    [cdate]    DATETIME      NULL,
    [eid]      INT           NULL,
    [phone]    BIGINT        NULL,
    [ctype]    VARCHAR (50)  NULL,
    [cname]    VARCHAR (50)  NULL,
    [caddress] VARCHAR (200) NULL,
    CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED ([cid] ASC)
);


GO

