-- General constraints

-- amountPaid in Payments must be positive
ALTER TABLE Payments ADD CONSTRAINT positive_payments CHECK (amountPaid > 0);

-- lastDateFiled in Businesses must be greater than or equal to lastDatePaid
ALTER TABLE Businesses ADD CHECK (lastDateFiled >= lastDatePaid);

-- If jobLevel is null then active must also be null
ALTER TABLE IRSAgents ADD CHECK (jobLevel IS NOT NULL OR active IS NULL);

-- In Individuals, taxpayerID and spouseID must be different
ALTER TABLE Individuals ADD CHECK (taxpayerID <> spouseID);

--Note
--In 4th constraint, it is okay to use != instead of <>.