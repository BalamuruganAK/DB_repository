CREATE PROCEDURE [dbo].[Insert_testTable]
  @param1 int = 0,
  @param2 CHAR(10) NULL
AS
  insert into [dbo].[testTable] ([Id], [testname]) values (@param1, @param2)
RETURN 0
