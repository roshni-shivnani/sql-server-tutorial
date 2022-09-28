CREATE PROC spGetEmployeesByGenderandDepartment
@Gender nvarchar(20),
@DepartmentId int
AS
	BEGIN
	SELECT Name,Gender,DepartmentId FROM tblEmployee WHERE Gender=@Gender AND DepartmentId=@DepartmentId
END

Exec spGetEmployeesByGenderandDepartment 'Male',3

sp_helptext spGetEmployees -- to see text of stored procedure

--to change text of stored procedure

ALTER PROC spGetEmployees  --to change text of stored procedure
AS
	BEGIN 
	SELECT Name,Gender FROM tblEmployee ORDER BY Name
END

sp_helptext spGetEmployees

DROP PROC spGetEmployeesByGenderandDepartment--to drop procedure

CREATE PROC spGetEmployeesByGenderandDepartment--encrypt procedure use in CREATE/ALTER
@Gender nvarchar(20),
@DepartmentId int
WITH ENCRYPTION
AS
	BEGIN
	SELECT Name,Gender,DepartmentId FROM tblEmployee WHERE Gender=@Gender AND DepartmentId=@DepartmentId
END

CREATE PROC spGetEmployeeCountByGender --Stored procedure with oputput parameter
@Gender nvarchar(20),
@Employeecount int OUTPUT
AS
	BEGIN
	SELECT @Employeecount=COUNT(ID) FROM tblEmployee WHERE Gender=@Gender
END

DECLARE @Totalcount int--syntax of call stored procedure with output parameter
Exec spGetEmployeeCountByGender 'Female',@Totalcount OUT
if(@Totalcount IS NULL)
Print ('@Totalcount is null')
else
Print ('@Totalcount is not null')

DECLARE @Totalcount int
Exec spGetEmployeeCountByGender @Employeecount=@Totalcount OUT,@Gender='Female' 
Print @Totalcount

sp_help spGetEmployeeCountByGender --system stored procedure (can be used on procedure,tableie. sp_help tablename,views,etc.)

sp_depends spGetEmployeeCountByGender  --to see dependenciesof stoed procedure, any of them are referencing a table thatyou are going to drop

CREATE PROCEDURE spGetTotalCount1--stored procedure withoutput parameter or return value
@Totalcount int OUT
AS
	BEGIN
	SELECT @Totalcount = COUNT(ID) FROM tblEmployee 
END

DECLARE @Total int
Exec spGetTotalCount1 @Total OUT
Print @Total

CREATE PROCEDURE spGetTotalEmployees1  --RETURN VALUES : OUT is not added AS SUFFIX in DECLARE in this return
AS
	BEGIN
	return (SELECT COUNT(ID) FROM tblEmployee)
END

DECLARE @Total int
Exec @Total=spGetTotalEmployees1
Print @Total


CREATE PROC spGetNameById--GET NAME BY ID : Another second option GetEmployeecountByGender
@Id int,
@Name nvarchar(50) OUTPUT
AS
	BEGIN
	SELECT @Name=Name FROM tblEmployee WHERE Id=@Id
END

DECLARE @EmployeeName nvarchar(50)
Exec spGetNameById 1,@EmployeeName OUTPUT
Print @EmployeeName


