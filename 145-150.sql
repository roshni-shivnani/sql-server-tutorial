SELECT * FROM [USA Customers]

SELECT * FROM USA Customers


DECLARE @sql nvarchar(max)
DECLARE @tableName nvarchar(50)
SET @tablenAME = 'USA Customers] DROP DATABASE SalesDB'
SET @sql='SELECT * FROM[' +@tableName+']'
eXECUTE sp_executesql @sql 

DECLARE @sql nvarchar(max)
DECLARE @tableName nvarchar(50)
SET @tablenAME = 'USA Customers] DROP DATABASE SalesDB'
SET @sql='SELECT * FROM'+QUOTENAME(@tableName)
eXECUTE sp_executesql @sql 

DECLARE @sql nvarchar(max)
DECLARE @tableName nvarchar(50)
SET @tablenAME = 'USA Customers] DROP DATABASE SalesDB'
SET @sql='SELECT * FROM'+QUOTENAME('dbo')+'.' +QUOTENAME(@tableName)
eXECUTE sp_executesql @sql 

SLEECT QUOTENAME('USA Customers','*') ---give output null 

DECLARE @tableName nvarchar(50)
SET @tableName='USA ] Customers'
SET @tableName=QUOTENAME(@tableName)
Print @tableName

SET @tablename=PARSENAME(@tableName,1)  --to undo quoename
Print @tableName








DECLARE @sql nvarchar(max)
DECLARE @gender nvarchar(10)
SET @gender='Male'
SET @sql='SELECT COUNT(*) FROM Employees WHERE Gender=@gender'
Execute sp_executesql @sql, N'@gender narchar(10)',@gender

DECLARE @sql nvarchar(max)
DECLARE @gender nvarchar(10)
DECLARE @count int
SET @gender='Female'
SET @sql='SELECT COUNT(*) FROM Employees WHERE Gender=@gender'
Execute sp_executesql @sql, N'@gender narchar(10),@count int OUTPUT',@gender,@count int OUTPUT
SELECT @count

ALTER PROC spEmployeesCount 'Female',0
DECLARE @gender nvarchar(10)
DECLARE @count int OUTPUT
AS
BEGIN
DECLARE @sql nvarchar(max)
SET @sql='SELECT COUNT(*) FROM Employees WHERE Gender=@gender'
Execute sp_executesql @sql, N'@gender narchar(10),@count int OUTPUT',@gender,@count OUTPUT
SELECT @count
END


CREATE PROC spTemptableInDynamicSQL
AS
BEGIN
	DECLARE @sql nvarchar(max)
	SELECT @sql='CREATE TABLE #Test(Id int)
				INSERT INTO #Test VALUES(101)
				SELECT * FROM #Test'
	Execute sp_Executesql @sql
END

Execute spTemptableInDynamicSQL

ALTER PROC spTemptableInDynamicSQL
AS
BEGIN
	
	CREATE TABLE #Test(Id int)
				INSERT INTO #Test VALUES(101)
				SELECT * FROM #Test
	DECLARE @sql nvarchar(max)
	SELECT @sql='SELECT * FROM @sql'
	Execute sp_Executesql @sql
END
Execute spTemptableInDynamicSQL 