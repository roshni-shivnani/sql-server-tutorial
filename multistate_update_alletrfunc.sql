Use [roshni]
Go

CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS Table
AS
RETURN 
(SELECT Id,Name,Cast(DateofBirth AS Date) as Date FROM tblEmployees)

SELECT * FROM fn_ILTVF_GetEmployees()

UPDATE fn_ILTVF_GetEmployees() SET Name='Sam1' WHERE Id=1


--CREATE FUNCTION fn_MSTVF_GetEmployees()
--RETURNS @Table TABLE (Id int,Name nvarchar(50),DOB Date)
--AS
--BEGIN
--	INSERT INTO @Table
--	SELECT Id,Name,Cast(DateofBirth AS Date) FROM tblEmployees
--	RETURN
--END															gives error there is already object named func already exist

SELECT * FROM fn_MSTVF_GetEmployees()

UPDATE fn_MSTVF_GetEmployees() SET Name='Sam 1' WHERE Id=1

--Deterministic func always return same value for spcific set of input andsamestatus of database e.g. SQRT(),Avg()
--Non Deterministic func always return difft value for spcific set of input even if status of daatabase issae e.g. GETDATE(),CURRENT_TIMESTAMP 

SELECT COUNT(*) FROM tblEmployees

SELECT SQUARE(3)

SELECT GETDATE()

CREATE FUNCTION fn_GetNameById(@Id int)
RETURNS nvarchar(50)
AS
BEGIN
RETURN (SELECT Name FROM tblEmployee WHERE ID=@Id)
END

SELECT ID,Name,dbo.fn_GetNameById(2) FROM tblEmployee

sp_helptext fn_GetNameById

ALTER FUNCTION fn_GetNameById(@Id int)--to get anyone don't see function text use WITH encryption in func
RETURNS nvarchar(50)
WITH ENCRYPTION
AS
BEGIN
RETURN (SELECT Name FROM tblEmployee WHERE ID=1)
END

sp_helptext fn_GetNameById

ALTER FUNCTION fn_GetNameById(@Id int)            --WITH SCHEMA BINDING  specify tsbale name as two part ie. dbo.tablename ie. with scehma binding pst schema binding, cannot drop that table
RETURNS nvarchar(50)
WITH SCHEMABINDING
AS
BEGIN
RETURN (SELECT Name FROM dbo.tblEmployee WHERE ID=1)
END

