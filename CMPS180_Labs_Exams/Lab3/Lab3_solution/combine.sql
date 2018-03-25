--Combine data

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Payments P
SET amountPaid = P.amountPaid + N.amountPaid
FROM NewPayments N
WHERE P.taxpayerID = N.taxpayerID
AND P.datePaid = N.datePaid;

INSERT INTO Payments
SELECT N.taxpayerID, N.datePaid, N.amountPaid 
FROM NewPayments N
WHERE NOT EXISTS 
	(SELECT * 
	 FROM Payments P 
	 WHERE P.taxpayerID = N.taxpayerID 
		AND P.datePaid = N.datePaid);

COMMIT TRANSACTION;

--COMMIT is also okay instead of COMMIT TRANSACTION