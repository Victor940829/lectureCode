SELECT i1.name AS "taxpayerName", i2.name AS "spouseName"
FROM Individuals i1, Individuals i2
WHERE i1.taxpayerID = i2.spouseID
	AND i2.taxpayerID = i1.spouseID