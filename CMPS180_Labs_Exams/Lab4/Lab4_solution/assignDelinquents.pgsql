CREATE OR REPLACE FUNCTION assignDelinquents (theAgent char(6), theCount integer)
RETURNS integer AS
$$

DECLARE
    assignedSoFar integer := 0;
    currentTaxPayerID integer := 0;

DECLARE cursor_i CURSOR FOR
  SELECT i.taxPayerID 
  FROM Individuals i
  WHERE i.taxPayerID IN (SELECT d.taxPayerID FROM Delinquents d WHERE d.IRSAgentID IS NULL)
  ORDER BY totalTaxOwed DESC;

BEGIN
	OPEN cursor_i;
	FETCH FROM cursor_i INTO currentTaxPayerID;
    WHILE assignedSoFar < theCount AND Found 
	LOOP
		UPDATE Delinquents d SET IRSAgentID = theAgent WHERE d.taxPayerID = currentTaxPayerID;
		assignedSoFar := assignedSoFar + 1;
		FETCH FROM cursor_i INTO currentTaxPayerID;
	END LOOP;
	RETURN assignedSoFar;
	CLOSE cursor_i;
END;
$$
LANGUAGE plpgsql

/*
Alternate solution without a cursor or a loop:

CREATE OR REPLACE function assignDelinquents (theAgent char(6), theCount integer)
RETURNS integer AS $$

	DECLARE
		result integer;
	
	BEGIN
			UPDATE Delinquents d
			SET IRSagentID = theAgent
			FROM (	SELECT d.taxpayerID, i.totalTaxOwed, d.IRSagentID
					FROM Delinquents d, Individuals i 
					WHERE d.taxpayerID = i.taxpayerID AND d.IRSagentID IS NULL
					ORDER BY i.totalTaxOwed DESC
					LIMIT theCount) as di
			WHERE d.taxpayerID = di.taxpayerID;
			GET DIAGNOSTICS result = ROW_COUNT;
			return result;
END; $$
LANGUAGE plpgsql
*/