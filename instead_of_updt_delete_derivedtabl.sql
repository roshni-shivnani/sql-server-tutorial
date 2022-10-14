

CREATE VIEW vWEmployeeDetails4
AS
SELECT e.Id,Name,Gender,Departmentname
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId = d.ID  --givessss error already exists it is ok

Use [roshni]
Go

CREATE TRIGGER tr_vWEmployeeDetails4_InteadofUpdate
ON vWEmployeeDetails4
INSTEAD OF UPDATE
AS
BEGIN
	if(UPDATE(Id))
		BEGIN
			Raiserror('Id cannot be changed',16,1)
			RETURN
		END
	if(UPDATE(Departmentname))
		BEGIN
			Declare @DepartmentId int

			SELECT @DepartmentId=d.ID
			FROM tblDepartment d JOIN inserted i
			ON i.Departmentname=d.Departmentname

			if(@DepartmentId is null)
				BEGIN
					Raiserror('Invalid Department Name',16,1)
					RETURN
				END
			UPDATE tblEmployee SET DepartmentId=@DepartmentId  --updat req. join on emp id due to need to update emp id if dept i changed
			FROM inserted i JOIN tblEmployee e ON e.Id=i.Id
		END
	if(UPDATE(Gender))
		BEGIN
			UPDATE tblEmployee SET Gender=i.Gender
			FROM inserted i JOIN tblEmployee e
			ON e.Id=i.Id
	
		END
	if(UPDATE(Name))
		BEGIN
			UPDATE tblEmployee SET Name=inserted.Name
			FROM inserted i JOIN tblEmployee e
			ON e.Id=i.Id
		END
END

UPDATE vWEmployeeDetails4 SET Departmentname='IT' WHERE Id=1 --from hr to it John dept changed

UPDATE vWEmployeeDetails4 SET Name='Johny',Departmentname='IT' WHERE Id=1  --name chng from John to Johny and his dept also


--Instead of Delete
CRATE VIW vWEmployeeDetails5
AS
SELECT Id,Name,Gender,Departmentname
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID 

CREATE TIGGER tr_vWEmployeeDetails5_InsetadofDelete
ON vWEmployeeDetails5
INTEAD OF DELETE
AS
BEGIN
	DELETE tblEmployee
	FROM tblEmployee e
	JOIN deleted d
	ON e.Id=d.Id 

	--subquery ,joins r faster than former one , when we required a subset of records, subquery is choice for use
	--DELETE FROM tblEmployee
	--WHERE Id in (SELECT Id FROM deleted)
END

DELETE FROM vWEmployeeDetails5 WHERE Id IN (1,2)

DELETE FROM vWEmployeeDetails5 WHERE Id IN(3,4)

--derived tables #views#
CREATE VIEW vWEmployeeCount  --its difficult to hv view count of emp 
AS
SELECT DepartmentId,Departmentname,COUNT(*) AS TotalEmployees
FROM tblDepartment d
JOIN tblEmployee e
ON d.ID=e.DepartmentId
GROUP BY DepartmentId,Departmentname

SELECT Departmentname,TotalEmployees FROM vWEmployeeCount WHERE TotalEmployees>=2
 
--temp table
SELECT Departmentname,DepartmentId,COUNT(*) AS TotalEmployees
INTO #TempEmployeeCount
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID
GROUP BY Departmentname,DepartmentId

SELECT Departmentname,DepartmentId,COUNT(*) AS TotalEmployees --option 2
INTO #TempEmployeeCount
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID
GROUP BY Departmentname,DepartmentId

SELECT Departmentname,TotalEmployees FROM #TempEmployeeCount WHERE TotalEmployees>=2

DROP TABLE #TempEmployeeCount

--Table variable has same eyntax as tep table , sc
--				scope batch,stoed procedure
--				used	as parameters in stored procedure

DECLARE @tblEmployeeCount TABLE (Departmentname nvarchar(45),DepartmentId int,TotalEmployees int)--if we want count from join as variable use table as variable 

INSERT @tblEmployeeCount
SELECT Departmentname,DepartmentId,COUNT(*) AS TotalEmployees
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID
GROUP BY Departmentname,DepartmentId

SELECT Departmentname,TotalEmployees FROM @tblEmployeeCount WHERE TotalEmployees>=2

--derived table not need definition ie. no declaration in select stat. itself is derived
--	it is valid in current query

SELECT Departmentname,TotalEmployees
FROM (
	SELECT Departmentname,DepartmentId,COUNT(*) AS TotalEmployees 
	FROM tblEmployee e JOIN tblDepartment d 
	ON e.DepartmentId=d.ID 
	GROUP BY Departmentname,DepartmentId
)
AS EmployeeCount
WHERE TotalEmployees>=2

--CTE   
WITH EmployeeCount (Departmentname ,DepartmentId,TotalEmployees) --table varivble similarity only name of parameter passed not 
AS
(
	SELECT Departmentname,DepartmentId,COUNT(*) AS TotalEmployees
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID
GROUP BY Departmentname,DepartmentId
)

SELECT Departmentname,TotalEmployees FROM EmployeeCount WHERE TotalEmployees>=2



