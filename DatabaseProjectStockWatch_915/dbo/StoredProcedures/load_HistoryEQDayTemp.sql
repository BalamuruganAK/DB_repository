
CREATE proc [dbo].[load_HistoryEQDayTemp]
as
begin
/*EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE
GO*/
	Declare @count int
	Declare @qry Nvarchar(500)
	Declare @path Nvarchar(100)
	Select @path = 'D:\Bala\Equity\Data\History\Day\"05-03-2019'
	--Select @path = 'E:\Bala\Equity\Data\History\Jun1we2018\"27-05-2018-TO-09-06-2018'

	  Insert into tbl_HistoryEQDayOldTemp
	  SELECT *
	  FROM tbl_HistoryEQDayTemp t
	  where not exists (Select 1 from tbl_HistoryEQDayOldTemp e 
		where e.Symbol = t.Symbol 
			and e.Date = t.Date)

	Truncate table tbl_HistoryEQDayTemp
	
		Select @qry = 
		'insert [dbo].[tbl_HistoryEQDayTemp]
		select 
		[Symbol]
		  ,[Date]
		  ,[Open]
		  ,[High]
		  ,[Low]
		  ,[Last Traded Price] 
		  ,[Traded Volume(lacs)] 
		  ,[Traded Value(crs)] 
		 from openrowset('+''''+'MSDASQL'+''''+
		','+''''+'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'+''''+
		','+''''+'select * from '+@path+'.CSV"'+''''+')'
		--Select @qry
		begin try
		--Select @qry
			Exec sp_executesql @qry
			Exec load_HistoryDayEQ
		end try
		begin catch 
			select ERROR_MESSAGE()
		end catch
	
	end

GO

