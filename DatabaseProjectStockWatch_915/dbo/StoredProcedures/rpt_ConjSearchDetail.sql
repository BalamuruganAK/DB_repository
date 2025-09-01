CREATE proc [dbo].[rpt_ConjSearchDetail]
(
@MX1 VARCHAR(6) ,
@MX2 VARCHAR(6) ,
@Symbol VARCHAR(50)
)
as
begin

-- exec [rpt_ConjSearchDetail] 'Moo','','ACC'

	Declare @X1 int 
	Declare @X2 int
	Declare @cnt int 
	
	Select @X1 = pd.Planet
	From tbl_PlanetDesc pd
	where pd.PlanetShortDesc = @MX1

	Select @X2 = pd.Planet
	From tbl_PlanetDesc pd
	where pd.PlanetShortDesc = @MX2
		
	create table #date(mPDate smalldatetime, cnt int, conj varchar(200))
	create table #dateRank(mPDate smalldatetime, cnt int, conj varchar(200))

		Insert into #date
		  Select x1.PDate, COUNT(1), '' from 
			tbl_Planet x1
			inner join tbl_Planet x2
			on x1.PDate = x2.PDate
			and (case when @MX1 <> '' then @x1 else x1.Planet end) = x1.Planet
			and (case when @MX2 <> '' then @x2 else x2.Planet end) = x2.Planet
		  Where X2.Degree - X1.Degree between 0 and 48000 
		  and X1.Star = X2.Star 
		  and x1.Planet <> x2.Planet
		  and x1.Planet < 10 and x2.Planet < 10
		  Group by x1.PDate
		
		Insert into #dateRank   
		   Select x1.PDate,
			RANK() over(partition by x1.PDate order by d1.PlanetShortDesc + ' ' + d2.PlanetShortDesc) as cnt,
			d1.PlanetShortDesc + '>' + d2.PlanetShortDesc as conj
			from 
			tbl_Planet x1
			inner join tbl_Planet x2
			on x1.PDate = x2.PDate
			and (case when @MX1 <> '' then @x1 else x1.Planet end) = x1.Planet
			and (case when @MX2 <> '' then @x2 else x2.Planet end) = x2.Planet
			inner join tbl_PlanetDesc d1
			on d1.Planet = x1.Planet 
			inner join tbl_PlanetDesc d2
			on d2.Planet = x2.Planet 
		  Where X2.Degree - X1.Degree between 0 and 48000 
		  and X1.Star = X2.Star 
		  and x1.Planet <> x2.Planet
		  and x1.Planet < 10 and x2.Planet < 10
		   
		  Select @cnt = MAX(cnt) from #date 
		  	  
		  While @cnt > 0
		  begin
		  	Update d
			set d.conj = d.conj + r.conj + ',' 
			from #date d
			inner join #dateRank r
			on d.mPDate = r.mPDate 
			--and d.cnt = r.cnt 
			and r.cnt = @cnt 
			
			Set @cnt = @cnt - 1
			
		  end
		  
		  -- exec [rpt_ConjSearchDetail] 'Moo','','ACC'
		  
		select 
			h.Symbol + CONVERT(varchar(2),cnt)+ ' ' + d.conj  as Symbol, --st.Planets + '-' + 
				pdx.PlanetShortDesc + 
			case when px.Retro = 1 then '(R)' else '' end + convert(varchar(2),tx.Position) + ' & ' +
			 pdy.PlanetShortDesc + 
			case when py.Retro = 1 then '(R)' else '' end + convert(varchar(2),ty.Position) as Planets,
			  convert(varchar(12),d.mPDate,102) as 'Date' ,h.OCP, h.PHP, h.PLP, h.PCP, h.POP
			
			from #date d
		  	  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.mPDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol 
				and OCP < 35 
				and h.Symbol = @Symbol	
			  inner join tbl_Work w
				on w.PDate = d.mPDate
				and w.KeyPlanet = 4
			  inner join tbl_PlanetDesc pdx
			    on pdx.Planet = w.XPlanet
			  inner join tbl_Trent tx
			    on tx.Position = w.XPosition
			  inner join tbl_Planet px
				on px.PDate = w.PDate
				and px.Planet = w.XPlanet 			  
			  inner join tbl_PlanetDesc pdy
			    on pdy.Planet = w.YPlanet
			  inner join tbl_Trent ty
			    on ty.Position = w.YPosition
			  inner join tbl_Planet py
				on py.PDate = w.PDate
				and py.Planet = w.YPlanet 		
			order by 3 desc
  
end

GO

