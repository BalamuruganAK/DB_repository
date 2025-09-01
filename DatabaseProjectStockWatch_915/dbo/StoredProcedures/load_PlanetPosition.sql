CREATE proc [dbo].[load_PlanetPosition]
	as 
	begin

	update p set p.sun = '0'+p.sun from tbl_Panjangam p where len(p.sun) < 8
	update p set p.moo = '0'+p.moo from tbl_Panjangam p where len(p.moo) < 8
	update p set p.mar = '0'+p.mar from tbl_Panjangam p where len(p.mar) < 8
	update p set p.mer = '0'+p.mer from tbl_Panjangam p where len(p.mer) < 8
	update p set p.jup = '0'+p.jup from tbl_Panjangam p where len(p.jup) < 8
	update p set p.ven = '0'+p.ven from tbl_Panjangam p where len(p.ven) < 8
	update p set p.sat = '0'+p.sat from tbl_Panjangam p where len(p.sat) < 8
	update p set p.rah = '0'+p.rah from tbl_Panjangam p where len(p.rah) < 8
	update p set p.ket = '0'+p.ket from tbl_Panjangam p where len(p.ket) < 8
	update p set p.ura = '0'+p.ura from tbl_Panjangam p where len(p.ura) < 8
	update p set p.nep = '0'+p.nep from tbl_Panjangam p where len(p.nep) < 8
	update p set p.plu = '0'+p.plu from tbl_Panjangam p where len(p.plu) < 8
	update p set p.sun = '0'+p.sun from tbl_Panjangam p where len(p.sun) < 9
	update p set p.moo = '0'+p.moo from tbl_Panjangam p where len(p.moo) < 9
	update p set p.mar = '0'+p.mar from tbl_Panjangam p where len(p.mar) < 9
	update p set p.mer = '0'+p.mer from tbl_Panjangam p where len(p.mer) < 9
	update p set p.jup = '0'+p.jup from tbl_Panjangam p where len(p.jup) < 9
	update p set p.ven = '0'+p.ven from tbl_Panjangam p where len(p.ven) < 9
	update p set p.sat = '0'+p.sat from tbl_Panjangam p where len(p.sat) < 9
	update p set p.rah = '0'+p.rah from tbl_Panjangam p where len(p.rah) < 9
	update p set p.ket = '0'+p.ket from tbl_Panjangam p where len(p.ket) < 9
	update p set p.ura = '0'+p.ura from tbl_Panjangam p where len(p.ura) < 9
	update p set p.nep = '0'+p.nep from tbl_Panjangam p where len(p.nep) < 9
	update p set p.plu = '0'+p.plu from tbl_Panjangam p where len(p.plu) < 9

	insert into tbl_PlanetPosition
	
	/* 
	Select p.pdate, 4 as Planet,  
	   (case when len(p.moo) = 9 then RIGHT(p.moo,3)
	else RIGHT(p.moo,4) end + 
	((case when len(p.moo) = 9 then left(RIGHT(p.moo,6),2) 
	else left(RIGHT(p.moo,7),2) end) * 60)+
	((case when len(p.moo) = 9 then left(p.moo,3) 
	else left(p.moo,2) end) * 60 * 60))  Degree,	
	p.moo as FDegree, 0 as Retro from tbl_Panjangam p
	where p.moo is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 4 = PP.Planet)
	*/
	/* for 5.30 am date add 6440 sec to moon*/
  Select p.pdate, 4 as Planet,  
	   (case when len(p.moo) = 9 then RIGHT(p.moo,3)
	else RIGHT(p.moo,4) end + 
	((case when len(p.moo) = 9 then left(RIGHT(p.moo,6),2) 
	else left(RIGHT(p.moo,7),2) end) * 60)+
	((case when len(p.moo) = 9 then left(p.moo,3) 
	else left(p.moo,2) end) * 60 * 60)) + 6440 Degree,	
	p.moo as FDegree, 0 as Retro from tbl_Panjangam p
	where p.moo is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 4 = PP.Planet)
  union all
  Select p.pdate, 3 as Planet,  
	   (case when len(p.sun) = 9 then RIGHT(p.sun,3)
	else RIGHT(p.sun,4) end + 
	((case when len(p.sun) = 9 then left(RIGHT(p.sun,6),2) 
	else left(RIGHT(p.sun,7),2) end) * 60)+
	((case when len(p.sun) = 9 then left(p.sun,3) 
	else left(p.sun,2) end) * 60 * 60))  Degree,	
	p.sun as FDegree, 0 as Retro from tbl_Panjangam p
	where p.sun is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 3 = PP.Planet)
  union all
  Select p.pdate, 1 as Planet,  
	   (case when len(p.ket) = 9 then RIGHT(p.ket,3)
	else RIGHT(p.ket,4) end + 
	((case when len(p.ket) = 9 then left(RIGHT(p.ket,6),2) 
	else left(RIGHT(p.ket,7),2) end) * 60)+
	((case when len(p.ket) = 9 then left(p.ket,3) 
	else left(p.ket,2) end) * 60 * 60))  Degree,	
	p.ket as FDegree, 0 as Retro from tbl_Panjangam p
	where p.ket is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 1 = PP.Planet)
  union all
  Select p.pdate, 2 as Planet,  
	   (case when len(p.ven) = 9 then RIGHT(p.ven,3)
	else RIGHT(p.ven,4) end + 
	((case when len(p.ven) = 9 then left(RIGHT(p.ven,6),2) 
	else left(RIGHT(p.ven,7),2) end) * 60)+
	((case when len(p.ven) = 9 then left(p.ven,3) 
	else left(p.ven,2) end) * 60 * 60))  Degree,	
	p.ven as FDegree, isnull(convert(int,p.vr),0) as Retro from tbl_Panjangam p
	where p.ven is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 2 = PP.Planet)
  union all
  Select p.pdate, 5 as Planet,  
	   (case when len(p.mar) = 9 then RIGHT(p.mar,3)
	else RIGHT(p.mar,4) end + 
	((case when len(p.mar) = 9 then left(RIGHT(p.mar,6),2) 
	else left(RIGHT(p.mar,7),2) end) * 60)+
	((case when len(p.mar) = 9 then left(p.mar,3) 
	else left(p.mar,2) end) * 60 * 60))  Degree,	
	p.mar as FDegree, isnull(convert(int,p.ar),0) as Retro from tbl_Panjangam p
	where p.mar is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 5 = PP.Planet)
  union all
  Select p.pdate, 6 as Planet,  
	   (case when len(p.rah) = 9 then RIGHT(p.rah,3)
	else RIGHT(p.rah,4) end + 
	((case when len(p.rah) = 9 then left(RIGHT(p.rah,6),2) 
	else left(RIGHT(p.rah,7),2) end) * 60)+
	((case when len(p.rah) = 9 then left(p.rah,3) 
	else left(p.rah,2) end) * 60 * 60))  Degree,	
	p.rah as FDegree, 0 as Retro from tbl_Panjangam p
	where p.rah is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 6 = PP.Planet)
  union all
  Select p.pdate, 7 as Planet,  
	   (case when len(p.jup) = 9 then RIGHT(p.jup,3)
	else RIGHT(p.jup,4) end + 
	((case when len(p.jup) = 9 then left(RIGHT(p.jup,6),2) 
	else left(RIGHT(p.jup,7),2) end) * 60)+
	((case when len(p.jup) = 9 then left(p.jup,3) 
	else left(p.jup,2) end) * 60 * 60))  Degree,	
	p.jup as FDegree, isnull(convert(int,p.jr),0) as Retro from tbl_Panjangam p
	where p.jup is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 7 = PP.Planet)
  union all
  Select p.pdate, 8 as Planet,  
	   (case when len(p.sat) = 9 then RIGHT(p.sat,3)
	else RIGHT(p.sat,4) end + 
	((case when len(p.sat) = 9 then left(RIGHT(p.sat,6),2) 
	else left(RIGHT(p.sat,7),2) end) * 60)+
	((case when len(p.sat) = 9 then left(p.sat,3) 
	else left(p.sat,2) end) * 60 * 60))  Degree,	
	p.sat as FDegree, isnull(convert(int,p.sr),0) as Retro from tbl_Panjangam p
	where p.sat is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 8 = PP.Planet)
  union all
  Select p.pdate, 9 as Planet,  
	   (case when len(p.mer) = 9 then RIGHT(p.mer,3)
	else RIGHT(p.mer,4) end + 
	((case when len(p.mer) = 9 then left(RIGHT(p.mer,6),2) 
	else left(RIGHT(p.mer,7),2) end) * 60)+
	((case when len(p.mer) = 9 then left(p.mer,3) 
	else left(p.mer,2) end) * 60 * 60))  Degree,	
	p.mer as FDegree, isnull(convert(int,p.er),0) as Retro from tbl_Panjangam p
	where p.mer is not null
	and p.PDate 
		not in (Select PP.PDate from tbl_PlanetPosition PP Where 9 = PP.Planet)

  end

GO

