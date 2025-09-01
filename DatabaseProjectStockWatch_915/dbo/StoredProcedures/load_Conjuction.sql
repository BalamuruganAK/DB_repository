CREATE proc [dbo].[load_Conjuction]
as
begin
	
	create table #datem(PDate smalldatetime)
	create table #dates(PDate smalldatetime)
	create table #datej(PDate smalldatetime)
	
	insert into #datem 
	Select distinct PDate from tbl_Work
		Where PDate not in (Select PDate from tbl_Conjuction Where KeyPlanet = 4)
		and KeyPlanet = 4

	insert into #dates 
	Select distinct PDate from tbl_Work
		Where PDate not in (Select PDate from tbl_Conjuction Where KeyPlanet = 3)
		and KeyPlanet = 3

	insert into #datej 
	Select distinct PDate from tbl_Work
		Where PDate not in (Select PDate from tbl_Conjuction Where KeyPlanet = 7)
		and KeyPlanet = 7
		
	Insert into tbl_Conjuction (PDate,KeyPlanet) 
	Select PDate, 4 as KeyPlanet from #datem

	Insert into tbl_Conjuction (PDate,KeyPlanet) 
	Select PDate, 3 as KeyPlanet from #dates

	Insert into tbl_Conjuction (PDate,KeyPlanet) 
	Select PDate, 7 as KeyPlanet from #datej
	
----Begin X Y 
	Update tbl_Conjuction
	set XPlanet = C.Planet,
	XPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.XPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)

	Update tbl_Conjuction
	set YPlanet = C.Planet,
	YPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.YPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)
----End X Y 


----Begin X1 Y1 
	Update tbl_Conjuction
	set X1Planet = C.Planet,
	X1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)

	Update tbl_Conjuction
	set Y1Planet = C.Planet,
	Y1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)
----End X1 Y1 


----Begin X2 Y2 
	Update tbl_Conjuction
	set X2Planet = C.Planet,
	X2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)

	Update tbl_Conjuction
	set Y2Planet = C.Planet,
	Y2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 4
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datem)
----End X2 Y2 
-- Moon End

--sun begin----Begin X Y 
	Update tbl_Conjuction
	set XPlanet = C.Planet,
	XPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.XPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)

	Update tbl_Conjuction
	set YPlanet = C.Planet,
	YPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.YPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)
----End X Y 


----Begin X1 Y1 
	Update tbl_Conjuction
	set X1Planet = C.Planet,
	X1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)

	Update tbl_Conjuction
	set Y1Planet = C.Planet,
	Y1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)
----End X1 Y1 


----Begin X2 Y2 
	Update tbl_Conjuction
	set X2Planet = C.Planet,
	X2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)

	Update tbl_Conjuction
	set Y2Planet = C.Planet,
	Y2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 3
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #dates)
----End X2 Y2 

--sun end
--Jupiter begin
----Begin X Y 
	Update tbl_Conjuction
	set XPlanet = C.Planet,
	XPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.XPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)

	Update tbl_Conjuction
	set YPlanet = C.Planet,
	YPosition = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.YPlanet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)
----End X Y 


----Begin X1 Y1 
	Update tbl_Conjuction
	set X1Planet = C.Planet,
	X1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)

	Update tbl_Conjuction
	set Y1Planet = C.Planet,
	Y1Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y1Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)
----End X1 Y1 


----Begin X2 Y2 
	Update tbl_Conjuction
	set X2Planet = C.Planet,
	X2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.X2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)

	Update tbl_Conjuction
	set Y2Planet = C.Planet,
	Y2Position = 
			case when kp.Degree >= C.Degree then
				((kp.Degree - C.Degree) / 108000) + 1
			else
				((1296000 + kp.Degree - C.Degree) / 108000) + 1
			end 
	From tbl_Conjuction J
	inner join tbl_Work w
	on w.PDate = J.PDate
	and w.KeyPlanet = J.KeyPlanet
	and J.KeyPlanet = 7
	inner join tbl_Planet P
	on P.PDate = w.PDate
	and P.Planet = w.Y2Planet
	inner join tbl_Planet kp
	on kp.PDate = w.PDate
	and kp.Planet = w.KeyPlanet
	inner join tbl_Planet C
	on C.PDate = P.PDate
	and C.Planet <> P.Planet
	and C.Planet not in (10,11,12)
	and (
	C.Degree - P.Degree between -12000 and 12000
	or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
	)
	Where w.PDate in (Select PDate from #datej)
----End X2 Y2 

--Jupiter end
end

GO

