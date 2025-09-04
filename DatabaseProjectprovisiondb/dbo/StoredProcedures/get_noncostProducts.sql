   CREATE proc [dbo].[get_noncostProducts]
   as
   begin
	Select 
			--i.cid
			'update Stock set cost =  where iid= ' +	convert(varchar(10),i.iid) + '--'
			,i.iname
			,i.price
			,s.qty
		    ,s.cost
			,case when s.cost = 0 then i.price * 0.8 else s.cost end fcost
			,case when s.cost = 0 then i.price * 0.8 else s.cost end * s.qty as amt
		From Stock s
		inner join item i
		on i.iid = s.iid
		where s.cost = 0
		and s.qty > 0
		order by 1,3,2
	end

GO

