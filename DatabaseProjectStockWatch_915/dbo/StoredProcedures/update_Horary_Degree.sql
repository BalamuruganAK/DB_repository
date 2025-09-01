CREATE proc [dbo].[update_Horary_Degree]
as
begin

	Select FromD, ToD, ((left(FromD,2)+ ((HouseNo -1) * 30)) * 3600) + ( (left(right(FromD,6),2) *60 )) + left(right(FromD,3),2),
	((left(ToD,2)+ ((HouseNo -1) * 30)) * 3600) + ( (left(right(ToD,6),2) * 60 )) + left(right(ToD,3),2)
	from tbl_Horary

	Update tbl_Horary set
	FD = ((left(FromD,2)+ ((HouseNo -1) * 30)) * 3600) + ( (left(right(FromD,6),2) *60 )) + left(right(FromD,3),2),
	TD = ((left(ToD,2)+ ((HouseNo -1) * 30)) * 3600) + ( (left(right(ToD,6),2) * 60 )) + left(right(ToD,3),2)
	
end

GO

