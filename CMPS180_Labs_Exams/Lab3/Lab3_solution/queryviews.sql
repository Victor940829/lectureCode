-- Query Views (Delinquent tax summary)

SELECT D.taxpayerID, T.debt, P.credit 
FROM Delinquents D, TaxDebts T, PaymentCredits P 
WHERE D.taxpayerID = T.taxpayerID 
	AND D.taxpayerID = P.taxpayerID;

-- Output of Delinquent Tax Summary query

-- taxpayerid |   debt    |  credit
-- -----------+-----------+-----------
--        112 | 112765.00 | 122878.93
-- (1 row)


-- Delete tuples
DELETE FROM TaxReturns WHERE taxpayerID = 112 AND taxYear = 2016;
DELETE FROM TaxReturns WHERE taxpayerID = 116 AND taxYear = 2017;

-- Output of Delinquent Tax Summary query after the tuples have been deleted

-- taxpayerid | debt | credit
-- -----------+------+--------
-- (0 rows)