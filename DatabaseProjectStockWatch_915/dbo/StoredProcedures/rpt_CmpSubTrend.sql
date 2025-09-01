CREATE proc [dbo].[rpt_CmpSubTrend]
as
begin
		create table #date(mPDate smalldatetime, sPDate smalldatetime, jPDate smalldatetime)
		create table #sdate(fDate smalldatetime, tDate smalldatetime)
		create table #jdate(fDate smalldatetime, tDate smalldatetime)
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
				'' DL, 
				'' MO, 
				''  EX, 
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
		  Select w.PDate, null, null from 
			tbl_Work w
		  Where w.KeyPlanet = 4
		  
	
		  
/*		  select am.*,s.*,j.* from #Astro am
		  inner join #date d
		  on d.mPDate = am.PDate 
		  left outer join #Astro s
		  on s.PDate = d.sPDate
			and s.KP = 3
		  left outer join #Astro j
		  on j.PDate = d.jPDate
			and j.KP = 7
		 where am.KP = 4
		 order by am.PDate */

		select nif.*, m.KP, m.XPL, m.XD, m.XPo,
		am.KP, am.XPL, am.XD, am.XPo,
		aa.KP, aa.XPL, aa.XD, aa.XPo,
		ss.KP, ss.XPL, ss.XD, ss.XPo
		from tbl_DailyOHLC nif
		  inner join #Astro m
		  on Dateadd(mi,15,Dateadd(hh,9,nif.d))  = m.PDate
		   inner join #Astro am
		  on Dateadd(mi,15,Dateadd(hh,9,nif.d))  = am.PDate
		  inner join #Astro aa
		  on Dateadd(mi,15,Dateadd(hh,9,nif.d))  = aa.PDate
		  inner join #Astro ss
		  on Dateadd(mi,15,Dateadd(hh,9,nif.d))  = ss.PDate
		  inner join #date d		  
		  on d.mPDate = am.PDate 
		 where m.KP = 4 and am.KP = 40 and aa.KP = 120 and ss.KP = 30
		 order by am.PDate 
		 
		 select am.* 
		from #Astro am
		  inner join #date d
		  on d.mPDate = am.PDate 
		 where am.KP = 120
		 and am.PDate not in ( Select Dateadd(mi,15,Dateadd(hh,9,nif.d)) from tbl_DailyOHLC nif)
		 order by am.PDate 
	  
end

GO

