CREATE proc [dbo].[Load_Element]
as
begin

	Insert into tbl_Element (PDate)
	SELECT distinct PDate         		      
	FROM tbl_Planet P
	Where PDate
		not in (Select E.PDate from tbl_Element E Where E.PDate = P.PDate)
	
	Update tbl_Element set MCE = 0, SCE = 0, JCE = 0, TCE = 0
	
	Update tbl_Element set MKE = ((P.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 4 
				
	Update tbl_Element set SKE = ((P.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 3 

	Update tbl_Element set JKE = ((P.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 7 

	Update tbl_Element set TKE = ((P.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 8 
	
	
	Update tbl_Element set MSE = ((S.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 4 
		inner  join tbl_Planet S on S.PDate = P.PDate and S.Planet = P.Star

	Update tbl_Element set SSE = ((S.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 3 
		inner  join tbl_Planet S on S.PDate = P.PDate and S.Planet = P.Star
	
	Update tbl_Element set JSE = ((S.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 7 
		inner  join tbl_Planet S on S.PDate = P.PDate and S.Planet = P.Star
		
	Update tbl_Element set TSE = ((S.Degree / 108000) % 4) + 1
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 8 
		inner  join tbl_Planet S on S.PDate = P.PDate and S.Planet = P.Star
	
	Update tbl_Element set MCE = case 
		when (C.Planet in (3,5)and C.Retro = 0) or (C.Planet in (4,8) and C.Retro = 1) then 1
		when (C.Planet in (2  )and C.Retro = 0) or (C.Planet in (7,9) and C.Retro = 1) then 2
		when (C.Planet in (7,9)and C.Retro = 0) or (C.Planet in (2  ) and C.Retro = 1) then 3
		when (C.Planet in (4,8)and C.Retro = 0) or (C.Planet in (3,5) and C.Retro = 1) then 4
		when C.Planet in (1) then 5 
		when C.Planet in (6) then 6
		else 0 end
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 4 
		inner  join tbl_Planet C on C.PDate = P.PDate  and C.Planet <> P.Planet
		and ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
		and ABS(C.Degree - P.Degree) = 
			(Select MIN(ABS(C1.Degree - P1.Degree)) from tbl_Planet C1 
			inner join tbl_Planet P1 on C1.PDate = P1.PDate and P1.Planet = P.Planet
			where C1.PDate = C.PDate and C1.Planet <> P.Planet)

	Update tbl_Element set SCE = case 
		when (C.Planet in (3,5)and C.Retro = 0) or (C.Planet in (4,8) and C.Retro = 1) then 1
		when (C.Planet in (2  )and C.Retro = 0) or (C.Planet in (7,9) and C.Retro = 1) then 2
		when (C.Planet in (7,9)and C.Retro = 0) or (C.Planet in (2  ) and C.Retro = 1) then 3
		when (C.Planet in (4,8)and C.Retro = 0) or (C.Planet in (3,5) and C.Retro = 1) then 4
		when C.Planet in (1) then 5 
		when C.Planet in (6) then 6 
		else 0 end
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 3 
		inner  join tbl_Planet C on C.PDate = P.PDate  and C.Planet <> P.Planet
		and ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
		and ABS(C.Degree - P.Degree) = 
			(Select MIN(ABS(C1.Degree - P1.Degree)) from tbl_Planet C1 
			inner join tbl_Planet P1 on C1.PDate = P1.PDate and P1.Planet = P.Planet
			where C1.PDate = C.PDate and C1.Planet <> P.Planet)

	Update tbl_Element set JCE = case 
		when (C.Planet in (3,5)and C.Retro = 0) or (C.Planet in (4,8) and C.Retro = 1) then 1
		when (C.Planet in (2  )and C.Retro = 0) or (C.Planet in (7,9) and C.Retro = 1) then 2
		when (C.Planet in (7,9)and C.Retro = 0) or (C.Planet in (2  ) and C.Retro = 1) then 3
		when (C.Planet in (4,8)and C.Retro = 0) or (C.Planet in (3,5) and C.Retro = 1) then 4
		when C.Planet in (1) then 5 
		when C.Planet in (6) then 6 
		else 0 end
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 7 
		inner  join tbl_Planet C on C.PDate = P.PDate  and C.Planet <> P.Planet
		and ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
		and ABS(C.Degree - P.Degree) = 
			(Select MIN(ABS(C1.Degree - P1.Degree)) from tbl_Planet C1 
			inner join tbl_Planet P1 on C1.PDate = P1.PDate and P1.Planet = P.Planet
			where C1.PDate = C.PDate and C1.Planet <> P.Planet)

	Update tbl_Element set TCE = case 
		when (C.Planet in (3,5)and C.Retro = 0) or (C.Planet in (4,8) and C.Retro = 1) then 1
		when (C.Planet in (2  )and C.Retro = 0) or (C.Planet in (7,9) and C.Retro = 1) then 2
		when (C.Planet in (7,9)and C.Retro = 0) or (C.Planet in (2  ) and C.Retro = 1) then 3
		when (C.Planet in (4,8)and C.Retro = 0) or (C.Planet in (3,5) and C.Retro = 1) then 4
		when C.Planet in (1) then 5 
		when C.Planet in (6) then 6 
		else 0 end
	From tbl_Planet P inner  join tbl_Element E on P.PDate = E.PDate and P.Planet = 8 
		inner  join tbl_Planet C on C.PDate = P.PDate  and C.Planet <> P.Planet
		and ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
		and ABS(C.Degree - P.Degree) = 
			(Select MIN(ABS(C1.Degree - P1.Degree)) from tbl_Planet C1 
			inner join tbl_Planet P1 on C1.PDate = P1.PDate and P1.Planet = P.Planet
			where C1.PDate = C.PDate and C1.Planet <> P.Planet)
			
	Update tbl_Element set 
		KSumD = CONVERT(varchar(1),MKE) + CONVERT(varchar(1),SKE) +CONVERT(varchar(1),JKE) +CONVERT(varchar(1),TKE) 
		,SSumD = CONVERT(varchar(1),MSE) + CONVERT(varchar(1),SSE) +CONVERT(varchar(1),JSE) +CONVERT(varchar(1),TSE) 
		,CSumD = CONVERT(varchar(1),MCE) + CONVERT(varchar(1),SCE) +CONVERT(varchar(1),JCE) +CONVERT(varchar(1),TCE) 
		,KSum = CONVERT(varchar(1),(MKE%2)+1) + CONVERT(varchar(1),(SKE%2)+1) +CONVERT(varchar(1),(JKE%2)+1) +CONVERT(varchar(1),(TKE%2)+1) 
		,SSum = CONVERT(varchar(1),(MSE%2)+1) + CONVERT(varchar(1),(SSE%2)+1) +CONVERT(varchar(1),(JSE%2)+1) +CONVERT(varchar(1),(TSE%2)+1) 
		,CSum = CONVERT(varchar(1),case when MCE in(2,4) then 1 when MCE in(1,3) then 2 else MCE end) 
			+ CONVERT(varchar(1),case when SCE in(2,4) then 1 when SCE in(1,3) then 2 else SCE end) 
			+CONVERT(varchar(1),case when JCE in(2,4) then 1 when JCE in(1,3) then 2 else JCE end) 
			+CONVERT(varchar(1),case when TCE in(2,4) then 1 when TCE in(1,3) then 2 else TCE end) 
	
	Update tbl_Element set 
		SumOr = case when SUBSTRING(CSum,1,1) not in ('0','5') 
					and SUBSTRING(CSum,1,1) = SUBSTRING(SSum,1,1) 
					and SUBSTRING(CSum,1,1) = SUBSTRING(KSum,1,1) then SUBSTRING(KSum,1,1)
				 when SUBSTRING(CSum,1,1) = SUBSTRING(KSum,1,1) then SUBSTRING(KSum,1,1) 
				 else '3' end +
			case when SUBSTRING(CSum,2,1) not in ('0','5') 
					and SUBSTRING(CSum,2,1) = SUBSTRING(SSum,2,1) 
					and SUBSTRING(CSum,2,1) = SUBSTRING(KSum,2,1) then SUBSTRING(KSum,2,1)
				 when SUBSTRING(CSum,2,1) = SUBSTRING(KSum,2,1) then SUBSTRING(KSum,2,1) 
				 else '3' end +
			case when SUBSTRING(CSum,3,1) not in ('0','5') 
					and SUBSTRING(CSum,3,1) = SUBSTRING(SSum,3,1) 
					and SUBSTRING(CSum,3,1) = SUBSTRING(KSum,3,1) then SUBSTRING(KSum,3,1)
				 when SUBSTRING(CSum,3,1) = SUBSTRING(KSum,3,1) then SUBSTRING(KSum,3,1) 
				 else '3' end +
			case when SUBSTRING(CSum,4,1) not in ('0','5') 
					and SUBSTRING(CSum,4,1) = SUBSTRING(SSum,4,1) 
					and SUBSTRING(CSum,4,1) = SUBSTRING(KSum,4,1) then SUBSTRING(KSum,4,1)
				 when SUBSTRING(CSum,4,1) = SUBSTRING(KSum,4,1) then SUBSTRING(KSum,4,1) 
				 else '3' end,
		CSOr = case when SUBSTRING(CSum,1,1) not in ('0') 
					then SUBSTRING(CSum,1,1) else SUBSTRING(SSum,1,1) end +
			case when SUBSTRING(CSum,2,1) not in ('0') 
					then SUBSTRING(CSum,2,1) else SUBSTRING(SSum,2,1) end +
			case when SUBSTRING(CSum,3,1) not in ('0') 
					then SUBSTRING(CSum,3,1) else SUBSTRING(SSum,3,1) end +
			case when SUBSTRING(CSum,4,1) not in ('0') 
					then SUBSTRING(CSum,4,1) else SUBSTRING(SSum,4,1) end,
		CKOr = case when SUBSTRING(CSum,1,1) not in ('0') 
					then SUBSTRING(CSum,1,1) else SUBSTRING(KSum,1,1) end +
			case when SUBSTRING(CSum,2,1) not in ('0') 
					then SUBSTRING(CSum,2,1) else SUBSTRING(KSum,2,1) end +
			case when SUBSTRING(CSum,3,1) not in ('0') 
					then SUBSTRING(CSum,3,1) else SUBSTRING(KSum,3,1) end +
			case when SUBSTRING(CSum,4,1) not in ('0') 
					then SUBSTRING(CSum,4,1) else SUBSTRING(KSum,4,1) end,
		CSKOr = case when SUBSTRING(CSumD,1,1) not in ('0') 
					then SUBSTRING(CSumD,1,1) else SUBSTRING(SSumD,1,1) end +
			case when SUBSTRING(CSumD,2,1) not in ('0') 
					then SUBSTRING(CSumD,2,1) else SUBSTRING(SSumD,2,1) end +
			case when SUBSTRING(CSumD,3,1) not in ('0') 
					then SUBSTRING(CSumD,3,1) else SUBSTRING(SSumD,3,1) end +
			case when SUBSTRING(CSumD,4,1) not in ('0') 
					then SUBSTRING(CSumD,4,1) else SUBSTRING(SSumD,4,1) end
				 
	
end

GO

