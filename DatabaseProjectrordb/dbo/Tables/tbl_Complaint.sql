CREATE TABLE [dbo].[tbl_Complaint] (
    [ComplaintID]       INT           NOT NULL,
    [ComplaintDateTime] DATETIME      NULL,
    [ExecutiveId]       INT           NULL,
    [ComplaintType]     VARCHAR (20)  NULL,
    [Details]           VARCHAR (200) NULL
);


GO

