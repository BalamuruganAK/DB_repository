CREATE proc [dbo].[load_Volume]
as
	begin
		truncate table tbl_Volume
		
		INSERT INTO tbl_Volume VALUES (1 ,0 , 2, 'Medium')
		INSERT INTO tbl_Volume VALUES (2 ,0 , 2, 'Medium')
		INSERT INTO tbl_Volume VALUES (3 ,0 , 2, 'Medium')
		INSERT INTO tbl_Volume VALUES (4 ,0 , 2, 'Medium')
		INSERT INTO tbl_Volume VALUES (9 ,0 , 2, 'Medium')
		INSERT INTO tbl_Volume VALUES (5 ,0 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (8 ,0 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (6 ,0 , 3, 'Fast')
		INSERT INTO tbl_Volume VALUES (7 ,0 , 3, 'Fast')
		
		INSERT INTO tbl_Volume VALUES (1 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (2 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (3 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (4 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (9 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (5 ,1 , 0, 'VerySlow')
		INSERT INTO tbl_Volume VALUES (8 ,1 , 0, 'VerySlow')
		INSERT INTO tbl_Volume VALUES (6 ,1 , 1, 'Slow')
		INSERT INTO tbl_Volume VALUES (7 ,1 , 1, 'Slow')
	end

GO

