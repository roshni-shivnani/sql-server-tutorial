--Corrlated subquery
SELECT Id,Name,Description					--non corelated subquery
FROM tblProducts WHERE NOT IN (SELECT distinct ProductId FROM tblProductSales)

SELECT Name,							--coorlated sub-query   give error multi-identifier tblProducts.Id could not be bound
(SELECT SUM(QuantitySold) FROM tblProductSales WHERE ProductId=tblProducts.Id)
FROM tblProducts

SELECT Name,							--coorlated sub-query  
(SELECT SUM(QuantitySold) FROM tblProductSales WHERE ProductId=tblProducts.Id)  AS QtySold -- give alias name to subquery qtysold not give error
FROM tblProducts

--Creatng a large tablewith random datafor performane testing
IF(Exists(SELECT * 
			FROM information_schema.tables
			WHERE table_name='tblProductSales'))
BEGIN
	DROP TABLE tblProductSales
END

IF(Exists(SELECT * 
			FROM information_schema.tables
			WHERE table_name='tblProducts'
))

BEGIN
	DROP TABLE tblProducts
END

