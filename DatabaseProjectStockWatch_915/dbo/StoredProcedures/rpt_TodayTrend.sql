CREATE proc [dbo].[rpt_TodayTrend]
(
@DATE VARCHAR(10) out,
@DAY VARCHAR(10) OUT,
@DL VARCHAR(1) OUT,
@MM VARCHAR(1) OUT,
@EX VARCHAR(1) OUT,
@TS VARCHAR(5) OUT,
@MS VARCHAR(2) OUT,
@SM VARCHAR(2) OUT,
@MA VARCHAR(30) OUT,
@MT VARCHAR(30) OUT,
@MX VARCHAR(6) OUT,
@MX1 VARCHAR(6) OUT,
@MX2 VARCHAR(6) OUT,
@MY VARCHAR(6) OUT,
@MY1 VARCHAR(6) OUT,
@MY2 VARCHAR(6) OUT,
@MC VARCHAR(30) OUT,
@MCX VARCHAR(30) OUT,
@MCX1 VARCHAR(6) OUT,
@MCX2 VARCHAR(6) OUT,
@MCY VARCHAR(30) OUT,
@MCY1 VARCHAR(6) OUT,
@MCY2 VARCHAR(6) OUT,
@SA VARCHAR(30) OUT,
@ST VARCHAR(30) OUT,
@SX VARCHAR(6) OUT,
@SX1 VARCHAR(6) OUT,
@SX2 VARCHAR(6) OUT,
@SY VARCHAR(6) OUT,
@SY1 VARCHAR(6) OUT,
@SY2 VARCHAR(6) OUT,
@SC VARCHAR(30) OUT,
@SCX VARCHAR(30) OUT,
@SCX1 VARCHAR(6) OUT,
@SCX2 VARCHAR(6) OUT,
@SCY VARCHAR(30) OUT,
@SCY1 VARCHAR(6) OUT,
@SCY2 VARCHAR(6) OUT,
@JA VARCHAR(30) OUT,
@JT VARCHAR(30) OUT,
@JX VARCHAR(6) OUT,
@JX1 VARCHAR(6) OUT,
@JX2 VARCHAR(6) OUT,
@JY VARCHAR(6) OUT,
@JY1 VARCHAR(6) OUT,
@JY2 VARCHAR(6) OUT,
@JC VARCHAR(30) OUT,
@JCX VARCHAR(30) OUT,
@JCX1 VARCHAR(6) OUT,
@JCX2 VARCHAR(6) OUT,
@JCY VARCHAR(30) OUT,
@JCY1 VARCHAR(6) OUT,
@JCY2 VARCHAR(6) OUT,
@Sector VARCHAR(200) OUT,
@Script VARCHAR(200) OUT,
@Conjuction varchar(200) OUT,
@Retro varchar(200) OUT,
@PlanetSequence varchar(500) OUT,
@Sequence30 varchar(500) OUT,
@StarPlanet varchar(500) OUT,
@Element varchar(500) OUT
)
as
begin
		Declare @MC1 varchar(30), @SC1 varchar(30), @JC1 varchar(30)
		create table #date(mPDate smalldatetime, sPDate smalldatetime, jPDate smalldatetime)
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
		
	Select @DATE = case when isnull(@DATE,'') = '' then convert(varchar(10),GETDATE(),102)
			else @DATE end
	Select @Element = 'SSumD '+ e.SSumD + ' KSumD '+ e.KSumD 
		+ ' CSumD '+ e.CSumD + ' SSum '+ e.SSum 
		+ ' KSum '+ e.KSum + ' CSum '+ e.CSum 
		+ ' SumOr '+ e.SumOr + ' CSOr '+ e.CSOr 
		+ ' CKOr '+ e.CKOr + ' CSKOr '+ e.CSKOr 
	from tbl_Element e where convert(varchar(10),e.PDate,102)  = @DATE
	
	Select @Element = @Element + '     Z = ' + d.PlanetShortDesc + ' ' + CONVERT(varchar(2),z.ZPosition)
		+ '          Z Conj = ' + isnull(z.ZConjuction,'    ')
	From tbl_ZPlanet z
	inner join tbl_PlanetDesc d
	on d.Planet = z.ZPlanet
	and convert(varchar(10),z.PDate,102) = @DATE
	
	Select @Element = @Element + '     SS = ' + d.PlanetShortDesc + ' ' + CONVERT(varchar(2),ss.XPosition)
		+ '          SSY = ' + dy.PlanetShortDesc + ' ' + CONVERT(varchar(2),ss.YPosition)
	From tbl_Work ss
	inner join tbl_PlanetDesc d
	on d.Planet = ss.XPlanet
	inner join tbl_PlanetDesc dy
	on dy.Planet = ss.YPlanet
	where ss.KeyPlanet = 30
	and convert(varchar(10),ss.PDate,102) = @DATE
	
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
	where convert(varchar(10),w.PDate,102) = @DATE
		  order by 2
		  Insert into #date
		  Select w.PDate, null, null from 
			tbl_Work w
		  Where w.KeyPlanet = 4

--daily begin

		 select 
			@Retro = dp.RPlanet,
			@Conjuction = dp.CPosition,
			@StarPlanet = dp.StarPosition,
			@Sequence30 = dp.S30Position,
			@PlanetSequence = dp.SPosition,
			@DATE = convert(varchar(10),am.PDate,102) , 
			@DAY = case 
				when Datepart(W,am.PDate) = 1 then 'Sun'
				when Datepart(W,am.PDate) = 2 then 'Mon'
				when Datepart(W,am.PDate) = 3 then 'Tue'
				when Datepart(W,am.PDate) = 4 then 'Wed'
				when Datepart(W,am.PDate) = 5 then 'Thu'
				when Datepart(W,am.PDate) = 6 then 'Fri'
				when Datepart(W,am.PDate) = 7 then 'Sat'
			end , 
			@MX= am.XPL +' '+ convert(varchar(2),am.XPo) , 
			@MX1= am.X1PL +' '+ convert(varchar(2),am.X1Po) , 
			@MX2= am.X2PL +' '+ convert(varchar(2),am.X2Po) ,   
			@MY= am.YPL +' '+ convert(varchar(2),am.YPo) , 
			@MY1= am.Y1PL +' '+ convert(varchar(2),am.Y1Po) , 
			@MY2= am.Y2PL +' '+ convert(varchar(2),am.Y2Po) , 
			@DL= case 
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 1 and am.XPL = 'Sun' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 2 and am.XPL = 'Moo' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 3 and am.XPL = 'Mar' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 4 and am.XPL = 'Mer' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 5 and am.XPL = 'Jup' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 6 and am.XPL = 'Ven' then '1'
				when am.X1Po = 0 and Datepart(Weekday, am.PDate) = 7 and am.XPL = 'Sat' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 1 and am.YPL = 'Sun' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 2 and am.YPL = 'Moo' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 3 and am.YPL = 'Mar' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 4 and am.YPL = 'Mer' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 5 and am.YPL = 'Jup' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 6 and am.YPL = 'Ven' then '1'
				when am.Y1Po = 0 and Datepart(Weekday, am.PDate) = 7 and am.YPL = 'Sat' then '1'
				else ''
			end ,--'Day Lord',
			@MM= case 
				when am.X1Po = 0 and am.XPL = 'Moo' then '1'
				when am.Y1Po = 0 and am.YPL = 'Moo' then '1'
				else ''
			end ,--'Moon Trend',			
			@EX= case 
				when am.X1Po = 0 and am.Y1Po = 0 and am.Ex = 1 then '1'
				else ''
			end , --'Exchange Trend',
			@MT= 			case 
				when isnull(mc.KPlanet,'0') <> '0' 
					then dbo.Get_Trentbyconj(mc.KPlanet, mc.KPosition) 
				when isnull(mc.XPlanet,'0') <> '0' 
					then dbo.Get_Trentbyconj(mc.XPlanet, mc.XPosition)
				when am.X1Po = 0 then dbo.Get_Trent(am.XPo)
				when am.X2Po = 0 then dbo.Get_Trent(am.X1Po)
				else dbo.Get_Trent(am.X1Po) +'/'+ dbo.Get_Trent(am.X2Po)
			end + '/' +	
			case 
				when isnull(mc.KPlanet,'0') <> '0' then 
					case 
						when isnull(mc.XPlanet,'0') <> '0' 
							then dbo.Get_Trentbyconj(mc.XPlanet, mc.XPosition)  
						else dbo.Get_Trent(am.XPo)					
					end
				when isnull(mc.KPlanet,'0') = '0' then 
					case
						when isnull(mc.YPlanet,'0') <> '0' 
							then dbo.Get_Trentbyconj(mc.YPlanet, mc.YPosition) 
						when isnull(mc.XPlanet,'0') = '0' then
							case
								when am.Y1Po = 0 then dbo.Get_Trent(am.YPo)
								when am.Y2Po = 0 then dbo.Get_Trent(am.Y1Po)
								else dbo.Get_Trent(am.Y1Po) +'/'+ dbo.Get_Trent(am.Y2Po)
							end
						else dbo.Get_Trent(am.YPo)
					end
			end,	
			@TS= dp.TSTime,
			--convert(varchar(6), convert(numeric(5,2), case when mp.Degree % 48000 > 36000 
			--	then ((48000-(mp.Degree % 48000.0))*1.65/3600)+9.25 end)) ,
			@MS= dp.MSPosition, --convert(varchar(5),(mp.Degree / 48000) + 1) ,
			@SM= dp.SMPosition, --convert(varchar(5),((1296000 +  mp.Degree - sp.Degree) % 1296000 / 43200) +1) ,
			@MA= 
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
			end ,
			@MC = mc.KPosition,
			@MCX= mc.XPosition,
			@MCX1= am.CX1PL +' '+ convert(varchar(2),am.CX1Po) ,
			@MCX2= am.CX2PL +' '+ convert(varchar(2),am.CX2Po) ,
			@MCY= mc.YPosition ,		
			@MCY1= am.CY1PL +' '+ convert(varchar(2),am.CY1Po) ,
			@MCY2= am.CY2PL +' '+ convert(varchar(2),am.CY2Po) ,
			@Sector = dbo.Get_Sector_New(case 
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
			end) ,
			@Script = dbo.Get_Stock_New(case 
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
			end) ,
	/*		@Playmate = dbo.Get_Playmate_New(case 
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
			end) ,
--			am.CYPL, am.CYPo,*/			
			@SA = case 
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
			end 
			/*+ ' ' + convert(varchar(2),
			case 
				when sp.Degree % 48000 between 0	 and 11999 then 
					case 
						when s.X1Po = 0 then s.XPo  
						else s.X1Po 
					end
				when sp.Degree % 48000 between 12000 and 23999 then 
					case 
						when s.X1Po = 0 and s.X2Po = 0 then s.XPo  
						when s.X1Po = 0 then s.XPo 
						else s.X1Po 
					end
				when sp.Degree % 48000 between 24000 and 35999 then 
					case 
						when s.Y1Po = 0 then s.YPo  
						else s.Y1Po 
					end
				when sp.Degree % 48000 between 36000 and 47999 then 
					case 
						when s.Y1Po = 0 and s.Y2Po = 0 then s.YPo  
						when s.Y1Po = 0 then s.YPo 
						else s.Y1Po 
					end
			end)*/		,
			@ST = case 
				when sp.Degree % 48000 between 0	 and 11999 then 
					case 
						when s.X1Po = 0 then s.XD  
						else s.X1D 
					end
				when sp.Degree % 48000 between 12000 and 23999 then 
					case 
						when s.X1Po = 0 and s.X2Po = 0 then s.XD  
						when s.X1Po = 0 then s.XD 
						else s.X1D 
					end
				when sp.Degree % 48000 between 24000 and 35999 then 
					case 
						when s.Y1Po = 0 then s.YD  
						else s.Y1D 
					end
				when sp.Degree % 48000 between 36000 and 47999 then 
					case 
						when s.Y1Po = 0 and s.Y2Po = 0 then s.YD  
						when s.Y1Po = 0 then s.YD 
						else s.Y1D 
					end
			end ,
			@JA = case 
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
			end /*+ ' ' + convert(varchar(2),
			case 
				when jp.Degree % 48000 between 0	 and 11999 then 
					case 
						when j.X1Po = 0 then j.XPo  
						else j.X1Po 
					end
				when jp.Degree % 48000 between 12000 and 23999 then 
					case 
						when j.X1Po = 0 and j.X2Po = 0 then j.XPo  
						when j.X1Po = 0 then j.XPo 
						else j.X1Po 
					end
				when jp.Degree % 48000 between 24000 and 35999 then 
					case 
						when j.Y1Po = 0 then j.YPo  
						else j.Y1Po 
					end
				when jp.Degree % 48000 between 36000 and 47999 then 
					case 
						when j.Y1Po = 0 and j.Y2Po = 0 then j.YPo  
						when j.Y1Po = 0 then j.YPo 
						else j.Y1Po 
					end
			end)*/		,
			@JT = case 
				when jp.Degree % 48000 between 0	 and 11999 then 
					case 
						when j.X1Po = 0 then j.XD  
						else j.X1D 
					end
				when jp.Degree % 48000 between 12000 and 23999 then 
					case 
						when j.X1Po = 0 and j.X2Po = 0 then j.XD  
						when j.X1Po = 0 then j.XD 
						else j.X1D 
					end
				when jp.Degree % 48000 between 24000 and 35999 then 
					case 
						when j.Y1Po = 0 then j.YD  
						else j.Y1D 
					end
				when jp.Degree % 48000 between 36000 and 47999 then 
					case 
						when j.Y1Po = 0 and j.Y2Po = 0 then j.YD  
						when j.Y1Po = 0 then j.YD 
						else j.Y1D 
					end
			end ,
			@SX = s.XPL +' '+ convert(varchar(2),s.XPo) , 
			@SX1 = s.X1PL +' '+ convert(varchar(2),s.X1Po) , 
			@SX2 = s.X2PL +' '+ convert(varchar(2),s.X2Po) ,   
			@SY = s.YPL +' '+ convert(varchar(2),s.YPo) , 
			@SY1 = s.Y1PL +' '+ convert(varchar(2),s.Y1Po) , 
			@SY2 = s.Y2PL +' '+ convert(varchar(2),s.Y2Po) ,
			@JX = j.XPL +' '+ convert(varchar(2),j.XPo) , 
			@JX1 = j.X1PL +' '+ convert(varchar(2),j.X1Po) , 
			@JX2 = j.X2PL +' '+ convert(varchar(2),j.X2Po) ,   
			@JY = j.YPL +' '+ convert(varchar(2),j.YPo) , 
			@JY1 = j.Y1PL +' '+ convert(varchar(2),j.Y1Po) , 
			@JY2 = j.Y2PL +' '+ convert(varchar(2),j.Y2Po) ,
			
			@SC = sc.KPosition,
			@SCX= sc.XPosition,
			@SCX1= s.CX1PL +' '+ convert(varchar(2),s.CX1Po) ,
			@SCX2= s.CX2PL +' '+ convert(varchar(2),s.CX2Po) ,
			@SCY= sc.YPosition ,		
			@SCY1= s.CY1PL +' '+ convert(varchar(2),s.CY1Po) ,
			@SCY2= s.CY2PL +' '+ convert(varchar(2),s.CY2Po) ,
			@JC = jc.KPosition,
			@JCX= jc.XPosition,
			@JCX1= j.CX1PL +' '+ convert(varchar(2),j.CX1Po) ,
			@JCX2= j.CX2PL +' '+ convert(varchar(2),j.CX2Po) ,
			@JCY= jc.YPosition ,		
			@JCY1= j.CY1PL +' '+ convert(varchar(2),j.CY1Po) ,
			@JCY2= j.CY2PL +' '+ convert(varchar(2),j.CY2Po) 

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
		 where am.KP = 4
		 order by am.PDate 
		 
--Daily end
	
  
/*
BEGIN
DECLARE @d VARCHAR(10)
DECLARE @Y VARCHAR(10)
DECLARE
@DL VARCHAR(1) ,
@MM VARCHAR(1) ,
@EX VARCHAR(1) ,
@TS VARCHAR(5) ,
@MS VARCHAR(2) ,
@SM VARCHAR(2) ,
@MA VARCHAR(30) ,
@MT VARCHAR(30) ,
@MX VARCHAR(6) ,
@MX1 VARCHAR(6) ,
@MX2 VARCHAR(6) ,
@MY VARCHAR(6) ,
@MY1 VARCHAR(6) ,
@MY2 VARCHAR(6) ,
@MC VARCHAR(6) ,
@MCX VARCHAR(6) ,
@MCX1 VARCHAR(6) ,
@MCX2 VARCHAR(6) ,
@MCY VARCHAR(6) ,
@MCY1 VARCHAR(6) ,
@MCY2 VARCHAR(6) ,
@SA VARCHAR(30) ,
@ST VARCHAR(30) ,
@SX VARCHAR(6) ,
@SX1 VARCHAR(6) ,
@SX2 VARCHAR(6) ,
@SY VARCHAR(6) ,
@SY1 VARCHAR(6) ,
@SY2 VARCHAR(6) ,
@SC VARCHAR(6) ,
@SCX VARCHAR(6) ,
@SCX1 VARCHAR(6) ,
@SCX2 VARCHAR(6) ,
@SCY VARCHAR(6) ,
@SCY1 VARCHAR(6) ,
@SCY2 VARCHAR(6) ,
@JA VARCHAR(30) ,
@JT VARCHAR(30) ,
@JX VARCHAR(6) ,
@JX1 VARCHAR(6) ,
@JX2 VARCHAR(6) ,
@JY VARCHAR(6) ,
@JY1 VARCHAR(6) ,
@JY2 VARCHAR(6) ,
@JC VARCHAR(6) ,
@JCX VARCHAR(6) ,
@JCX1 VARCHAR(6) ,
@JCX2 VARCHAR(6) ,
@JCY VARCHAR(6) ,
@JCY1 VARCHAR(6) ,
@JCY2 VARCHAR(6) ,
@Sector VARCHAR(200) ,
@Script VARCHAR(200) ,
@Conjuction varchar(200) ,
@Retro varchar(200) ,
@PlanetSequence varchar(500) ,
@Sequence30 varchar(500) ,
@StarPlanet varchar(500) 
select @d = '2017.12.05'
EXEC [rpt_TodayTrend] @d out, @Y OUT, @DL  OUT,
@MM  OUT,
@EX  OUT,
@TS  OUT,
@MS  OUT,
@SM  OUT,
@MA  OUT,
@MT  OUT,
@MX  OUT,
@MX1  OUT,
@MX2  OUT,
@MY  OUT,
@MY1  OUT,
@MY2  OUT,
@MC  OUT,
@MCX  OUT,
@MCX1  OUT,
@MCX2  OUT,
@MCY  OUT,
@MCY1  OUT,
@MCY2  OUT,
@SA  OUT,
@ST  OUT,
@SX  OUT,
@SX1  OUT,
@SX2  OUT,
@SY  OUT,
@SY1  OUT,
@SY2  OUT,
@SC  OUT,
@SCX  OUT,
@SCX1  OUT,
@SCX2  OUT,
@SCY  OUT,
@SCY1  OUT,
@SCY2  OUT,
@JA  OUT,
@JT  OUT,
@JX  OUT,
@JX1  OUT,
@JX2  OUT,
@JY  OUT,
@JY1  OUT,
@JY2  OUT,
@JC  OUT,
@JCX  OUT,
@JCX1  OUT,
@JCX2  OUT,
@JCY  OUT,
@JCY1  OUT,
@JCY2  OUT,
@Sector out,
@Script out,
@Conjuction  OUT,
@Retro  OUT,
@PlanetSequence  OUT,
@Sequence30  OUT,
@StarPlanet  OUT
sELECT @d,@Y, @DL  ,
@MM  ,
@EX  ,
@TS  ,
@MS  ,
@SM  ,
@MA  ,
@MT  ,
@MX  ,
@MX1  ,
@MX2  ,
@MY  ,
@MY1  ,
@MY2  ,
@MC  ,
@MCX  ,
@MCX1  ,
@MCX2  ,
@MCY  ,
@MCY1  ,
@MCY2  ,
@SA  ,
@ST  ,
@SX  ,
@SX1  ,
@SX2  ,
@SY  ,
@SY1  ,
@SY2  ,
@SC  ,
@SCX  ,
@SCX1  ,
@SCX2  ,
@SCY  ,
@SCY1  ,
@SCY2  ,
@JA  ,
@JT  ,
@JX  ,
@JX1  ,
@JX2  ,
@JY  ,
@JY1  ,
@JY2  ,
@JC  ,
@JCX  ,
@JCX1  ,
@JCX2  ,
@JCY  ,
@JCY1  ,
@JCY2  ,
@Sector ,
@Script ,
@Conjuction  ,
@Retro  ,
@PlanetSequence  ,
@Sequence30  ,
@StarPlanet  
END
GO
*/
end

GO

