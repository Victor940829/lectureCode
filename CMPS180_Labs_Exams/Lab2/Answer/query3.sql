(SELECT i.name, i.address, p.datePaid, p.amountPaid
FROM Individuals i, Payments p
WHERE i.taxpayerID = p.taxpayerID
	AND p.datePaid >= '2017-03-01')
UNION ALL
(SELECT b.name, b.address, p.datePaid, p.amountPaid
FROM Businesses b, Payments p
WHERE b.taxpayerID = p.taxpayerID
	AND p.datePaid >= '2017-03-01')

