--DATEDIFF
SELECT DATEDIFF(YEAR,'11-05-2022','02-05-2022')

CREATE FUNCTION fnComputeAge (@DOB date)
RETURNS nvarchar(50)
AS
BEGIN
DECLARE @tempdate datetime,@years int,@months int, @days int
												------SET @DOB='01-01-2009'
SELECT @tempdate=@DOB

SELECT @years=DATEDIFF(YEAR,@tempdate,GETDATE()) -
		CASE
		WHEN (MONTH(@DOB)>MONTH(GETDATE())) OR
			(MONTH(@DOB)=MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
		THEN 1 ELSE 0
		END
SELECT @tempdate=DATEADD(YEAR,@years,@tempdate)

SELECT @months=DATEDIFF(MONTH,@tempdate,GETDATE())-
		CASE 
		WHEN (DAY(@DOB)>DAY(GETDATE()))
		THEN 1 ELSE 0
		END
SELECT @tempdate=DATEADD(MONTH,@months,@tempdate)

SELECT @days=DATEDIFF(DAY,@tempdate,GETDATE())

	DECLARE @Age nvarchar(50)
	SET @Age=Cast(@years as nvarchar(4)) +'Years'+Cast(@months as nvarchar(3))+'Months'+Cast(@days as nvarchar(3))+'Days'
	RETURN @Age

--SELECT @years AS YEARS,@months AS MONTHS,@days AS [DAYS]
END

SELECT dbo.fnComputeAge('01-01-2009')

--Calculllating Age func in tblEmployeestable

SELECT Id,Name,dbo.fnComputeAge(DateofBirth) as Age FROM tblEmployees

SELECT Id,Name,DateofBirth,CAST(DateofBirth as nvarchar) FROM tblEmployees--CAST & CONVERT : CAST (expression as data_type [(length)]) 
SELECT Id,Name,DateofBirth,CONVERT(nvarchar,DateofBirth,103) FROM tblEmployees				--CONVERT(data_type [(length)],expression,style)			both r used to convert one data ype to another

SELECT CONVERT(nvarchar(10),GETDATE(),103)--to get just the datepart, from DateTime  method1

SELECT CAST(GETDATE() as DATE)--method2   esay
SELECT CONVERT(DATE,GETDATE())--method3

SELECT Id,Name,Name+'-'+Cast(Id as nvarchar(14)) as [Name-Id] FROM tblEmployees--tO DateTime convert to nvachar using the styles

--Practical e.g.
SELECT CAST(RegisteredDate AS DATE) AS RegisterationDate,COUNT(ID) AS TotalRegisterations 
FROM tblRegisteration 
GROUP BY CAST(RegisteredDate AS DATE)

--we need to cast date while group by

--DIf b/w cast and onvert: convert when using styeles ,cast is more ansi sql server based



