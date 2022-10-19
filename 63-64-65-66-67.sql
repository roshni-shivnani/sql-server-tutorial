--Replacing cursor using jjoin 
UPDATE tblProductSales						--same qry as above				-better perform - less thn a second usssse join
SET UnitPrice = CASE
					WHEN Name='Product-55' THEN 55
					WHEN Name='Product-65' THEN 65
					WHEN Name LIKE 'Product-100%' THEN 1000
				END
FROM tblProductSales
JOIN tblProducts
ON tblProducts.Id=tblProductSales.ProductId
WHERE Name= 'Product-55' OR Name='Product-65' OR Name LIKE 'Product-100%'      --Without WHERE CLAUSE take more time and without WHERE CLASE, all nonm-macthig rows unit price will bbbbbbe nnull

SELECT Name,UnitPrice					--calling the result
FROM tblProducts 
JOIN tblProductSales
ON tblProducts.Id=tblProductSales.ProductId
WHERE Name= 'Product-55' OR Name='Product-65' OR Name LIKE 'Product-100%'      --Without WHERE CLAUSE take more time


--lIST ALL atbles in a datbase
--SYSObjects 200,2005 & 2008,SYS.TABLES 2005 and 2008, INFORMATION_SCHEMA.TABLES
SELECT * FROM SYSOBJECTS WHERE xtype='TL' ,,--FN for func,V for view

SELECT DISTINCT xtype FROM SYSOBJECTS   -- ALL TYES OF CTYPES AVVL

SELECT * FROM SYS.TABLES  --SYS.FUNCTIONS,SYS.PROCEDURES

SELECT * FROM INFORMATION_SCHEMA.TABLES  : views


--Re-Ruunable script
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='tblEmployee')
BEGIN
	CREATE TABLE tblEmployee
	(
		ID int IDENTITY PRIMARY KEY,
		Name nvarchar(100),
		Gender nvarchar(10),
		DayeOfBirth DateTime
	)
	--WE CN ALSOPRINT A MSG  HERE
END
ELSE
BEGIN
	Print 'Table tblEmployee already exists'
END

IF(Object_ID('tblEmployee')) IS NULL--eXAMPLE 2 OBJECT_ID
BEGIN
	--Create Table Script
	Print 'Table tblEmployee Created'
END
ELSE
BEGIN
	Print 'Table tblEmloyees already exists'
END

--drop TBLE AND re-create
IF OBJECT_ID('tblEmployee') IS NOT NULL  --if we object_id comment for then  
BEGIN
	DROP TABLE tblEmployee
END
CREATE TABLE tblEmployee
	(
		ID int IDENTITY PRIMARY KEY,
		Name nvarchar(100),
		Gender nvarchar(10),
		DayeOfBirth DateTime
	)
	--WE CN ALSOPRINT A MSG  HERE

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='EmailAddress'     --Ad ayjord colmn emailaddr in tblemployee if colmn not exist prior
				AND TABLE_NAME='tblEmployee' AND TABLE_SCHEMA='dbo')
BEGIN
	ALTER TABLE tblEmployee
	ADD EmailAddress nvarchar(50)
END
ELSE
BEGIN
	Print 'Column EmailAddress already exsists'
END

--Col_length()
IF Col_length('tblEmployee','EmailAddress') IS NOT NULL
BEGIN
	Print 'Column EmailAddress already exsists'
END
ELSE
BEGIN
	Print 'Column dos not exist'
END