CREATE proc [dbo].[rpt_EclipseDays]
as
begin

	Select convert(varchar(12),pe.PDate, 102) +
		case when pe.Planet = 1 then ' Ket ' else ' Rah ' end + 'Solar ' + 
		case when ps.Degree > pm.Degree then '1' else '2' end + ' ',
		ps.FDegree as 'sun', pm.FDegree as 'moon'
	From tbl_Planet pe 
		inner join tbl_Planet ps
		on pe.PDate = ps.PDate		
			and pe.Planet in (1, 6)
			and ps.Planet = 3
		inner join tbl_Planet pm
		on pe.PDate = pm.PDate
			and pm.Planet = 4
	Where abs(pe.Degree - ps.Degree) < 48000
		and abs(ps.Degree - pm.Degree) < 48000
	union 
		Select convert(varchar(12),pe.PDate, 102) +
		case when pe.Planet = 1 then ' Ket ' else ' Rah ' end + 'Lunar ' + 
		case 
			when ps.Degree > pm.Degree and ps.Degree - 648000 > pm.Degree then '1'
			when ps.Degree > pm.Degree and ps.Degree - 648000 < pm.Degree then '2'
			when ps.Degree < pm.Degree and ps.Degree + 648000 > pm.Degree then '1'
			when ps.Degree < pm.Degree and ps.Degree + 648000 < pm.Degree then '2'
		end + ' ',
		ps.FDegree as 'sun', pm.FDegree as 'moon'
	From tbl_Planet pe 
		inner join tbl_Planet ps
		on pe.PDate = ps.PDate		
			and pe.Planet in (1, 6)
			and ps.Planet = 3
		inner join tbl_Planet pm
		on pe.PDate = pm.PDate
			and pm.Planet = 4
	Where abs(pe.Degree - ps.Degree) < 48000
		and case when ps.Degree < pm.Degree then abs(ps.Degree + 648000 - pm.Degree) 
			when ps.Degree > pm.Degree then abs(ps.Degree - 648000  - pm.Degree) 
			end
		< 48000
		
end

GO

