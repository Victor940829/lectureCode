SELECT b.taxpayerID
FROM Businesses b
WHERE (b.name LIKE 'TI%')
	AND (b.taxpayerID NOT IN (SELECT t.taxpayerID
							FROM TaxReturns t))