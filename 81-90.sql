DBCC TraceOn(1222,-1)

DBCC TraceStatus(1222)

DBCC Traceoff(1222) 

CREATE PROC spTransaction1
AS
BEGIN
	UPDATE TableA SET Name='Mark Traansaction 1'
	WHERE Id=1
	Waitfor Delay '00:00:05'
	UPDATE TableB SET Name='Mary Traansaction 1'
	WHERE Id=1
	COMMIT TRANSACTION
END

Exec spTransaction1


BEGIN TRAN
UPDATE TableA SET Name='Mark Transaction 1'
WHERE Id=1

COMMIT


SELECT Id,Name,Gender FROM TableA
Except
SELECT Id,Name,Gender FROM TableB

SELECT Id,Name,Gender FROM TableA
WHERE NOT IN
(SELECT Id,Name,Gender FROM TableB) --GIVE RROR