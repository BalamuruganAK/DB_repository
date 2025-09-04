create proc load_Trent
as
	begin
		INSERT INTO tbl_Trent VALUES (1 ,1 ,'Up','U')
		INSERT INTO tbl_Trent VALUES (3 ,1 ,'Up','U')
		INSERT INTO tbl_Trent VALUES (6 ,1 ,'Up','U')
		INSERT INTO tbl_Trent VALUES (10 ,1 ,'Up','U')
		INSERT INTO tbl_Trent VALUES (11 ,1 ,'Up','U')
		INSERT INTO tbl_Trent VALUES (5 ,2 ,'Down','D')
		INSERT INTO tbl_Trent VALUES (8 ,2 ,'Down','D')
		INSERT INTO tbl_Trent VALUES (12 ,2 ,'Down','D')
		INSERT INTO tbl_Trent VALUES (4 ,3 ,'Side','S')
		INSERT INTO tbl_Trent VALUES (7 ,3 ,'Side','S')
		INSERT INTO tbl_Trent VALUES (2 ,4 ,'Angle','A')
		INSERT INTO tbl_Trent VALUES (9 ,4 ,'Angle','A')
	end

GO

