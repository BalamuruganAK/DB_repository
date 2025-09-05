CREATE PROC [dbo].[rpt_customer_status]
as
begin
	
	SELECT  
		sum(case when daycount <= 30 then 1 else 0 end) as 'A',
		sum(case when daycount between 31 and 60 then 1 else 0 end) as 'P',
		sum(case when daycount between 61 and 90 then 1 else 0 end) as 'I',
		sum(case when daycount > 90 then 1 else 0 end) as 'L'
	FROM
	(SELECT DATEDIFF(dd,max(h.BillDateTime),GETDATE()) as daycount, h.Phone, max(d.Item) rate
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	GROUP BY h.Phone) as grp
	
	SELECT  
		sum(case when daycount <= 30 then 1 else 0 end) as 'A',
		sum(case when daycount between 31 and 60 then 1 else 0 end) as 'P',
		sum(case when daycount between 61 and 90 then 1 else 0 end) as 'I',
		sum(case when daycount > 90 then 1 else 0 end) as 'L'
	FROM
	(SELECT DATEDIFF(dd,max(h.BillDateTime),GETDATE()) as daycount, h.Phone, max(d.Item) rate
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	GROUP BY h.Phone) as grp
	where rate > 40.80
	
	SELECT  
		sum(case when daycount <= 30 then 1 else 0 end) as 'A',
		sum(case when daycount between 31 and 60 then 1 else 0 end) as 'P',
		sum(case when daycount between 61 and 90 then 1 else 0 end) as 'I',
		sum(case when daycount > 90 then 1 else 0 end) as 'L'
	FROM
	(SELECT DATEDIFF(dd,max(h.BillDateTime),GETDATE()) as daycount, h.Phone, max(d.Item) rate
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	GROUP BY h.Phone) as grp
	where rate <= 40.80
	
	SELECT  h.Phone, SUM(d.Quantity ) 'Qty', --MIN(d.item), 
	max(d.Item) Rate, d.Discount, h.BillDateTime, c.Name+ ','+ c.CustomerAddress+' ,'+ c.CustomerType
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	inner join 
		(Select h1.Phone , MAX(d1.Item) Item
		FROM tbl_BillDtl d1
		inner join tbl_BillHdr h1
		on h1.BillHdrID = d1.BillHdrID 
		where isnull(h1.Cancel,0) <> 1
		and isnull(h1.Phone,0)>0
		and d1.Quantity >= 25
		group by h1.Phone) maxbill
	on maxbill.Phone = h.Phone and maxbill.Item = d.Item
	inner join 
		(Select h2.Phone , d2.Item, max(h2.BillDateTime) BillDateTime
		FROM tbl_BillDtl d2
		inner join tbl_BillHdr h2
		on h2.BillHdrID = d2.BillHdrID 
		where isnull(h2.Cancel,0) <> 1
		and isnull(h2.Phone,0)>0
		and d2.Quantity >= 25
		group by h2.Phone, d2.Item) maxdate
	on maxdate.Phone = h.Phone and maxdate.Item = d.Item and maxdate.BillDateTime = h.BillDateTime
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	GROUP BY h.Phone, h.BillDateTime, c.Name, c.CustomerAddress, c.CustomerType, d.Discount
	ORDER BY h.Phone, c.Name, c.CustomerAddress, c.CustomerType
	
	SELECT  MIN(d.item), max(d.Item), d.Discount, DATEDIFF(dd,max(h.BillDateTime),GETDATE()) 'days',
			SUM(d.Quantity ) 'Qty', h.Phone, c.Name +' ,'+ c.CustomerAddress+' ,'+ c.CustomerType
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	inner join
	(Select h2.Phone , max(h2.BillDateTime) BillDateTime
		FROM tbl_BillDtl d2
		inner join tbl_BillHdr h2
		on h2.BillHdrID = d2.BillHdrID 
		where isnull(h2.Cancel,0) <> 1
		and isnull(h2.Phone,0)>0
		and d2.Quantity >= 25
		group by h2.Phone) maxdate
	on maxdate.Phone = h.Phone and maxdate.BillDateTime = h.BillDateTime
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	and DATEDIFF(dd,h.BillDateTime,GETDATE()) between 21 and 90
	and h.Phone not in 
	(Select h2.Phone 
		FROM tbl_BillDtl d2
		inner join tbl_BillHdr h2
		on h2.BillHdrID = d2.BillHdrID 
		where isnull(h2.Cancel,0) <> 1
		and isnull(h2.Phone,0)>0
		and d2.Quantity >= 25
		and DATEDIFF(dd,h.BillDateTime,GETDATE()) < 21)
	GROUP BY h.Phone,d.Discount, c.Name, c.CustomerAddress, c.CustomerType
	ORDER BY max(d.Item) desc, 'days' desc,SUM(d.Quantity ) desc, convert(varchar(12),max(h.BillDateTime),102 )
	
	/*
	SELECT  convert(varchar(12),min(h.BillDateTime),102 ) 'FirsrDate', 
		convert(varchar(12),max(h.BillDateTime),102 ) 'LastDate',
		DATEDIFF(dd,max(h.BillDateTime),GETDATE()) 'days',
		case 
			when DATEDIFF(dd,max(h.BillDateTime),GETDATE()) <= 30 then 'A'
			when DATEDIFF(dd,max(h.BillDateTime),GETDATE()) between 31 and 60 then 'P'
			when DATEDIFF(dd,max(h.BillDateTime),GETDATE()) between 61 and 90 then 'I'
			when DATEDIFF(dd,max(h.BillDateTime),GETDATE()) > 90 then 'L'
		end as CStatus,
		SUM(d.Quantity ) 'Qty', MIN(d.item), max(d.Item),
		h.Phone, c.Name, c.CustomerAddress, c.CustomerType
	FROM tbl_BillDtl d
	inner join tbl_BillHdr h
	on h.BillHdrID = d.BillHdrID 
	left outer join tbl_Customer c
	on h.Phone = c.Phone
	where isnull(h.Cancel,0) <> 1
	and isnull(h.Phone,0)>0
	and d.Quantity >= 25
	GROUP BY h.Phone, c.Name, c.CustomerAddress, c.CustomerType
	ORDER BY CStatus, max(d.Item), 'days',SUM(d.Quantity ) desc, convert(varchar(12),max(h.BillDateTime),102 )
	*/
end

GO

