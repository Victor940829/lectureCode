-- Create Views

-- Create view TaxDebts
CREATE VIEW TaxDebts AS 
SELECT taxpayerID, SUM(taxOwed) AS debt 
FROM TaxReturns 
GROUP BY taxpayerID 
HAVING COUNT(*) >= 4;

--Create view PaymentCredits
CREATE VIEW PaymentCredits AS 
SELECT taxpayerID AS taxPayerID, MAX(datePaid) AS biggestDatePaid, SUM(amountPaid) AS credit 
FROM Payments 
GROUP BY taxpayerID 
HAVING COUNT(DISTINCT amountPaid) >= 2;