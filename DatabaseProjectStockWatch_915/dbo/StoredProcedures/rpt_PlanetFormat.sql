CREATE proc rpt_PlanetFormat
as
begin
SELECT  convert(date,[PDate],103)
    --  ,p.[Planet]
    --  ,[Degree]
      ,[FDegree]
   --   ,[Retro]
   --   ,[Star]
   --   ,[Sub]
	  ,pd.PlanetShortDesc + case when p.Retro = 1 then '(R)' else '' end  
	  + ' (' +pd1.PlanetShortDesc + ')'
	 -- + ' [' +pd2.PlanetShortDesc + ']' 
	  as 'P-star-sub'
	  ,(1+[Degree] / (60*60*30)) as 'House'
  FROM [StockWatch].[dbo].[tbl_Planet] p
  inner join tbl_PlanetDesc pd
  on pd.Planet = p.Planet 
  inner join tbl_PlanetDesc pd1
  on pd1.Planet = p.Star 
    inner join tbl_PlanetDesc pd2
  on pd2.Planet = p.Sub 
 -- inner join tbl_FinalTrent ft   on ft.PDate = p.PDate and ft.KeyPlanet = 4
  where [PDate] >= getdate() - 1
  and [PDate] <= getdate() + 10
  order by p.PDate, 'House',p.Degree
end

GO

