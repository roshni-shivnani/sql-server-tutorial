--ABS() - Absolute func - returns absl positive no.
--CEILING() - returns smallest integer greater than or eql to inppppuut parameter
--FLOOR() - returns largest integer smaller than or equal to inpu tparammeter
--SQUARE() - reurns square of a no.
--SQRT() - returns

SELECT RAND(1)  --RAND() -random func reutuns a random folat value betwee 0 and 1, provide input para. as 1 gives same value everytime
SELECT RAND()--same but gives diffrnt random value everytime

SELECT FLOOR(RAND()*100)--to get not a decimal vaue for random value but an integer : floor() and rand()

DECLARE @Counter int  --case hwen is used ne a t a time, for loop while i used & use SET with while 
SET @Counter=1
WHILE(@Counter<=100)
BEGIN
Print RAND()
SET @Counter=@Counter+1
END

SELECT ROUND(850.556,2)--ROUD Func returns a rounded value i.e. INCREASE A NO. & putsa azero after 2 demical places
SELECT ROUND(850.556,2,1)--Truncates anythingggg after two  decimal places
SELECT ROUND(850.556,1)--ROUND to 1 demical place after edecimal point
SELECT ROUND(850.556,-2)--Round the las ttwo places before (to the left) the decimal point

--Scalar UDFunctn
--CREATE FUNCTION() FunctonName(@Paraeter1 Datatype,@Parameter2 Datatype,@Parameter3 Datatype)
--RETURNS Return_Datatype
--AS
--BEGIN
--         codee like DECLARE
--			RETURN Return_Datatype
--END
--Age func as seennnn earlier

CREATE FUNCTION CalculateAge(@DOB Date)
RETURNS int
AS
BEGIN
DECLARE @Age int
---DECLARE @DOB int If jut want to use DECLARE not a func
 SET @Age = DATEDIFF(YEAR,@DOB,GETDATE())-
			  CASE 
			  WHEN
				(MONTH(@DOB)>MONTH(GETDATE())) OR
				(MONTH(@DOB)=MONTH(GETDATE()) AND DAY(@DOB)>DAY(GETDATE()))
				THEN 1 ELSE 0
				END
RETURN @Age
			  END

SELECT dbo.CalculateAge('01-01-1995')

SELECT Id,Name,dbo.CalculateAge(DateofBirth) FROM tblEmployees--Func canbe usedin selct clause

SELECT Id,Name,dbo.CalculateAge(DateofBirth) FROM tblEmployees --Func also where can be used in selct clause
WHERE dbo.CalculateAge(DateofBirth)>30

Sp_helptext dbo.CalculateAge --cn see func in stored proc
--stored proc can't b used in a selct clause this is iifce btween stored proc and func

CREATE PROCEDURE spCalculateAge @DOB Date  --always save stored proc named as spname....
AS
BEGIN
DECLARE @Age int
SET @Age=DATEDIFF(YEAR,@DOB,GETDATE())-
			CASE 
			WHEN
			(MONTH(@DOB)>MONTH(GETDATE())) OR
			(MONTH(@DOB)=MONTH(GETDATE()) AND DAY(@DOB)>DAY(GETDATE()))
			THEN 1 ELSE 0
			END
SELECT @Age
END

EXECUTE dbo.spCalculateAge '09-03-1915'

--Inline table valed functions
CREATE FUNCTION fn_EmployeesByGender(@Gender nvarchar(50)) --we don't needd BEGIN and END block in inline table valued func 
RETURNS TABLE
AS
RETURN (SELECT Name,Gender FROM tblEmployee
WHERE Gender=@Gender)

SELECT * FROM fn_EmployeesByGender('Female')

CREATE FUNCTION fn_EmployeesByGender1(@Gender nvarchar(50))
RETURNS TABLE
AS
RETURN (SELECT DepartmentName,Gender 
FROM tblEmployee E JOIN tblDepartment D 
ON E.DepartmentId=D.ID WHERE Gender=@GeTnder)

SELECT * FROM fn_EmployeesByGender1('Female')

--Invlin tabled valued fnc can t beused to achieve functionality of parametered views
--Invline tabled valued func cannn be used fr joins as seen above

CREATE FUNCTION fn_MSTVF_GetEmployees()
RETURNS @TABLE TABLE (ID int,Name nvarchar(50),DOB Date)
AS
BEGIN
	INSERT INTO @TABLE
	SELECT Id,Name,Cast(DateofBirth as Date) FROM tblEmployees
RETURN
END

SELECT * FROM fn_MSTVF_GetEmployees()

--Inline valued  func like a view
--Multi statement table valed func ike a stored proc

--UPDATE fn_EmployeesbyGender('Female') SET Name='Zam' WHERE ID=1 -- gives error invaid colmn name

--iltvf-secondopt





