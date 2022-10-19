--Data Normalisation
--to minimize data redundancy thaatturn data to be consistent

--Prob of data redundancy : Disk space wastage, Data Inconsistent, DML queries can become slow

--3NF - not contain primary key column (name not cntai id)

SELECT SalesCountry,SalesAgent,SUM(SalesAmount) AS TotalEmployees
FROM tblProductSales
GROUP BY SalesCountry,SalesAgent
ORDER BY SalesCountry,SalesAgent

CREATE TABLE tblPS
(
	SalesAgent nvarchar(50),
	SalesCountry nvarchar(50),
	SalesAmount int
)

DROP TABLE tblPS

Use [roshni]
Go

CREATE TABLE tblPS
(	
	SalesAgent nvarchar(50),
	SalesCountry nvarchar(25),
	SalesAmount int
)

--Group By Query :Pivot Operator
SELECT SalesCountry,SalesAgent,SUM(SalesAmount) AS TotalEmployees
FROM tblPS
GROUP BY SalesCountry,SalesAgent
ORDER BY SalesCountry,SalesAgent

--pIVOT : UNIQUE VLAUES into multiple columns  unique contry names turn as columns ie. rows to colmns
Use [roshni]
Go

SELECT SalesAgent,India,US,UK
FROM tblPS
PIVOT
(
	SUM(SalesAmount)
	FOR SalesCountry
	IN(INDIA,US,UK)

)
AS PivotTable

Use [roshni]
Go

SELECT SalesAgent,India,US,UK --Example 2
FROM
(
	SELECT SalesAgent,SalesCountry,SalesAmount
	FROM tblPS
) AS SourceTable
PIVOT
(
	SUM(SalesAmount) FOR SalesCountry IN (India,US,UK)	
) AS PivotTable

--Error handling
--before 2000 using @@error post 2000 Try Catch
CREATE PROCEDURE spSellProduct
@Productid int,
@QuantityToSell int
AS
BEGIN
	DECLARE @StockAvailable int
	SELECT @StockAvailable=QtyAvailable
	FROM tblProduct WHERE ProductId=@ProductId

	if(@StockAvailable<@QuantityToSell)
	BEGIN
		Raiserror('Not enough stock avialble',16,1)
	END

	ELSE
	BEGIN
		BEGIN TRAN
			UPDATE tblProduct SET QtyAvailable=(QtyAvailable-@QuantityToSell)
			WHERE ProductId=@ProductId

			DECLARE @MaxProductSalesId int

			SELECT @MaxProductSalesId = CASE WHEN
										MAX(ProductSalesId) IS NULL
										THEN 0 ELSE MAX(ProductSalesId) END
										FROM tblProductSales

			SET @MaxProductSalesId=@MaxProductSalesId+1
			INSERT INTO tblProductSales VALUES(@ProductId,@QuantityToSell,@MaxProductSalesId)
		COMMIT TRAN
		END
END

Execute spSellProduct 1,10--calling procedure

select * from tblProduct
select * from tblProductSales

--Exaple 2 not incrementing maxproductsalesid give error
ALTER PROCEDURE spSellProduct
@Productid int,
@QuantityToSell int
AS
BEGIN
	DECLARE @StockAvailable int
	SELECT @StockAvailable=QtyAvailable
	FROM tblProduct WHERE ProductId=@ProductId

	if(@StockAvailable<@QuantityToSell)
	BEGIN
		Raiserror('Not enough stock avialble',16,1)
	END

	ELSE
	BEGIN
		BEGIN TRAN
			UPDATE tblProduct SET QtyAvailable=(QtyAvailable-@QuantityToSell)
			WHERE ProductId=@ProductId

			DECLARE @MaxProductSalesId int

			SELECT @MaxProductSalesId = CASE WHEN
										MAX(ProductSalesId) IS NULL
										THEN 0 ELSE MAX(ProductSalesId) END
										FROM tblProductSales

			----SET @MaxProductSalesId=@MaxProductSalesId+1 --uncomment for suc exec
			INSERT INTO tblProductSales VALUES(@ProductId,@QuantityToSell,@MaxProductSalesId)
			IF(@@ERROR <> 0)				--littlle change
			BEGIN
				ROLLBACK TRANSACTION
				PRINT 'Transaction rollback'
			END
			ELSE
			BEGIN
		COMMIT TRAN
		PRINT 'Transaction commit'
		END
		END
END

Execute spSellProduct 1,10

--Error returns a NON ZERO value, if error returnszero,indicating prev sql stat. had thrown no error
--e.g. INSRT INTO tblProduct VALUES(2,'Mobil Phone',1500,100)
--			IF(@@ERROR <> 0)
--				PRINT 'Error Occured'
--			ELSE
--				PRINT 'No Erros'

INSERT INTO tblProduct VALUES(2,'Mobil Phone',1500,100)
		SELECT * FROM tblProduct --select stat. put @@error =0  GENERALLY GIVE ERROR IN OUR CASE NO EROR DUE TO PRIMARY KEY NOT SET
			IF(@@ERROR <> 0)
				PRINT 'Error Occured'
			ELSE
				PRINT 'No Erros'

DECLARE @Error int
INSERT INTO tblProduct VALUES(2,'Mobil Phone',1500,100)
SET @Error=@@ERROR
IF(@Error <> 0)
	PRINT 'Error Occured'
ELSE
	PRINT 'No Errors'