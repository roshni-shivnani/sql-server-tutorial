-CREATE PROC spTransaction2
AS
BEGIN
	UPDATE TablebB SET Name='Mark Traansaction 2'
	WHERE Id=1
	Waitfor Delay '00:00:05'
	UPDATE TableA SET Name='Mary Traansaction 2'
	WHERE Id=1
	COMMIT TRANSACTION
END


Exec spTransaction1  --logging deadlock :Window 2 logging stored proc i.e. 1st txn is exec then 2nd but 1st should un 2nd should gve error

SELECT COUNT(*) FROM TableA

DELETE FROM TableA WHERE Id=1

TRUNCATE TABLE TableA

DROP TABLE TableA

DBCC OpenTran

KILL 54