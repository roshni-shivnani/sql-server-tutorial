SELECT Country,Gender,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Country, Gender

UNION ALL

SELECT Country,NULL,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Country

UNION ALL

SELECT NULL,Gender,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Gender

UNION ALL

SELECT NULL,NULL,SUM(Salary) AS TotalSalary
FROM Employees


SELECT Country,Gender,SUM(Salary) AS TotalSalary
FROM Employees
Group By Cube(Country,Gender)


SELECT Country,Gender,SUM(Salary) AS TotalSalary
FROM Employees
Group By Country,Gender WITH Cube

SELECT Country,Gender,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY
	GROUPING SETS
	(
		(Country,Gender),
		(Country),
		(Gender)
	)


DECLARE @TargetNumber INT   --besides execute in the menu click on debug
SET @TargetNumber =10
EXECUTE spPrintEvenNumbers @TargetNumber
Print 'Done'