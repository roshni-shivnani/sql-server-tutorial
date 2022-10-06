UPDATE tblDateTime SET c_datetimeoffset='2022-09-30 16:28:18.4666667 +10:00'  --in fractional seconds more precision +tim zone offset
WHERE c_datetimeoffset='2022-09-30 16:28:18.4666667 +00:00'

SELECT GETDATE(),'GETDATE()'  --DATE TIME SECONDS MILISECONDS
SELECT CURRENT_TIMESTAMP,'CURRENT_TIMESTAMP' --ANSI SQL eqivalent to GETDATE
SELECT SYSDATETIME(),'SYSDATETIME()'  --more fractional seconds precision #DATE TIME SECONDS MICROSECONDS#
SELECT SYSDATETIMEOFFSET(),'SYSDATETIMEOFFSET()' --more fractioal presiovon +Time zone format OUTPUT: 2022-10-03 13:29:51.1834298 +05:30
SELECT GETUTCDATE(),'GETDATETIME()' --NO INDIAN TIME BU REGULAR WORLD CLOcK TIME ~GMT
SELECT SYSUTCDATETIME(),'SYSUTCDATETIME()'

--ISDATE() - Checks if vairiable is date,time or date time. returns 1 dfor success, 0 for failurw For datetime2, it alwasy returns 0
SELECT ISDATE('PRAGIM') -- RETURNS 0
SELECT ISDATE(GETDATE()) --RETURNS 1
SELECT ISDATE('2022-10-03 15:16:16.145') --RETURNS 1
SELECT ISDATE('2022-10-03 15:16:16.1458887') --RETURNS 0

--DAY() returns day no. of the month          MONTH() retrns month no. of the year          YEAR() retuns year
SELECT DAY(GETDATE())
SELECT DAY('01-31-2022')  --hardcoded format mm--dd-yyyy

SELECT MONTH(GETDATE())
SELECT MONTH('01-31-2022')

SELECT YEAR(GETDATE())
SELECT YEAR('01-31-2022')

SELECT DATENAME(DAY,'09-30-2022 17:18:19.156')--DATENAME(Date part,ggiven date) retuns  string, that represnt part of a given date 
SELECT DATENAME(WEEKDAY,'09-30-2022 17:18:19.678')
SELECT DATENAME(MONTH,'09-30-2022 17:18:19.170')

CREATE TABLE tblEmployees
( Id int NOT NULL,
	Name nvarchar(50) NULL,
	DateofBirth datetime NULL
)

INSERT INTO tblEmployees VALUES (1,'Sam','1980-12-30 00:00:00.000')

INSERT INTO tblEmployees VALUES(2,'Pam','1982-09-01 12:02:36.260')

SELECT Name,DateofBirth,DATENAME(WEEKDAY,DateofBirth) as [Day],
Month(DateofBirth) as [Monthnumber],
DATENAME(MONTH,DateofBirth) as [Monthname],
Year(DateofBirth)
FROM tblEmployees

--DatePart(datepart,date) similar to DATENAME() alike it retuns an inetger whras DATENAME returns nvarchar
SELECT DatePart(WEEKDAY,'07-04-2021 16:17:22.134') --returns 1
SELECT DATENAME(WEEKDAY,'07-04-2021 16:17:22.134') --returns Sunday
--DateAdd(datepart,No. of days,date) returns the DateTime after adding the no. to NumberToAdd
SELECT DateAdd(MONTH,3,'06-07-2022 14:15:18.174')
--DateDiff(Datepart,StartDate,EndDate) returns the count OF DATEPART of difference between specified specified startdate and enddate
SELECT DATEDIFF(WEEKDAY,'06-07-1992 19:10:12.145','12-13-2020 14:10:14.167')
--e g. 2
SELECT DATEDIFF(DAY,'11-11-2020 03:08:14.159','11-11-2021 09:06:17.123')

CREATE FUNCTION fnComputeAge(@DOB datetime)
RETURNS nvarchar(50)
AS
BEGIN
DECLARE @DOB datetime,@tempdate datetime, @years int,@months int,@years int
SET @DOB='01-01-2012'