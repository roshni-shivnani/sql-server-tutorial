select * from roshni.dbo.tblPerson; --select query write this way or right clickk on table ame script table as ->select 

select DISTINCT City from roshni.dbo.tblPerson;--selcet distinct records from a column

select * from roshni.dbo.tblPerson WHERE City='London' --FITERING rows**

select * from roshni.dbo.tblPerson WHERE City <> 'London' --not equal to in where caluse

select * from roshni.dbo.tblPerson WHERE Age IN(10)--operators

select * from roshni.dbo.tblPerson WHERE Age BETWEEN 5 AND 10 

select * from roshni.dbo.tblPerson WHERE City LIKE 'L%'

select * from roshni.dbo.tblPerson WHERE Email LIKE '_@_.com'

select * from roshni.dbo.tblPerson WHERE Name LIKE '[MST]%'

select * from roshni.dbo.tblPerson WHERE Name LIKE '[^MST]%'

select * from roshni.dbo.tblPerson WHERE (City='Paris' or City='London') AND Age>5

SELECT * FROM roshni.dbo.tblPerson ORDER BY Name DESC, Age ASC  -- Sorting rows using order by

SELECT TOP 5 * FROM roshni.dbo.tblPerson 


--Group By  (created a new table emp and inserted some records)
TRUNCATE TABLE roshni.dbo.tblEmployee

DBCC CHECKIDENT('roshni.dbo.tblEmployee',RESEED,0) -- SET idenity to start from 1

TRUNCATE TABLE roshni.dbo.tblEmployee

SELECT SUM(Salary) from roshni.dbo.tblEmployee

SELECT CITY,SUM(Salary) as TotalSalary 
FROM roshni.dbo.tblEmployee
GROUP BY City

Select City,Gender,SUM(Salary) as TotalSalary
FROM roshni.dbo.tblEmployee
GROUP BY City,Gender
ORDER BY City

SELECT COUNT(ID) FROM roshni.dbo.TBLEmployee

SELECT City,Gender,SUM(Salary) as TotalSalary, COUNT(ID) as TotalEmployess--Total Emplyees group by Ciy and gender
FROM roshni.dbo.tblEmployee
GROUP BY City,Gender

SELECT City,Gender,SUM(Salary) as TotalSalary, COUNT(ID) as TotalEmployess
FROM roshni.dbo.tblEmployee--male emloyees total in a city
WHERE Gender='Male'
GROUP BY City,Gender

SELECT City,Gender,SUM(Salary) as TotalSalary,COUNT(ID) as TotalEmployees
FROM roshni.dbo.tblEmployee
GROUP BY City,Gender
HAVING SUM(Salary)>5000

--JOINS
--adding a column departmnt
ALTER TABLE roshni.dbo.tblEmployee ADD DepartmentId int
--second table creation
CREATE TABLE tblDepartment
(

ID int Primary Key NOT NULL,
DepartmentName nvarchar(50),
Locationz nvarchar(20),
DepartmentHead nvarchar(50)
)

INSERT INTO roshni.dbo.tblDepartment (ID,DepartmentName,Locationz,DepartmentHead) VALUES (1,'IT','London','Rick') 

Use [roshni]
Go
CREATE TABLE tblDepartment
(
ID int Primary Key NOT NULL,
Departmentname nvarchar(50),
Locationz nvarchar(20),
DepartmentHead nvarchar(50)
)

INSERT INTO roshni.dbo.tblDepartment VALUES (1,'IT','London','Rick')