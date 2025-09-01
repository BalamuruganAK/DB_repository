CREATE proc [rpt_HousePosition]
as
begin
	Select convert(varchar(5),xp.PDate,104) as Date, 
		case 
			when xp.Planet = 3 then 'Sun'
			when xp.Planet = 4 then 'Moo'
			when xp.Planet = 7 then 'Jup'
		end as Planet, 
		case 
			when replace(xp.KP % 4,0,4) = 1 then 'Fire' 
			when replace(xp.KP % 4,0,4) = 2 then 'Earth' 
			when replace(xp.KP % 4,0,4) = 3 then 'Air' 
			when replace(xp.KP % 4,0,4) = 4 then 'Water' 
		end as KP, 
		case 
			when replace(xp.MX % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MX % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MX % 4,0,4) = 3 then 'Air' 
			when replace(xp.MX % 4,0,4) = 4 then 'Water' 
		end as MX,  
		case 
			when replace(xp.MY % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MY % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MY % 4,0,4) = 3 then 'Air' 
			when replace(xp.MY % 4,0,4) = 4 then 'Water' 
		end as MY,  
		case 
			when replace(xp.MXSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MXSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MXSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MXSub % 4,0,4) = 4 then 'Water' 
		end as Sub, 
		case 
			when replace(xp.MYSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MYSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MYSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MYSub % 4,0,4) = 4 then 'Water' 
		end as StarofSub
		from tbl_HousePosition xp
	where year(xp.PDate) = 2018 and month(xp.PDate) >= 7
	and xp.Planet = 4
	order by xp.PDate 

	Select convert(varchar(5),xp.PDate,104) as Date, 
		case 
			when xp.Planet = 3 then 'Sun'
			when xp.Planet = 4 then 'Moo'
			when xp.Planet = 7 then 'Jup'
		end as Planet, 
		case 
			when replace(xp.KP % 4,0,4) = 1 then 'Fire' 
			when replace(xp.KP % 4,0,4) = 2 then 'Earth' 
			when replace(xp.KP % 4,0,4) = 3 then 'Air' 
			when replace(xp.KP % 4,0,4) = 4 then 'Water' 
		end as KP, 
		case 
			when replace(xp.MX % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MX % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MX % 4,0,4) = 3 then 'Air' 
			when replace(xp.MX % 4,0,4) = 4 then 'Water' 
		end as MX,  
		case 
			when replace(xp.MY % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MY % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MY % 4,0,4) = 3 then 'Air' 
			when replace(xp.MY % 4,0,4) = 4 then 'Water' 
		end as MY,  
		case 
			when replace(xp.MXSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MXSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MXSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MXSub % 4,0,4) = 4 then 'Water' 
		end as Sub, 
		case 
			when replace(xp.MYSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MYSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MYSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MYSub % 4,0,4) = 4 then 'Water' 
		end as StarofSub
		from tbl_HousePosition xp
	where year(xp.PDate) = 2018 and month(xp.PDate) >= 7
	and xp.Planet = 3
	order by xp.PDate 
	
		Select convert(varchar(5),xp.PDate,104) as Date, 
		case 
			when xp.Planet = 3 then 'Sun'
			when xp.Planet = 4 then 'Moo'
			when xp.Planet = 7 then 'Jup'
		end as Planet, 
		case 
			when replace(xp.KP % 4,0,4) = 1 then 'Fire' 
			when replace(xp.KP % 4,0,4) = 2 then 'Earth' 
			when replace(xp.KP % 4,0,4) = 3 then 'Air' 
			when replace(xp.KP % 4,0,4) = 4 then 'Water' 
		end as KP, 
		case 
			when replace(xp.MX % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MX % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MX % 4,0,4) = 3 then 'Air' 
			when replace(xp.MX % 4,0,4) = 4 then 'Water' 
		end as MX,  
		case 
			when replace(xp.MY % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MY % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MY % 4,0,4) = 3 then 'Air' 
			when replace(xp.MY % 4,0,4) = 4 then 'Water' 
		end as MY,  
		case 
			when replace(xp.MXSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MXSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MXSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MXSub % 4,0,4) = 4 then 'Water' 
		end as Sub, 
		case 
			when replace(xp.MYSub % 4,0,4) = 1 then 'Fire' 
			when replace(xp.MYSub % 4,0,4) = 2 then 'Earth' 
			when replace(xp.MYSub % 4,0,4) = 3 then 'Air' 
			when replace(xp.MYSub % 4,0,4) = 4 then 'Water' 
		end as StarofSub
		from tbl_HousePosition xp
	where year(xp.PDate) = 2018 and month(xp.PDate) >= 7
	and xp.Planet = 7
	order by xp.PDate 
	
end

GO

