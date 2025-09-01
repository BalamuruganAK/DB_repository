CREATE proc [dbo].[load_XYTrent]
as
	begin
		truncate table tbl_XYTrent
				
		INSERT INTO tbl_XYTrent VALUES (1,3,1,0,'Fast-Up','////')
		INSERT INTO tbl_XYTrent VALUES (2,2,1,0,'Medium-Up','///')
		INSERT INTO tbl_XYTrent VALUES (3,1,1,0,'Slow-Up','//')
		INSERT INTO tbl_XYTrent VALUES (4,3,2,0,'Fast-Down','\\')--'\\\\'
		INSERT INTO tbl_XYTrent VALUES (5,2,2,0,'Medium-Down','\\\')
		INSERT INTO tbl_XYTrent VALUES (6,1,2,0,'Slow-Down','\\\\')--'\\'
		INSERT INTO tbl_XYTrent VALUES (7,3,3,0,'Fast-Side','>>>>')
		INSERT INTO tbl_XYTrent VALUES (8,2,3,0,'Medium-Side','>>>')
		INSERT INTO tbl_XYTrent VALUES (9,1,3,0,'Slow-Side','>>')
		INSERT INTO tbl_XYTrent VALUES (10,3,4,0,'Fast-Angle','^^^^')
		INSERT INTO tbl_XYTrent VALUES (11,2,4,0,'Medium-Angle','^^^')
		INSERT INTO tbl_XYTrent VALUES (12,1,4,0,'Slow-Angle','^^')
		INSERT INTO tbl_XYTrent VALUES (13,3,1,1,'Fast-Up','r///')
		INSERT INTO tbl_XYTrent VALUES (14,2,1,1,'Medium-Up','r//')
		INSERT INTO tbl_XYTrent VALUES (15,1,1,1,'Slow-Up','r/')
		INSERT INTO tbl_XYTrent VALUES (16,3,2,1,'Fast-Down','r\')--'r\\\'
		INSERT INTO tbl_XYTrent VALUES (17,2,2,1,'Medium-Down','r\\')
		INSERT INTO tbl_XYTrent VALUES (18,1,2,1,'Slow-Down','r\\\')--'r\'
		INSERT INTO tbl_XYTrent VALUES (19,3,3,1,'Fast-Side','r>>>')
		INSERT INTO tbl_XYTrent VALUES (20,2,3,1,'Medium-Side','r>>')
		INSERT INTO tbl_XYTrent VALUES (21,1,3,1,'Slow-Side','r>')
		INSERT INTO tbl_XYTrent VALUES (22,3,4,1,'Fast-Angle','r^^^')
		INSERT INTO tbl_XYTrent VALUES (23,2,4,1,'Medium-Angle','r^^')
		INSERT INTO tbl_XYTrent VALUES (24,1,4,1,'Slow-Angle','r^')

	end

GO

