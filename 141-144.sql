CREATE PROCEDURE spSearchEmployeesBadDynamicSQL
@FirstName nvarchar(100)=NULL,
@LastName nvarchar(100)=NULL,
@Gender nvarchar(25)=NULL,
@Salary int = NULL
AS
BEGIN
	DECLARE @sqlnvarchar(max)

	SET @sql = 'SELECT * FROM Employees WHERE 1=1'
	IF @FirstName is not null
		SET @sql=@sql+'and FirstName='''+@FirstName+''''

	IF @LastName is not null
		SET @sql=@sql+'and FirstName='''+@FirstName+''''

	IF @Gender is not null
		SET @sql=@sql+'and FirstName='''+@FirstName+''''
	IF @Salary is not null
		SET @sql=@sql+'and FirstName='''+@FirstName+''''

	Exec sp_executesql
END
GO