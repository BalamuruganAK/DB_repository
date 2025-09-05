CREATE PROC [dbo].[rpt_sales]
as
begin

	SELECT convert(varchar(12),h.BillDateTime,102 ), SUM(Quantity )
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	where isnull(h.Cancel,0) <> 1
	GROUP BY convert(varchar(12),h.BillDateTime,102 ) 
	ORDER BY convert(varchar(12),h.BillDateTime,102 ) 

	SELECT ITEM,SUM(Quantity ) as qty
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	where isnull(h.Cancel,0) <> 1
	GROUP BY Item 
	ORDER BY qty
	
	SELECT convert(varchar(12),h.BillDateTime,102 ), ITEM,SUM(Quantity )
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	where isnull(h.Cancel,0) <> 1
	GROUP BY convert(varchar(12),h.BillDateTime,102 ), Item 
	ORDER BY convert(varchar(12),h.BillDateTime,102 ) Desc, Item 
end

GO

