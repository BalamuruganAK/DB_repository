CREATE TABLE [dbo].[currentstate] (
    [csdate]        DATETIME   NOT NULL,
    [stockvalue]    FLOAT (53) NULL,
    [costofsales]   FLOAT (53) NULL,
    [salesamt]      FLOAT (53) NULL,
    [received]      FLOAT (53) NULL,
    [receivable]    FLOAT (53) NULL,
    [expenses]      FLOAT (53) NULL,
    [cashfromsales] FLOAT (53) NULL,
    [purchase]      FLOAT (53) NULL,
    [cashbalance]   FLOAT (53) NULL,
    CONSTRAINT [PK_currentstate] PRIMARY KEY CLUSTERED ([csdate] ASC)
);


GO

