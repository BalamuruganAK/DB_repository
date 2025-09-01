create proc [dbo].[rpt_SearchMaster_old]
(
@MS VARCHAR(2) ,
@SM VARCHAR(2) ,
@MA VARCHAR(16) ,
@MX VARCHAR(6) ,
@MX1 VARCHAR(6) ,
@MX2 VARCHAR(6) ,
@MY VARCHAR(6) ,
@MY1 VARCHAR(6) ,
@MY2 VARCHAR(6) ,
@SA VARCHAR(6) ,
@SX VARCHAR(6) ,
@JA VARCHAR(6) ,
@JX VARCHAR(6) ,
@D1 Date,
@D2 Date
)
as
begin

-- exec [rpt_SearchMaster] '0','0','Ven/Mer','Mer','','','','','','','','',''
	
	Declare @MA1 VARCHAR(6)
	Declare @MA2 VARCHAR(6)
	Declare @MA3 VARCHAR(6)
	Declare @MA4 VARCHAR(6)

	Declare @SA1 VARCHAR(6)
	Declare @SA2 VARCHAR(6)
	Declare @SA3 VARCHAR(6)
	Declare @SA4 VARCHAR(6)
	
	Declare @JA1 VARCHAR(6)
	Declare @JA2 VARCHAR(6)
	Declare @JA3 VARCHAR(6)
	Declare @JA4 VARCHAR(6)
	
	Declare @MSi int
	Declare @SMi int
/*		
	Select @MX = LEFT(@MX,3)
	Select @MX1 = LEFT(@MX1,3)
	Select @MX2 = LEFT(@MX2,3)
	
	Select @MY= LEFT(@MX,3)
	Select @MX1 = LEFT(@MX1,3)
	Select @MX2 = LEFT(@MX2,3)
*/
	Select @MA1 = '%'+LEFT(@MA,3) +'%'
	Select @MA2 = '%'+LEFT(RIGHT(@MA,11),3) +'%'
	Select @MA3 = '%'+LEFT(RIGHT(@MA,7),3) +'%'
	Select @MA4 = '%'+LEFT(RIGHT(@MA,3),3) +'%'

	Select @SA1 = '%'+LEFT(@SA,3) +'%'
	Select @SA2 = '%'+LEFT(RIGHT(@SA,11),3) +'%'
	Select @SA3 = '%'+LEFT(RIGHT(@SA,7),3) +'%'
	Select @SA4 = '%'+LEFT(RIGHT(@SA,3),3) +'%'

	Select @JA1 = '%'+LEFT(@JA,3) +'%'
	Select @JA2 = '%'+LEFT(RIGHT(@JA,11),3) +'%'
	Select @JA3 = '%'+LEFT(RIGHT(@JA,7),3) +'%'
	Select @JA4 = '%'+LEFT(RIGHT(@JA,3),3) +'%'
	
	Select @MSi = Convert(int,@MS)
	Select @SMi = Convert(int,@SM)

	Select @SA  = '%'+LEFT(@SA,3), @JA  = '%'+LEFT(@JA,3)
--	Select @SX  = LEFT(@SX,3), @JX  = LEFT(@JX,3)

	create table #date(mPDate smalldatetime)

	CREATE TABLE #Astro(
	PDate [smalldatetime] NOT NULL,
	KP [tinyint] NOT NULL,
	DL varchar(1) NULL,
	Mo varchar(1) NULL,
	Ex varchar(1) NULL,
	
	XPL varchar(3) NULL,
	XPo [tinyint] NULL,
	XN varchar(1) NULL,
	XD varchar(1) NULL,
	XR [tinyint] NULL,
	X1PL varchar(3) NULL,
	X1Po [tinyint] NULL,
	X1N varchar(1) NULL,
	X1D varchar(1) NULL,
	X1R [tinyint] NULL,
	X2PL varchar(3) NULL,
	X2Po [tinyint] NULL,
	X2N varchar(1) NULL,
	X2D varchar(1) NULL,
	X2R [tinyint] NULL,
	YPL varchar(3) NULL,
	YPo [tinyint] NULL,
	YN varchar(1) NULL,
	YD varchar(1) NULL,
	YR [tinyint] NULL,
	Y1PL varchar(3) NULL,
	Y1Po [tinyint] NULL,
	Y1N varchar(1) NULL,
	Y1D varchar(1) NULL,
	Y1R [tinyint] NULL,
	Y2PL varchar(3) NULL,
	Y2Po [tinyint] NULL,
	Y2N varchar(1) NULL,
	Y2D varchar(1) NULL,
	Y2R [tinyint] NULL,
	CXPL varchar(3) NULL,
	CXPo [tinyint] NULL,
	CXN varchar(1) NULL,
	CXD varchar(1) NULL,
	CXR [tinyint] NULL,
	CX1PL varchar(3) NULL,
	CX1Po [tinyint] NULL,
	CX1N varchar(1) NULL,
	CX1D varchar(1) NULL,
	CX1R [tinyint] NULL,
	CX2PL varchar(3) NULL,
	CX2Po [tinyint] NULL,
	CX2N varchar(1) NULL,
	CX2D varchar(1) NULL,
	CX2R [tinyint] NULL,
	CYPL varchar(3) NULL,
	CYPo [tinyint] NULL,
	CYN varchar(1) NULL,
	CYD varchar(1) NULL,
	CYR [tinyint] NULL,
	CY1PL varchar(3) NULL,
	CY1Po [tinyint] NULL,
	CY1N varchar(1) NULL,
	CY1D varchar(1) NULL,
	CY1R [tinyint] NULL,
	CY2PL varchar(3) NULL,
	CY2Po [tinyint] NULL,
	CY2N varchar(1) NULL,
	CY2D varchar(1) NULL,
	CY2R [tinyint] NULL)
		
		insert into #Astro
		SELECT  w.PDate as Date, w.KeyPlanet as KP,
				case when ft.DayLordTrent = 1 then '1' else '' end DL, 
				case when ft.MoonTrent  = 1 then '1' else '' end MO, 
				case when ft.ExchangeTrent = 1 then '1' else '' end  EX, 
				pdx.PlanetShortDesc as xPl, tx.Position as Po, 
				vx.NatureShortDesc as N,tx.ShortDirection as D, 
			px.Retro as R, 
			isnull(pdx1.PlanetShortDesc,'') as x1Pl, 
			isnull(tx1.Position,'') as Po, 
			isnull(vx1.NatureShortDesc,'') as N,
			isnull(tx1.ShortDirection,'') as D, 
			isnull(px1.Retro,'') as R,
			isnull(pdx2.PlanetShortDesc,'') as x2Pl, 
				isnull(tx2.Position,'') as Po, 
				isnull(vx2.NatureShortDesc,'') as N,
				isnull(tx2.ShortDirection,'') as D, 
				isnull(px2.Retro,'') as R, 
			isnull(pdy.PlanetShortDesc,'') as yPl, 
			isnull(ty.Position,'') as Po, 
			isnull(vy.NatureShortDesc,'') as N,
			isnull(ty.ShortDirection,'') as D, 
			isnull(py.Retro,'') as R,
			isnull(pdy1.PlanetShortDesc,'') as y1Pl, 
			isnull(ty1.Position,'') as Po, 
			isnull(vy1.NatureShortDesc,'') as N,
			isnull(ty1.ShortDirection,'') as D, 
			isnull(py1.Retro,'') as R,
			isnull(pdy2.PlanetShortDesc,'') as y2Pl, 
				isnull(ty2.Position,'') as Po, 
				isnull(vy2.NatureShortDesc,'') as N,
				isnull(ty2.ShortDirection,'') as D, 
				isnull(py2.Retro,'') as R,
					isnull(pdcx.PlanetShortDesc,'') as cxPl, 
			isnull(tcx.Position,'') as Po, 
			isnull(vcx.NatureShortDesc,'') as N,
			isnull(tcx.ShortDirection,'') as D, 
			isnull(pcx.Retro,'') as R, 
			isnull(pdcx1.PlanetShortDesc,'') as cx1Pl, 
			isnull(tcx1.Position,'') as Po, 
			isnull(vcx1.NatureShortDesc,'') as N,
			isnull(tcx1.ShortDirection,'') as D, 
			isnull(pcx1.Retro,'') as R,
			isnull(pdcx2.PlanetShortDesc,'') as cx2Pl, 
				isnull(tcx2.Position,'') as Po, 
				isnull(vcx2.NatureShortDesc,'') as N,
				isnull(tcx2.ShortDirection,'') as D, 
				isnull(pcx2.Retro,'') as R, 
			isnull(pdcy.PlanetShortDesc,'') as cyPl, 
			isnull(tcy.Position,'') as Po, 
			isnull(vcy.NatureShortDesc,'') as N,
			isnull(tcy.ShortDirection,'') as D, 
			isnull(pcy.Retro,'') as R,
			isnull(pdcy1.PlanetShortDesc,'') as cy1Pl, 
			isnull(tcy1.Position,'') as Po, 
			isnull(vcy1.NatureShortDesc,'') as N,
			isnull(tcy1.ShortDirection,'') as D, 
			isnull(pcy1.Retro,'') as R,
			isnull(pdcy2.PlanetShortDesc,'') as cy2Pl, 
				isnull(tcy2.Position,'') as Po, 
				isnull(vcy2.NatureShortDesc,'') as N,
				isnull(tcy2.ShortDirection,'') as D, 
				isnull(pcy2.Retro,'') as R
			
	  FROM tbl_Work w
	  Left outer join tbl_FinalTrent ft
	  on ft.PDate = w.PDate 
		and ft.KeyPlanet = w.KeyPlanet 
	  Left outer join tbl_PlanetDesc pdx
	  on pdx.Planet = w.XPlanet
	  Left outer join tbl_Trent tx
	  on tx.Position = w.XPosition
	  Left outer join tbl_Planet px
	  on px.PDate = w.PDate
		and px.Planet = w.XPlanet 
	  Left outer join tbl_Volume vx
	  on vx.Planet = w.XPlanet
		and vx.Retro = px.Retro
	Left outer join tbl_PlanetDesc pdx1
	  on pdx1.Planet = w.x1Planet
	  Left outer join tbl_Trent tx1
	  on tx1.Position = w.x1Position
	  Left outer join tbl_Planet px1
	  on px1.PDate = w.PDate
		and px1.Planet = w.x1Planet 
	  Left outer join tbl_Volume vx1
	  on vx1.Planet = w.x1Planet
		and vx1.Retro = px1.Retro
	Left outer join tbl_PlanetDesc pdx2
		  on pdx2.Planet = w.x2Planet
		  Left outer join tbl_Trent tx2
		  on tx2.Position = w.x2Position
		  Left outer join tbl_Planet px2
		  on px2.PDate = w.PDate
			and px2.Planet = w.x2Planet 
		  Left outer join tbl_Volume vx2
		  on vx2.Planet = w.x2Planet
			and vx2.Retro = px2.Retro
		  Left outer join tbl_PlanetDesc pdy
	  on pdy.Planet = w.yPlanet
	  Left outer join tbl_Trent ty
	  on ty.Position = w.yPosition
	  Left outer join tbl_Planet py
	  on py.PDate = w.PDate
		and py.Planet = w.yPlanet 
	  Left outer join tbl_Volume vy
	  on vy.Planet = w.yPlanet
		and vy.Retro = py.Retro
	Left outer join tbl_PlanetDesc pdy1
	  on pdy1.Planet = w.y1Planet
	  Left outer join tbl_Trent ty1
	  on ty1.Position = w.y1Position
	  Left outer join tbl_Planet py1
	  on py1.PDate = w.PDate
		and py1.Planet = w.y1Planet 
	  Left outer join tbl_Volume vy1
	  on vy1.Planet = w.y1Planet
		and vy1.Retro = py1.Retro
	Left outer join tbl_PlanetDesc pdy2
		  on pdy2.Planet = w.y2Planet
		  Left outer join tbl_Trent ty2
		  on ty2.Position = w.y2Position
		  Left outer join tbl_Planet py2
		  on py2.PDate = w.PDate
			and py2.Planet = w.y2Planet 
		  Left outer join tbl_Volume vy2
		  on vy2.Planet = w.y2Planet
			and vy2.Retro = py2.Retro
		  Left outer join tbl_Conjuction c
	  on c.PDate = w.PDate
		and c.KeyPlanet = w.KeyPlanet
	  Left outer join tbl_PlanetDesc pdcx
	  on pdcx.Planet = c.XPlanet
	  Left outer join tbl_Trent tcx
	  on tcx.Position = c.XPosition
	  Left outer join tbl_Planet pcx
	  on pcx.PDate = w.PDate
		and pcx.Planet = c.XPlanet 
	  Left outer join tbl_Volume vcx
	  on vcx.Planet = c.XPlanet
		and vcx.Retro = pcx.Retro
	Left outer join tbl_PlanetDesc pdcx1
	  on pdcx1.Planet = c.X1Planet
	  Left outer join tbl_Trent tcx1
	  on tcx1.Position = c.X1Position
	  Left outer join tbl_Planet pcx1
	  on pcx1.PDate = w.PDate
		and pcx1.Planet = c.X1Planet 
	  Left outer join tbl_Volume vcx1
	  on vcx1.Planet = c.X1Planet
		and vcx1.Retro = pcx1.Retro
	Left outer join tbl_PlanetDesc pdcx2
		  on pdcx2.Planet = c.X2Planet
		  Left outer join tbl_Trent tcx2
		  on tcx2.Position = c.X2Position
		  Left outer join tbl_Planet pcx2
		  on pcx2.PDate = w.PDate
			and pcx2.Planet = c.X2Planet 
		  Left outer join tbl_Volume vcx2
		  on vcx2.Planet = c.X2Planet
			and vcx2.Retro = pcx2.Retro
		  Left outer join tbl_PlanetDesc pdcy
	  on pdcy.Planet = c.YPlanet
	  Left outer join tbl_Trent tcy
	  on tcy.Position = c.YPosition
	  Left outer join tbl_Planet pcy
	  on pcy.PDate = w.PDate
		and pcy.Planet = c.YPlanet 
	  Left outer join tbl_Volume vcy
	  on vcy.Planet = c.YPlanet
		and vcy.Retro = pcy.Retro
	Left outer join tbl_PlanetDesc pdcy1
	  on pdcy1.Planet = c.Y1Planet
	  Left outer join tbl_Trent tcy1
	  on tcy1.Position = c.Y1Position
	  Left outer join tbl_Planet pcy1
	  on pcy1.PDate = w.PDate
		and pcy1.Planet = c.Y1Planet 
	  Left outer join tbl_Volume vcy1
	  on vcy1.Planet = c.Y1Planet
		and vcy1.Retro = pcy1.Retro
	Left outer join tbl_PlanetDesc pdcy2
		  on pdcy2.Planet = c.Y2Planet
		  Left outer join tbl_Trent tcy2
		  on tcy2.Position = c.Y2Position
		  Left outer join tbl_Planet pcy2
		  on pcy2.PDate = w.PDate
			and pcy2.Planet = c.Y2Planet 
		  Left outer join tbl_Volume vcy2
		  on vcy2.Planet = c.Y2Planet
			and vcy2.Retro = pcy2.Retro
		  order by 2
		  
		  Insert into #date
		  Select w.PDate from 
			tbl_Work w
		  Where w.KeyPlanet = 4
			and w.PDate between @D1 and @D2 
	
		Select a.Symbol, a.Planets,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			h.Symbol, st.Planets , h.OCP, h.PHP, h.PLP, h.PCP, h.POP
			
			from #Astro am
		  inner join #date d
		  on d.mPDate = am.PDate
		  inner join tbl_Planet mp
		  on mp.PDate = d.mPDate
			and mp.Planet = 4
		  inner join tbl_Work mw
		  on mw.PDate = d.mPDate
		  and mw.KeyPlanet = 4
		  inner join tbl_Planet xp
		  on xp.PDate = d.mPDate
			and xp.Planet = mw.XPlanet
		  inner join #Astro s
		  on s.PDate = d.mPDate
			and s.KP = 3
		  inner join tbl_Planet sp
		  on sp.PDate = d.mPDate
			and sp.Planet = 3
		  inner join #Astro j
		  on j.PDate = d.mPDate
			and j.KP = 7
		  inner join tbl_Planet jp
		  on jp.PDate = d.mPDate
			and jp.Planet = 7
		  inner join tbl_NewConjuction mc
		  on mc.PDate = d.mPDate
		   and mc.KeyPlanet = 4
		  inner join tbl_NewConjuction sc
		  on sc.PDate = d.mPDate
		   and sc.KeyPlanet = 3
		  inner join tbl_NewConjuction jc
		  on jc.PDate = d.mPDate
		   and jc.KeyPlanet = 7
		  inner join tbl_DayPosition  dp
		  on dp.PDate = d.mPDate
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = am.PDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol 
			 where am.KP = 4
				and am.XPL +' '+ convert(varchar(2),am.XPo) = case when isnull(@MX,'') <> '' then @MX else am.XPL +' '+ convert(varchar(2),am.XPo) end
				and am.X1PL +' '+ convert(varchar(2),am.X1Po)= case when isnull(@MX1,'') <> '' then @MX1 else am.X1PL +' '+ convert(varchar(2),am.X1Po) end
				and am.X2PL +' '+ convert(varchar(2),am.X2Po)= case when isnull(@MX2,'') <> '' then @MX2 else am.X2PL +' '+ convert(varchar(2),am.X2Po) end
				and am.YPL +' '+ convert(varchar(2),am.YPo)= case when isnull(@MY,'') <> '' then @MY else am.YPL +' '+ convert(varchar(2),am.YPo) end
				and am.Y1PL +' '+ convert(varchar(2),am.Y1Po)= case when isnull(@MY1,'') <> '' then @MY1 else am.Y1PL +' '+ convert(varchar(2),am.Y1Po) end
				and am.Y2PL +' '+ convert(varchar(2),am.Y2Po)= case when isnull(@MY2,'') <> '' then @MY2 else am.Y2PL +' '+ convert(varchar(2),am.Y2Po) end
				and s.XPL +' '+ convert(varchar(2),s.XPo) = case when isnull(@SX,'') <> '' then @SX else s.XPL +' '+ convert(varchar(2),s.XPo) end
--				and s.YPL +' '+ convert(varchar(2),s.YPo) = case when isnull(@SX,'') <> '' then @SX else s.YPL +' '+ convert(varchar(2),s.YPo) end
				and j.XPL +' '+ convert(varchar(2),j.XPo) = case when isnull(@JX,'') <> '' then @JX else j.XPL +' '+ convert(varchar(2),j.XPo) end
				and case 
						when ISNULL(sc.KPlanet,'0') <> '0' then sc.KPlanet
						when sp.Degree % 48000 between 0	 and 11999 then 
							case 
								when s.X1Po = 0 then s.XPL  
								else s.X1PL 
							end
						when sp.Degree % 48000 between 12000 and 23999 then 
							case 
								when s.X1Po = 0 and s.X2Po = 0 then s.XPL  
								when s.X1Po = 0 then s.XPL 
								else s.X1PL 
							end
						when sp.Degree % 48000 between 24000 and 35999 then 
							case 
								when s.Y1Po = 0 then s.YPL  
								else s.Y1PL 
							end
						when sp.Degree % 48000 between 36000 and 47999 then 
							case 
								when s.Y1Po = 0 and s.Y2Po = 0 then s.YPL  
								when s.Y1Po = 0 then s.YPL 
								else s.Y1PL 
							end
					end like @SA1
				and case 
						when ISNULL(sc.KPlanet,'0') <> '0' then sc.KPlanet
						when sp.Degree % 48000 between 0	 and 11999 then 
							case 
								when s.X1Po = 0 then s.XPL  
								else s.X1PL 
							end
						when sp.Degree % 48000 between 12000 and 23999 then 
							case 
								when s.X1Po = 0 and s.X2Po = 0 then s.XPL  
								when s.X1Po = 0 then s.XPL 
								else s.X1PL 
							end
						when sp.Degree % 48000 between 24000 and 35999 then 
							case 
								when s.Y1Po = 0 then s.YPL  
								else s.Y1PL 
							end
						when sp.Degree % 48000 between 36000 and 47999 then 
							case 
								when s.Y1Po = 0 and s.Y2Po = 0 then s.YPL  
								when s.Y1Po = 0 then s.YPL 
								else s.Y1PL 
							end
					end like @SA2
				and case 
						when ISNULL(sc.KPlanet,'0') <> '0' then sc.KPlanet
						when sp.Degree % 48000 between 0	 and 11999 then 
							case 
								when s.X1Po = 0 then s.XPL  
								else s.X1PL 
							end
						when sp.Degree % 48000 between 12000 and 23999 then 
							case 
								when s.X1Po = 0 and s.X2Po = 0 then s.XPL  
								when s.X1Po = 0 then s.XPL 
								else s.X1PL 
							end
						when sp.Degree % 48000 between 24000 and 35999 then 
							case 
								when s.Y1Po = 0 then s.YPL  
								else s.Y1PL 
							end
						when sp.Degree % 48000 between 36000 and 47999 then 
							case 
								when s.Y1Po = 0 and s.Y2Po = 0 then s.YPL  
								when s.Y1Po = 0 then s.YPL 
								else s.Y1PL 
							end
					end like @SA3
				and case 
						when ISNULL(sc.KPlanet,'0') <> '0' then sc.KPlanet
						when sp.Degree % 48000 between 0	 and 11999 then 
							case 
								when s.X1Po = 0 then s.XPL  
								else s.X1PL 
							end
						when sp.Degree % 48000 between 12000 and 23999 then 
							case 
								when s.X1Po = 0 and s.X2Po = 0 then s.XPL  
								when s.X1Po = 0 then s.XPL 
								else s.X1PL 
							end
						when sp.Degree % 48000 between 24000 and 35999 then 
							case 
								when s.Y1Po = 0 then s.YPL  
								else s.Y1PL 
							end
						when sp.Degree % 48000 between 36000 and 47999 then 
							case 
								when s.Y1Po = 0 and s.Y2Po = 0 then s.YPL  
								when s.Y1Po = 0 then s.YPL 
								else s.Y1PL 
							end
					end like @SA4					
				and case 
							when ISNULL(jc.KPlanet,'0') <> '0' then jc.KPlanet
						when jp.Degree % 48000 between 0	 and 11999 then 
							case 
								when j.X1Po = 0 then j.XPL  
								else j.X1PL 
							end
						when jp.Degree % 48000 between 12000 and 23999 then 
							case 
								when j.X1Po = 0 and j.X2Po = 0 then j.XPL  
								when j.X1Po = 0 then j.XPL 
								else j.X1PL 
							end
						when jp.Degree % 48000 between 24000 and 35999 then 
							case 
								when j.Y1Po = 0 then j.YPL  
								else j.Y1PL 
							end
						when jp.Degree % 48000 between 36000 and 47999 then 
							case 
								when j.Y1Po = 0 and j.Y2Po = 0 then j.YPL  
								when j.Y1Po = 0 then j.YPL 
								else j.Y1PL 
							end
					end like @JA1
				and case 
							when ISNULL(jc.KPlanet,'0') <> '0' then jc.KPlanet
						when jp.Degree % 48000 between 0	 and 11999 then 
							case 
								when j.X1Po = 0 then j.XPL  
								else j.X1PL 
							end
						when jp.Degree % 48000 between 12000 and 23999 then 
							case 
								when j.X1Po = 0 and j.X2Po = 0 then j.XPL  
								when j.X1Po = 0 then j.XPL 
								else j.X1PL 
							end
						when jp.Degree % 48000 between 24000 and 35999 then 
							case 
								when j.Y1Po = 0 then j.YPL  
								else j.Y1PL 
							end
						when jp.Degree % 48000 between 36000 and 47999 then 
							case 
								when j.Y1Po = 0 and j.Y2Po = 0 then j.YPL  
								when j.Y1Po = 0 then j.YPL 
								else j.Y1PL 
							end
					end like @JA2
				and case 
							when ISNULL(jc.KPlanet,'0') <> '0' then jc.KPlanet
						when jp.Degree % 48000 between 0	 and 11999 then 
							case 
								when j.X1Po = 0 then j.XPL  
								else j.X1PL 
							end
						when jp.Degree % 48000 between 12000 and 23999 then 
							case 
								when j.X1Po = 0 and j.X2Po = 0 then j.XPL  
								when j.X1Po = 0 then j.XPL 
								else j.X1PL 
							end
						when jp.Degree % 48000 between 24000 and 35999 then 
							case 
								when j.Y1Po = 0 then j.YPL  
								else j.Y1PL 
							end
						when jp.Degree % 48000 between 36000 and 47999 then 
							case 
								when j.Y1Po = 0 and j.Y2Po = 0 then j.YPL  
								when j.Y1Po = 0 then j.YPL 
								else j.Y1PL 
							end
					end like @JA3
				and case 
							when ISNULL(jc.KPlanet,'0') <> '0' then jc.KPlanet
						when jp.Degree % 48000 between 0	 and 11999 then 
							case 
								when j.X1Po = 0 then j.XPL  
								else j.X1PL 
							end
						when jp.Degree % 48000 between 12000 and 23999 then 
							case 
								when j.X1Po = 0 and j.X2Po = 0 then j.XPL  
								when j.X1Po = 0 then j.XPL 
								else j.X1PL 
							end
						when jp.Degree % 48000 between 24000 and 35999 then 
							case 
								when j.Y1Po = 0 then j.YPL  
								else j.Y1PL 
							end
						when jp.Degree % 48000 between 36000 and 47999 then 
							case 
								when j.Y1Po = 0 and j.Y2Po = 0 then j.YPL  
								when j.Y1Po = 0 then j.YPL 
								else j.Y1PL 
							end
					end like @JA4
				and (
					case 
						when isnull(mc.KPlanet,'0') <> '0' then mc.KPlanet 
						when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
						when am.X1Po = 0 then am.XPL 
						when am.X2Po = 0 then am.X1PL 
						else am.X1PL +'/'+ am.X2PL
					end + '/' +	
					case 
						when isnull(mc.KPlanet,'0') <> '0' then 
							case 
								when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
								else am.XPL 						
							end
						when isnull(mc.KPlanet,'0') = '0' then 
							case
								when isnull(mc.YPlanet,'0') <> '0' then mc.YPlanet 
								when isnull(mc.XPlanet,'0') = '0' then
									case
										when am.Y1Po = 0 then am.YPL 
										when am.Y2Po = 0 then am.Y1PL
										else am.Y1PL +'/'+ am.Y2PL
									end
								else am.YPL
							end
					end like @MA1
						and 
					case 
						when isnull(mc.KPlanet,'0') <> '0' then mc.KPlanet 
						when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
						when am.X1Po = 0 then am.XPL 
						when am.X2Po = 0 then am.X1PL 
						else am.X1PL +'/'+ am.X2PL
					end + '/' +	
					case 
						when isnull(mc.KPlanet,'0') <> '0' then 
							case 
								when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
								else am.XPL 						
							end
						when isnull(mc.KPlanet,'0') = '0' then 
							case
								when isnull(mc.YPlanet,'0') <> '0' then mc.YPlanet 
								when isnull(mc.XPlanet,'0') = '0' then
									case
										when am.Y1Po = 0 then am.YPL 
										when am.Y2Po = 0 then am.Y1PL
										else am.Y1PL +'/'+ am.Y2PL
									end
								else am.YPL
							end
					end like @MA2
						and
						case 
						when isnull(mc.KPlanet,'0') <> '0' then mc.KPlanet 
						when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
						when am.X1Po = 0 then am.XPL 
						when am.X2Po = 0 then am.X1PL 
						else am.X1PL +'/'+ am.X2PL
					end + '/' +	
					case 
						when isnull(mc.KPlanet,'0') <> '0' then 
							case 
								when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
								else am.XPL 						
							end
						when isnull(mc.KPlanet,'0') = '0' then 
							case
								when isnull(mc.YPlanet,'0') <> '0' then mc.YPlanet 
								when isnull(mc.XPlanet,'0') = '0' then
									case
										when am.Y1Po = 0 then am.YPL 
										when am.Y2Po = 0 then am.Y1PL
										else am.Y1PL +'/'+ am.Y2PL
									end
								else am.YPL
							end
					end like @MA3
						and 
					case 
						when isnull(mc.KPlanet,'0') <> '0' then mc.KPlanet 
						when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
						when am.X1Po = 0 then am.XPL 
						when am.X2Po = 0 then am.X1PL 
						else am.X1PL +'/'+ am.X2PL
					end + '/' +	
					case 
						when isnull(mc.KPlanet,'0') <> '0' then 
							case 
								when isnull(mc.XPlanet,'0') <> '0' then mc.XPlanet  
								else am.XPL 						
							end
						when isnull(mc.KPlanet,'0') = '0' then 
							case
								when isnull(mc.YPlanet,'0') <> '0' then mc.YPlanet 
								when isnull(mc.XPlanet,'0') = '0' then
									case
										when am.Y1Po = 0 then am.YPL 
										when am.Y2Po = 0 then am.Y1PL
										else am.Y1PL +'/'+ am.Y2PL
									end
								else am.YPL
							end
					end like @MA4
					)
			 and Convert(int,dp.MSPosition) = 
				case when @MSi <> 0  then @MSi 
					else Convert(int,dp.MSPosition) end
			 and Convert(int,dp.SMPosition) = 
				case when @SMi <> 0  then @SMi 
					else Convert(int,dp.SMPosition) end
			 and Datepart(W,am.PDate) not in (1,7)
			-- and (year(am.PDate) = 2018 and month(am.PDate) > 5 
			--		or
			--		year(am.PDate) = 2018 and month(am.PDate) = 5 and DAY(am.PDate)> 19 )
			 ) as a
		 where OCP < 35 and PCP > -35
--		 and a.Symbol like 'INFY%'
		 group by a.Symbol, a.Planets
		-- order by (avg(PHP) / avg(PLP) * -1) desc
		 --9 desc
  
end

GO

