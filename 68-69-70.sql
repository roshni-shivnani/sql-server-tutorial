--Altr dtabatabse withou dropping tbl
--example sal odf emp groupby gender
SELECT Gender,SUM(Salary) AS Total					--hre salary is of type nvarhar this giveerror data ypeivld for operators
FROM tblEmployee  GROUP BY Gender

ALTER TABLE tblEmployee	--here type to int                      -anow above qry we cn run
ALTER COLUMN Salary INT

--other option in Options prevent saving chng from table rrecreation   :tools-optios

CREATE PROC spSearchEmployees
@Name nvarchar(50),
@Email nvarchar(50),
@Gender nvarchar(25),
@Age int
AS
BEGIN
--SERAH EMP by name,email,ae,gender
	SELECT * FROM tblEmployee
	WHERE Name=@Name AND
	Gender=@Gender
	Email=@Email
	Age=@Age
END

ALTER PROC spSearchEmployees  --EXEC THIS PROC WITHOUT SUPLLLING PARAMETER TO EXEC EXMLPLE 3 best fr both conditn
@Name nvarchar(50)=NULL,
@Email nvarchar(50)=NULL,
@Gender nvarchar(25)=NULL,
@Age int=NULL
AS
BEGIN
--SERAH EMP by name,email,ae,gender
	SELECT * FROM tblEmployee
	WHERE Name=@Name @Name IS NULL AND
	Gender=@Gender @Gender IS NULL AND
	Email=@Email @Email IS NULL
	Age=@Age @Age IS NULL
END

Execute spSerachEmployees @Gender='Male'
Execute spSerachEmployees @Gender='Male', @Age=29 --male and of age 29


--Merge 
--source tb & trgt tbl rows not matched
--not match by target :rows present in source tbl not in trgt tbl
--not match by source  :rows present in target tbl not in src tbl

CREATE TABLE StudentSource
( 
	ID INT PRIMARY KEY,
	Name nvarcahr(27)
)
GO

INSERT INTO StudentSource VALUES(1,'Mike')
INSERT INTO StudentSource VALUES(1,'Sara')
GO

CREATE TABLE StudentTarget
( 
	ID INT PRIMARY KEY,
	Name nvarcahr(27)
)
GO

INSERT INTO StudentSource VALUES(1,'Mike')
INSERT INTO StudentSource VALUES(1,'Sara')
GO

MERGE INTO StudenttRAGET as T--agfter merge dta in target tbl woullld be same as src tbl
USING StudentSource AS S
ON T.ID=S.ID
WHEN MATCHED THEN
	UPDATE SET T.NAME=S.NAME
WHEN NOT MATCHED BY TARGET
	INSERT (ID,NAME) VALUES(S.ID,S.NAME)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;