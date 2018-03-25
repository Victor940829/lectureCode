--Unit tests

--Unit tests that violate foreign key constraints

--taxpayerID in IRSAgents table must be present as taxpayerID in Individuals table
INSERT INTO IRSAgents VALUES ('JHG765', 109, 5, TRUE);

--IRSagentID in Delinquents table must be present as IRSagentID in IRSAgents table
INSERT INTO Delinquents VALUES (124, 'GT6U89', 138);

--collectionAgencyID in Delinquents table must be present as taxpayerID in Businesses table
INSERT INTO Delinquents VALUES (130, 'P3E4RR', 112);



--Unit tests for general constraints

--Update that satisfies the constraint that amountPaid > 0 in Payments
UPDATE Payments SET amountPaid = 2000 WHERE taxpayerID = 122 AND datePaid = DATE '03/22/2015';

--Update that violates the constraint that amountPaid > 0 in Payments
UPDATE Payments SET amountPaid = -2000 WHERE taxpayerID = 122 AND datePaid = DATE '03/22/2015';

--Update that satisfies the constraint that lastDateFiled >= lastDatePaid in Businesses
UPDATE Businesses SET lastDateFiled = DATE '02/12/2018' WHERE taxpayerID = 107;

--Update that violates the constraint that lastDateFiled >= lastDatePaid in Businesses
UPDATE Businesses SET lastDateFiled = DATE '02/12/2016' WHERE taxpayerID = 107;

--Update that satisfies that if jobLevel is null then active must also be null in IRSAgents
UPDATE IRSAgents SET jobLevel = NULL WHERE IRSAgentID = '29SN06';

--Update that violates that if jobLevel is null then active must also be null in IRSAgents
UPDATE IRSAgents SET jobLevel = NULL WHERE IRSAgentID = 'KL98O4';

--Update that satisfies that taxpayerID and spouseID must be different
UPDATE Individuals SET spouseID = 128 WHERE taxpayerID = 112;

--Update that violates that taxpayerID and spouseID must be different
UPDATE Individuals SET spouseID = 112 WHERE taxpayerID = 112;