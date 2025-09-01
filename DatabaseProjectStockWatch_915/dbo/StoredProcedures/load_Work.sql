CREATE proc [dbo].[load_Work]
as
begin
	
	Exec load_work_Moon
	Exec load_work_Sun
	Exec load_work_Jupiter
	Exec load_Work_SunSub
	Exec Load_MoonOverlap

end

GO

