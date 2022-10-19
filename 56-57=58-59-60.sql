--Try Catch
--find stat. on error ie.e UPDATE & INSER T in try, catch sees error functions ike errormessage()
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
		BEGIN TRY
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
			COMMIT TRAN --littllle change - commi tafter insert yo check error value in catch then
		END TRY
			--IF(@@ERROR <> 0)				--littlle change
			BEGIN CATCH
				ROLLBACK TRANSACTION
		--		PRINT 'Transaction rollback'
		--	END
		--	ELSE
		--	BEGIN
		
		--PRINT 'Transaction commit'
			SELECT ERROR_NUMBER() AS Errornumber,
			ERROR_MESSAGE() AS Erormessage,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_STATE() AS ErrorState,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_LINE() AS ErrorLine
			END CATCH
		END
END

Execute spSellProduct 1,10 --gives error due to primary key violation update row in product salessss not occured due to increment of maxid uncommented

--Transaction is if all commands excue txn is successul, id oe o fcommandfails, txn rollback
SELECT * FROM tblProduct

BEGIN TRANSACTION  --adding begin txn other connection no able to se update dataIE. DATA UPDATEEED WITHI AN TXN
UPDATE tblProduct SET QtyAvailable = 200 WHERE ProductId=1 

--In Other Xonnection
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED DATA  --addind ths line see update data

SELECT * FROM tblProduct

BEGIN TRANSACTION
UPDATE tblProduct SET QtyAvailable = 300 WHERE ProductId=1 
ROLLBACK TRANSACTION---INS ELECT STAT. CAN ONLY SEE UNCMMITED DATA i.e. 200 not 300

COMMIT TRANSACTION --saves the txn

--twotabls : tblailingAdress and tblPhysicalAddress
CREATE PROCEDURE spUpdateAddress
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblMailingAddress SET City='LONDON'
			WHERE AddressId=1 and EmployeeNumveeer= 101

			UPDATE tblphysicalAddress AWR City='LONDON'
			WHERE Addressid=1 and Employeenumber = 101
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		Print 'Transaction RolledBack'
	END CATCH
END

SELECT * FROM tblMailingAddress
SELECT * FROM tblPhysicalAddress
Execute spUpdateAddress--calling a procedure

ALTER PROCEDURE spUpdateAddress --Examke 2 if for phyaddr tbable datye size is 10 chrs throw rror
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE tblMailingAddress SET City='LONDON1'
			WHERE AddressId=1 and EmployeeNumveeer= 101

			UPDATE tblphysicalAddress AWR City='LONDON LONDON'
			WHERE Addressid=1 and Employeenumber = 101
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		Print 'Transaction RolledBack'
	END CATCH
END

--TRASANASACTION : acid
--aTOMIC
--Co nnisstent - : tblProduct and ProductSales e.g. of maxproductalesid an inentory should not disappaear 
SELECT * FROM tblProduct

BEGIN TRANSACTION
UPDATE tblProduct SET QtyAvailable = 300 WHERE ProductId=1 

--In other connection
SELECT * FROM tblProduct WHERE ProductId=2 --execte sfater due to id -1 has txn running not this onee


--SUBQUERIES
--to need productid not sold atleast once        L nw tale tblProducts 
SELECT Id,Name,[Description]
FROM tblProducts
WHERE NOT IN (SELECT DISTINCT ProductId FROM tblProductSales)

SELECT tblProduct.Id,Name,[Description]  -- give common rows of both product
FROM tblProducts
INNER JOIN tblProductSales
ON tblProducts.Id=tblProductSales.ProductId


SELECT tblProduct.Id,Name,[Description] -- this give correct output oe. only id of tblproduct table
FROM tblProducts
LEFT JOIN tblProductSales
ON tblProducts.Id=tblProductSales.ProductId
WHERE tblProductSales.ProductId is null

SELECT Name,--to need name of poduct, quantit sold a per produc nam
SUM(QuantitySold) FROM tblProductSales WHERE ProductId=tblPoducts.Id) AS QtySold
FROM tblProducts
ORDER BY Name

SELECT Name,SUM(QuantitySold) AS QtySold
FROM tblProducts
LEFT JOIN tblProductSales
ON tblProducts.Id=tblPro ie. nested queryductSales.ProductId
GROUP BY Name

--subquery is basically   nest a query in sleect stat.
 --upto 32 level stt. is nested
