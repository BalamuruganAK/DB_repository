CREATE TABLE [dbo].[item] (
    [iid]      INT           NOT NULL,
    [iname]    VARCHAR (100) NOT NULL,
    [qty]      FLOAT (53)    CONSTRAINT [DF_item_quantity] DEFAULT ((1)) NULL,
    [price]    FLOAT (53)    NOT NULL,
    [discount] FLOAT (53)    CONSTRAINT [DF_item_discount] DEFAULT ((0)) NULL,
    [piid]     INT           CONSTRAINT [DF_item_piid] DEFAULT ((0)) NOT NULL,
    [cid]      INT           NOT NULL,
    CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED ([iid] ASC)
);


GO

