SELECT SUBSTRING('pam@bbb.com',CHARINDEX('@','pam@bbb.com')+1,7) --to output bbb.com

SELECT SUBSTRING('pam@bbb.com',CHARINDEX('@','pam@bbb.com')+1,--to same output but track length of bbb.com & deducting full stringg length : uses charindex,substring  len
LEN('pam@bbb.com')-CHARINDEX('@','pam@pam@bbb.com')
)

SELECT SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)-CHARINDEX('@',Email)) FROM tblPerson AS EmailDomain--to output bbb.com in employee tabe

SELECT SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)-CHARINDEX('@',Email)),--tooutput gorup of similar emails count
COUNT(Email) as Total
FROM tblPerson
Group By SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)-CHARINDEX('@',Email))

SELECT SUBSTRING(Email,1,2)+REPLICATE('*',5)--mask the 5 star email LIKE ja@*****.com    REPLICATE(sTRING,no . of times string to be repated)
+SUBSTRING(Email,CHARINDEX('@',Email),LEN(Email)-CHARINDEX('@',Email)+1)
FROM tblPerson

SELECT Name+SPACE(5)+Gender FROM tblEmployee

Use [roshni]
Go

SELECT Name,Email,PATINDEX('%@a.com',Email) as FirstOccurence --returns starting positio of first occurence of a pattern in a experssion . It takes two arguments , 1)PATTERN 2)experession  
FROM tblPerson

SELECT Name,Email,PATINDEX('%@a.com',Email) as FirstOccurence--the smae output but to look good ie.e excluding zero, other than @aaa.com no email should be printed only @aaa.com  
FROM tblPerson
WHERE PATINDEX('%@a.com',Email)>0

--PATINDEX is similar to CHARINDEX, but CHARINDEXX cannot use wildcards,PATINDEX can
--If not pattern is found,PATINDEX returns ZERO

SELECT Email,REPLACE(Email,'.com','.net') as Convertedvalue--REPLACE(String_expression,Pattern,Replacement_value)replaces a string with another string
FROM tblPerson

SELECT Email,STUFF(Email,2,3,'*****') as Stuffvalue--Stuff Function(Original_expression,Start,Length,Replacement_Expression) - places replacement_expression at a start specified position removes the characters sepcified using Length paramenter   
FROM tblPerson  -- similar to REPLICATE

--DateTime Func
--cREATED a table tblDateTieme in diffrenet format like only date, only time, dateandtime,etc.
INSERT INTO tblDatetime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE()) --GETDATE() 

UPDATE tblDateTime SET c_datetimeoffset='2022-09-30 13:49:56.920000 +01:00'
WHERE c_datetimeoffset='2022-09-30 13:49:56.9200000 +00:00'
