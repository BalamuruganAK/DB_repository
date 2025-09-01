
CREATE proc [dbo].[load_HistoryEQTemp]
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
	Declare @Stock Nvarchar(50)
	Set @count = 1
	Select @path = 'D:\Bala\Equity\Data\History\Mar1we2019\"10-06-2018-TO-04-03-2019'
	--Select @path = 'E:\Bala\Equity\Data\History\Jun1we2018\"27-05-2018-TO-09-06-2018'

	  Insert into tbl_HistoryEQOldTemp
	  SELECT *
	  FROM tbl_HistoryEQTemp t
	  where not exists (Select 1 from tbl_HistoryEQOldTemp e 
		where e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = t.Date)

	  Insert into tbl_HistoryIXOldTemp
	  SELECT *
	  FROM tbl_HistoryIXTemp t
	  where not exists (Select 1 from tbl_HistoryIXOldTemp e 
		where e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = t.Date)
			
	Truncate table tbl_HistoryEQTemp
	Truncate table tbl_HistoryIXTemp
	
	While @count <= 57
	begin
		Select @Stock = s.Stock from tbl_Stock s where s.StockID = @count
		Select @qry = 
		'insert [dbo].[tbl_HistoryEQTemp]
		select 
		[Symbol]
		  ,[Series]
		  ,[Date]
		  ,[Prev Close] 
		  ,[Open Price] 
		  ,[High Price] 
		  ,[Low Price] 
		  ,[Last Price] 
		  ,[Close Price] 
		  ,[Average Price] 
		  ,[Total Traded Quantity] 
		  ,[Turnover]
		  ,[No# of Trades] 
		 from openrowset('+''''+'MSDASQL'+''''+
		','+''''+'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'+''''+
		','+''''+'select * from '+@path+@Stock+'EQN.CSV"'+''''+')'
		--Select @qry
		begin try
		--Select @qry
			Exec sp_executesql @qry
		end try
		begin catch 
			select @Stock + '  ' + ERROR_MESSAGE()
		end catch
		
		Select @count = case when @count in( 26, 51)
						then @count + 3
						else @count + 1
						end
	end
	
	
		Select @Stock = s.Stock from tbl_Stock s where s.StockID = 52
		Select @qry = 
		'insert [dbo].[tbl_HistoryIXTemp]
		select ' +''''+ @Stock +''''+' as Symbol,'+''''+'IX'+''''+' as Series, * from openrowset('+''''+'MSDASQL'+''''+
		','+''''+'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'+''''+
		','+''''+'select * from '+@path+@Stock+'.CSV"'+''''+')'
		begin try
			Exec sp_executesql @qry
		end try
		begin catch 
			select @Stock + '  ' + ERROR_MESSAGE()
		end catch
	
		Select @Stock = s.Stock from tbl_Stock s where s.StockID = 53
		Select @qry = 
		'insert [dbo].[tbl_HistoryIXTemp]
		select ' +''''+ @Stock +''''+' as Symbol,'+''''+'IX'+''''+' as Series, 
		[Date]
			  ,[Open]
			  ,[High]
			  ,[Low]
			  ,[Close]
			  ,replace([Shares Traded],'+''''+'-'+''''+',0) 
			  ,replace([Turnover (Rs# Cr)],'+''''+'-'+''''+',0) 
		 from openrowset('+''''+'MSDASQL'+''''+
		','+''''+'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'+''''+
		','+''''+'select *
			  from '+@path+@Stock+'.CSV"'+''''+')'
		begin try
			Exec sp_executesql @qry
		end try
		begin catch 
			select @Stock + '  ' + ERROR_MESSAGE()
		end catch

end

GO

