CREATE VIEW  --view is a virtual table alsocalled a saved sql query
AS
SELECT e.ID,Name,Salary,Gender,Departmentname FROM tblEmployee e JOIN tblDepartment d ON  e.DepartmentId=d.ID

SELECT * FROM vWEmployeesByDepartment--calling a view

--view adv - to reduce comlepxity of database schem:simplify wht is needed 

CREATE VIEW vWITEmployees--view row and column level security
AS
SELECT e.ID,Name,Salary,Gender,Departmentname FROM tblEmployee e JOIN tblDepartment d ON e.DepartmentId=d.ID WHERE d.Departmentname='IT' --only IT people can see salary

SELECT * FROM vWITEmployees--calling a view

CREATE VIEW vWNonConfidentialData  --just trating salary column not accesbile ie. column level security --
AS
SELECT e.ID,Name,Gender,Departmentname FROM tblEmployee e JOIN tblDepartment d ON e.DepartmentId=D.ID

CREATE VIEW vWSummarizedData--to implemennt present aggregated data  --without groub by give error : deptname is invld in select list as no present aggregate func or group by clause 
AS
SELECT Departmentname,COUNT(e.ID) as TotalEmployees   
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID
GROUP BY Departmentname

SELECT * FROM vWSummarizedData


--Updattable view  -view gets updated
CREATE VIEW vWEmployeeDataExceptSalary--view does not store any data while table dtore data
AS
SELECT ID,Name,Gender,DepartmentId
FROM tblEmployee

SELECT * FROM vWEmployeeDataExceptSalary--calling above defined updatetable view

UPDATE vWEmployeeDataExceptSalary--resemble to a table view, CRUD operations on view
SET Name='Mickey' WHERE ID=2

SELECT * FROM vWEmployeeDataExceptSalary

DELETE FROM vWEmployeeDataExceptSalary WHERE ID=2

SELECT * FROM vWEmployeeDataExceptSalary

INSERT INTO vWEmployeeDataExceptSalary VALUES(2,'Mickey','Male',2)-- gives error id is identirty column cannot extrnlyy insert/ add a value 

SET IDENTITY_INSERT roshni.dbo.tblEmployee ON  

INSERT INTO vWEmployeeDataExceptSalary (Id,Name,Gender,DepartmentId)VALUES (2,'Mickey','Male',2) --gives error slary not null specified let'sss perofrm on som other view

INSERT INTO vWEmployeesByDepartment VALUES(2,'Mickey',3000,'Male','Music') --cannot tbe affected

--CREATE VIEW vWEmployeeData
--AS
--SELECT Id,Name,DepartmentId,City 
--FROM tblEmployee

--ALTER VIEW vWEmployeeData --NOT RELATED TO SQL Server
--AS
--SELECT Id,Name,Salary,DepartmentId,City
--FROM tblEmployee

--INSERT INTO vWEmployeeData (Id,Name,Salary,DepartmentId,City) VALUES(2,'Mike',4500,2,'London')--insert updated succesffully --colum  list

CREATE VIEW vWEmployeeData1
AS
SELECT Id,Name
FROM tblEmployee

CREATE VIEW vWEmployeeData2
AS
SELECT Id,Name,Salary
FROM tblEmployee

SELECT * FROM vWEmployeeData2

INSERT INTO vWEmployeeData2 (ID,Name,Salary) VALUES(7,'Kish',1000)-- SPECIFY INSERT WIT column lit

CREATE VIEW vWEmployeeDetailsByDepartment
AS
SELECT e.ID,Name,Salary,Gender,Departmentname
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID

UPDATE vWEmployeeDetailsByDepartment
SET Departmentname='IT' WHERE Name='John'

--view is based on multipe views , may not update base table , instead trigeeres r used

--indexed views ie. viewscreated on scheme binding, 
--					agrrate func - usedd in selectlist , expression to be null replcement value to be prov
--					group by clause
--					base tables name as two part

--CREATE TABLE tblProduct
--(
--	ProductId int,
--	Name nvarchar(50),
--	UnitPrice int
--)

--CREATE TABLE tblProductSales
--(
--	ProductId int,
--	UnitsSold int
--)

TRUNCATE TABLE tblProduct

DELETE tblProduct

CREATE TABLE tblProduct
(
	ProductId int NOT NULL,
	Name nvarchar(50),
	UnitPrice int
)

CREATE TABLE tblProductSales
(
	ProductId int PRIMARY KEY,
	QuantitySold int
)
ALTER TABLE tblProduct ADD CONSTRAINT tblProduct_ProductId_FK --PRIMARY KEY - product id in sales table FOREIGN KEY - product id in product
FOREIGN KEY (ProductId) references tblProductSales(ProductId)
--CREATE VIEW vWTotalSalesBy

CREATE VIEW vWTotalSalesByProduct
WITH SCHEMABINDING
AS
SELECT Name,
SUM((ISNULL(QuantitySold*UnitPrice),0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions FROM tblProductSales ps JOIN tblProduct p
ON ps.ProductId=p.ProductId
GROUP BY Name

ALTER TABLE tblProduct DROP CONSTRAINT tblProduct_ProductId_FK 

TRUNCATE TABLE tblProductSales

TRUNCATE TABLE tblProduct








