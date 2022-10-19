SELECT Id,Name,Gender FROM TableA
UNION ALL
SELECT Id,Name,Gender FROM TableB

SELECT Id,Name,Gender FROM TableA
INTERSECT
SELECT Id,Name,Gender FROM TableB

CREATE TRIGGER trMyFirstTrigger
ON roshni
FOR CREATE_TABLE
AS
BEGIN
	Print 'New table created'
END

CREATE TABLE TEST(Id int)


ALTER TRIGGER trMyFirstTrigger
ON roshni
FOR CREATE_TABLE, ALTER_TABLE,DROP_TABLE
AS
BEGIN
	Rollback
	Print 'You cannot create, ALTER OR DROP A TABLE'
END

CREATE TABLE TEST(Id int)
DROP TABLE Test

CREATE TABLE Test(Id int)

DROP TABLE Test

Exec sp_settriggerorder
@triggername='tr_DatabaseScopeTrigger1',
@order='first'
@stmttype = 'CREATE_TABLE'
@namespace = 'DATABASE'
GO

Exec sp_settriggerorder
@triggername='tr_DatabaseScopeTrigger3',
@order='last'
@stmttype = 'CREATE_TABLE'
@namespace = 'DATABASE'
GO


CREATE TRIGGER tr_AuditLogin
ON ALL SERVER
FOR LOGON
AS
BEGIN
	DECLARE @LoginName nvarchar(100)
	SET @LoginName = Original_Login()

	SELECT COUNT(*) FROM sys.dm_exec sessions
	WHERE is_user_process=1 AND
	original_login_name = @LoginName
END

SELECT Product,SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE Product IN ('iPhone','Speakers')
GROUP BY Product

SELECT Product,SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product
HAVING Product IN ('iPhone','Speakers')