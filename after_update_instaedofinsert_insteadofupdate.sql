CREATE TRIGGER tr_tblEmployee_ForUpdate6
ON tblEmployee
FOR UPDATE
AS
BEGIN
	DECLARE @Id int,
	DECLARE @NewName nvarchar(50),@OldName nvarchar(50),
	DECLARE @NewSalary nvarchar(50),@OldSalary nvarchar(50),
	DECLARE @NewGender nvarchar(50),@OldGender nvarchar(50),
	DECLARE @NewDepartmentId int,@OldDepartmentId int
	
	DECLARE @AuditString nvarcahr(1000)

	SELECT * 
	INTO #TempTable
	FROM  inserted

	WHILE(EXISTS(Select @Id FROM #TempTable))
	BEGIN
		SET @AuditString=''

		SELECT TOP 1 @Id=Id,@NewName=Name,@NewSalary=Salary,@NewGender=@Gender,@NewDepartmentId=DepartmentId
		FROM #TempTable WHERE Id=@Id

		SELECT @OldName=Name,@OldSalary=Salary,@OldGender=Gender,@OldDepartmentId=DepartmentId
		FROM deleted WHERE Id=@Id

		SET @AuditString='Employee with Id'+Cast(@Id AS nvarchar(16))+'changed from'
		if(@OldName <> @NewName)
			SET @AuditString=@AuditString+'Name from'+@OldName+'to'+@NewName
		if(@OldName <> @NewName)
			SET @AuditString=@AuditString+'Name from'+@OldName+'to'+@NewName
		if(@OldName <> @NewName)
			SET @AuditString=@AuditString+'Name from'+@OldName+'to'+@NewName
		if(@OldName <> @NewName)
			SET @AuditString=@AuditString+'Name from'+@OldName+'to'+@NewName

		INSERT INTO tblEmployeeAudit VALUES(@AuditString)
		DELETE FROM #TempTable WHERE Id=@Id --deleting tem table is req. due to loop will continue to any time

END


Use [roshni]
Go

CREATE VIEW vWEmployeeDetails3--modify view based on insteadof  triger 
AS
	SELECT e.Id,Name,Gender,Departmentname
	FROM tblEmployee e JOIN tblDepartment d
	ON e.DepartmentId=d.ID

INSERT INTO vWEmployeeDetails3 VALUES(7,'Valarie','Female','IT') --give error insert modication affectsss multiple base tables sol is below concept

--soln is instead of trigger
CREATE TRIGGER tr_vwEmployeeDetails3_InsteadofTrigger
ON vWEmployeeDetails3
INSTEAD OF INSERT
AS
BEGIN
	SELECT * FROM inserted
	SELECT * FROM deleted
END

INSERT INTO vWEmployeeDetails3 VALUES(7,'vALARIE','Female','IT')--caling a trigger

ALTER TRIGGER tr_vWEmployeeDetails3_InsteadofTrigger
ON vWEmployeeDetails3
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @DepartmentId int

	SELECT @DepartmentId=d.ID
	FROM tblDepartment d
	JOIN inserted i
	ON i.Departmentname=d.Departmentname		--insertd.Departmentname=tblDepartment.Departmentname

	if(@DepartmentId is null)
	BEGIN
		Raiserror('Invalid Department Name, Statement Terminated',16,1)   --silimar to exception handling stat. raiseror
		RETURN
	END
	INSERT INTO tblEmployee (Id,Name,Gender,DepartmentId)
	SELECT Id,Name,Gender,@DepartmentId
	FROM inserted
END

INSERT INTO vWEmployeeDetails3 VALUES(7,'vALARIE','Female','iwewueT')--calling a trigger  last column (iwewueT) is duplicate name so ie. not an IT,Payroll Dept so error msg comes as we req.

CREATE VIEW vWEmployeeDetails4
AS
SELECT e.Id,Name,Gender,Departmentname
FROM tblEmployee e JOIN tblDepartment d
ON e.DepartmentId=d.ID



CREATE TRIGGER tr_vWEmployeeDetails4_InsteadofUpdate
ON vWEmployeeDetails4
INSTEAD OF UPDATE
AS
BEGIN
	--if Employee is updated
	if(UPDATE(Id))
	BEGIN
		Raiseerror('Id cannot be changed',16,1)
		RETURN
	END
	--if deptName is updated
	if(UPDATE(Departmentname))
		BEGIN
			DECLARE @DepartmentId int

			SELECT @DepartmentId=d.ID
			FROM tblDepartment d
			JOIN inserted i
			ON i.Departmentname=d.Departmentname

			if(@DepartmentId is null)
				BEGIN
					Raiseerror('Invalid Department Name',16,1)
					RETURN
				END

			UPDATE tblEmployee SET DepartmentId=@DepartmentId
			FROM inserted JOIN tblEmployee
			ON tblEmployee.Id=inserted.Id
		END
END