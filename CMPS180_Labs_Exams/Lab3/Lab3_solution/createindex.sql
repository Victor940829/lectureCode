-- Create index

-- Index on kind and dateFiled
CREATE INDEX LookUpReturns
ON TaxReturns (kind, dateFiled);