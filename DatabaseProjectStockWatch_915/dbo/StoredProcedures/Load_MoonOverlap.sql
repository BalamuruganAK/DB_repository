CREATE proc [dbo].[Load_MoonOverlap]
as
begin

	create table #date(PDate smalldatetime)
	create table #X (PDate smalldatetime, P varchar(20))
	create table #C (PDate smalldatetime, P varchar(20))
	create table #M (PDate smalldatetime, P varchar(20))
	create table #N (PDate smalldatetime, P varchar(20))
	
	insert into #date 
	Select distinct PDate from tbl_Planet p
	Where p.Planet = 4
	 and PDate not in (Select PDate from tbl_MoonOverlap)
		
	Insert into tbl_MoonOverlap (PDate) 
	Select PDate
	from #date

		Insert into #X
		Select outr.PDate,
			(case when DP % 1000000 >= 100000 then 'X' else '' end +	
			case when DP % 100000 >= 10000 then 'X1' else '' end + 
			case when DP % 10000 >= 1000 then 'X2' else '' end +
			case when DP % 1000 >= 100 then 'Y' else '' end +
			case when DP % 100 >= 10 then 'Y1' else '' end + 
			case when DP % 10 >= 1 then 'Y2' else '' end)
			as P 
		from 
			(Select iner.PDate,1000000+sum(iner.DP) as DP from
					(SELECT w.PDate,
						case 
							when w.XPlanet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < 7400
											then 100000
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < 7400
											then 100000
											end
									end
								else 0
						end+
						case 
							when w.X1Planet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < 7400
											then 10000
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < 7400
											then 10000
											end
									end
								else 0
						end+
						case 
							when w.X2Planet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < 7400
											then 1000
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < 7400
											then 1000
											end
									end
								else 0
						end+
						case 
							when w.YPlanet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < (7400*2)
											then 100
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < (7400*2)
											then 100
											end
									end
								else 0
						end+
						case 
							when w.Y1Planet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < (7400*2)
											then 10
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < (7400*2)
											then 10
											end
									end
								else 0
						end+
						case 
							when w.Y2Planet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < (7400*2)
											then 1
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < (7400*2)
											then 1
											end
									end
								else 0
						end as DP
					  FROM [tbl_Work] w
					  inner join tbl_Planet kp
					  on w.PDate = kp.PDate 
					  inner join tbl_Planet allp
					  on w.PDate = allp.PDate 
					  where W.KeyPlanet = 4
					  and kp.Planet = 4
					  and w.PDate in (Select PDate from #date)
					  and allp.Planet <> 4) as iner
			  group by iner.PDate) as outr
	
		Insert into #C
		Select PDate,
			(case when DP % 1000000 >= 100000 then 'CX' else '' end +	
			case when DP % 1000 >= 100 then 'CY' else '' end)
				as P
		from 
			(Select iner.PDate,1000000+sum(iner.DP) as DP from
					(SELECT w.PDate,
						case 
							when w.XPlanet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < 7400
											then 100000
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < 7400
											then 100000
											end
									end
								else 0
						end+
						case 
							when w.YPlanet = allp.Planet
							then case
									when kp.Degree%108000 > allp.Degree%108000 
									then case
											when (((allp.Degree%108000)+ 108000)
												- (kp.Degree%108000)) < (7400*2)
											then 100
											end
									else case
											when ((allp.Degree%108000)
												- (kp.Degree%108000)) < (7400*2)
											then 100
											end
									end
								else 0
						end as DP
					  FROM [tbl_Conjuction]  w
					  inner join tbl_Planet kp
					  on w.PDate = kp.PDate 
					  inner join tbl_Planet allp
					  on w.PDate = allp.PDate 
					  where W.KeyPlanet = 4
					  and kp.Planet = 4
					  and w.PDate in (Select PDate from #date)
					  and allp.Planet <> 4) as iner
			  group by iner.PDate) as outr1
			  
			  Insert into #M
			  Select PDate, 
				case when P = 1 then 'CM' else '' end as P
			  From(
				  Select iner1.PDate, SUM(iner1.CM) as P 
				  From (
					Select kp.PDate,
						case when (
						C.Degree - kp.Degree between -12000 and 12000
						or ( C.Degree - kp.Degree between -48000 and 48000 and C.Star = kp.Star )
						) then 
								case
										when kp.Degree%108000 > C.Degree%108000 
										then case
												when (((C.Degree%108000)+ 108000)
													- (kp.Degree%108000)) < (7400*2)
												then 1
												end
										else case
												when ((C.Degree%108000)
													- (kp.Degree%108000)) < (7400*2)
												then 1
												end
										end
						else 0 end CM
					from tbl_Planet kp
						inner join tbl_Planet C
						on C.PDate = kp.PDate
						and C.Planet <> kp.Planet
						and C.Planet not in (10,11,12)
						and kp.PDate in (Select PDate from #date)
					Where kp.Planet = 4) as iner1
				Group by iner1.PDate)  as outr
				
			Insert into #N
			  Select PDate, 
				case when P = 1 then 'NC' else '' end as P
			  From(
				 Select iner.PDate, SUM(iner.CM) as P 
				  From (
					Select kp.PDate,
						case when not (
						C.Degree - kp.Degree between -12000 and 12000
						or ( C.Degree - kp.Degree between -48000 and 48000 and C.Star = kp.Star )
						) 
						and (
						C.Degree - (kp.Degree + (7400*2)) between -12000 and 12000
						or ( C.Degree - (kp.Degree + (7400*2)) between -48000 and 48000 and C.Star = kp.Star )
						)
						then 
								1			
						else 0 end CM
					from tbl_Planet kp
						inner join tbl_Planet C
						on C.PDate = kp.PDate
						and C.Planet <> kp.Planet
						and C.Planet not in (10,11,12)
						and kp.PDate in (Select PDate from #date)
					Where kp.Planet = 4) as iner
				Group by iner.PDate ) as outr
				
		
		update tbl_MoonOverlap
		set XY = iner.XY,
			ConjXY = iner.ConjXY,
			ConjM = iner.ConjM,
			NewConj = iner.NewConj,
			MOLap = iner.MOLap			
		from 
			(Select #X.PDate as PDate, isnull(#X.P,'') as XY, 
				isnull(#C.P,'') as ConjXY, 
				isnull(#M.P,'') as ConjM,
				isnull(#N.P,'') as NewConj,
				isnull(#X.P,'') + isnull(#C.P,'')+ 
				isnull(#M.P,'')+ isnull(#N.P,'') as MOLap
			from #X 
			inner join #C 
			on #X.PDate = #C.PDate 
			inner join #M 
			on #X.PDate = #M.PDate 
			inner join #N 
			on #X.PDate = #N.PDate 
			where #X.PDate in (Select PDate from #date)) as iner
		inner join tbl_MoonOverlap mol
		on iner.PDate = mol.PDate
end

GO

