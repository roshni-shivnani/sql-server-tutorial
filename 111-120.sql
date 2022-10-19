SELECT * FROM Employees ORDER BY Salary DESC;

WITH Result AS
(
	SELECT Salary,
	RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
	FROM Employees
)
SELECT TOP 1 Salary FROM Result WHERE RANK =1

SELECT Name,Gender,Salary,
LEAD(Salary,2,-1) OVER (ORDER BY Salary) AS Lead,
LAG(Salary,1,-1) OVER (ORDER BY Salary) AS Lead
FROM Employees 

SELECT Continent,Country,City, SUM(SaleAmount) AS TotalSales,
		CAST(GROUPING(Continent) AS nvarchar(1))+
		CAST(GROUPING(Continent) AS nvarchar(1))+
		CAST(GROUPING(Continent) AS nvarchar(1))+
		GROUPING_ID(Continent,Country,City) AS GPID
FROM Sales
GROUP BY ROLLUP(Continent,Country,City)