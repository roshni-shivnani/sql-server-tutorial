--Daily first use & go partic. database 

--Example on where return canot be used but output parameter can be used
CREATE PROCEDURE spNameIdById1 --output para
@Id int,
@Name nvarchar(50) OUT
AS
	BEGIN
	SELECT @NAME=Name FROM tblEmployee WHERE Id=@Id
END

DECLARE @EmployeeName nvarchar(50)
Exec spNameIdById1 5,@EmployeeName OUT
Print @EmployeeName

Use [roshni]
Go

CREATE PROCEDURE spNameById1
@Id int,
@Name nvarchar(50) OUT
AS
	BEGIN
	SELECT @Name=Name FROM tblEmployee WHERE Id=@Id
END

DECLARE @EmployeeName nvarchar(50)
Exec spNameById1 6,@EmployeeName OUT
Print 'Name =@EmployeeName'

CREATE PROC spNameById2 --return value    ..gives error cannoteturn name only can return int also cannot reutn gender,age,pincode
@Id int
AS
	BEGIN
	return (SELECT Name FROM tblEmployee WHERE Id=@Id)
END

DECLARE @EmployeeName nvarchar(50)
Exec @EmployeeName=spNameById2 3
Print 'Nameof the Employee = @EmployeeName'

--Adv of Stored Proc : Secuity :Final grey Control - Grant Permissions e,g, only IT people want emp data resulted data providezz grant on that

SELECT ASCII('A')--String funcs

SELECT CHAR(65)

DECLARE @Start int
SET @Start=65
WHILE(@Start<=90)
	BEGIN
	Print CHAR(@Start)
	SET @Start=@Start+1
END

SELECT TRIM('    Hello')
SELECT LTRIM(Name) as Name,Gender,Salary,Name+Gender FROM tblEmployee  --left trim & concat stings    we cannot concat char column and int column it has to be another  har column

SELECT UPPER(Name),LOWER(Gender),RTRIM(LTRIM(Name))+' '+Gender as Concatdata FROM tblEmployee

SELECT Name,LEN(LTRIM(Name)) as [Total Characters] FROM tblEmployee

SELECT CHARINDEX('@','sara@a.com')

SELECT SUBSTRING('sara@aaa.com',6,7)

SELECT SUBSTRING('pam@bbb.com',CHARINDEX('@','pam@bbb.com'),7)