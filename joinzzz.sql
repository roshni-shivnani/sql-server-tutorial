SELECT Name,Gender,Salary,DepartmentName --INNER JOIN returns only matching rows non-matching rows are eliminated 
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID

SELECT Name,Gender,Salary,DepartmentName  --LEFT OUTER JOIN returns all matching and non-matching rows from left table
FROM tblEmployee
LEFT OUTER JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
RIGHT OUTER JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name,Gender,Salary,DepartmentName --FULL OUTER JOIN returns all matching non matching rows from both tables
FROM tblEmployee
FULL JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID

SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
CROSS JOIN tblDepartment


--SELECT columnList
--	FROM lefttable
--	Join_Type righttable
--	ON Joincondition

--Intelligent Join apart from 5 joins

SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
LEFT JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID
WHERE tblEmployee.DepartmentId IS NULL

SELECT Name,Gender,Salary,DepartmentName  -- Non mtahcing rows from right rtable
FROM tblEmployee
RIGHT JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID
WHERE tblEmployee.DepartmentId IS NULL

SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
FULL JOIN tblDepartment
ON tblEmployee.DepartmentId=tblDepartment.ID
WHERE tblEmployee.DepartmentId IS NULL OR tblDepartment.ID IS NULL

--Self Join

--Always first column is /keep NOT NULL

SELECT E.Name as Employee,M.Name as Manager
FROM tblEmp E
LEFT JOIN tblEmp M
ON E.ManagerId=M.EmployeeId

SELECT E.Name as Employee,M.Name as Manager
FROM tblEmp E
INNER JOIN tblEmp M
ON E.ManagerId=M.EmployeeId

SELECT E.Name as Employee,M.Name as Manager
FROM tblEmp E
CROSS JOIN tblEmp M

--null relacement with some word

SELECT E.Name as Employee, ISNULL(M.Name,'No Manager') as Manager
FROM tblEmp E
LEFT JOIN tblEmp M
ON E.ManagerId=M.EmployeeId

SELECT E.Name as Employee,COALESCE(M.Name,'No Manager') as Manager
FROM tblEmp E
LEFT JOIN tblEmp M
ON E.ManagerId=M.EmployeeId

--COALESCE() returns first NOT NULL Vaue e.g. if we have FirstName,MiddleName,LastName if for a record, we dont know firstname of person i.e.e NULL if middlename is there middle name is returned
--SELECT E.Name as Employee, COALESCE(FirstName,Middlename,LatName) as Name
--FROM tblEmp
  ----------------OR------------
--SELECT Id,COALESCE(FirrstName,MiddleNAME,Lastname) as Name
--From tblEmp



SELECT * from                        --UNION and UNION ALL
UNION
SELECT * FROM tblGender --thows error UNION all comuns same no. and thrir types  should besame

SELECT *  from Test11 --UNION removes all duplicates while UNION ALL does not & sort rows
UNION
SELECT * FROM Test22 

SELECT * FROM Test11
UNION ALL
SELECT * FROM Test22

SELECT * FROM Test11
UNION ALL
SELECT * FROM Test22
ORDER BY Valuez

--Stored Procedure
CREATE PROCEDURE spGetEmployees
AS
BEGIN
	SELECT Name,Gender FROM tblEmployee
END


Exec spGetEmployees--CALL Prodedure

CREATE PROCEDURE spGetEmployeesByGenderandDepartment
@Gender nvarchar(20),
@DepartmentId int
AS
	BEGIN
	SELECT Name,Gender,DepartmentId FROM tblEmployee WHERE G
END
