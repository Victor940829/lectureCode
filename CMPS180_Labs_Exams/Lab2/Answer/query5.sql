SELECT p.taxpayerID AS "payingTaxpayer", COUNT(p.datePaid) AS "howmanyPayments", SUM(p.amountPaid) AS "sumPayments"
FROM Payments p
GROUP BY p.taxpayerID