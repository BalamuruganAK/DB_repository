CREATE TABLE [dbo].[salesrevenue] (
    [srdate]      DATETIME   NOT NULL,
    [costofsales] FLOAT (53) NULL,
    [salesamt]    FLOAT (53) NULL,
    [expenses]    FLOAT (53) NULL,
    [revenue]     FLOAT (53) NULL,
    CONSTRAINT [PK_salesrevenue] PRIMARY KEY CLUSTERED ([srdate] ASC)
);


GO

