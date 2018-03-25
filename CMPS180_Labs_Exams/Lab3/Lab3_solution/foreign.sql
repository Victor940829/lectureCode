--Foreign key constraints

--taxpayerID in IRSAgents table references taxpayerID primary key in Individuals table
ALTER TABLE IRSAgents ADD FOREIGN KEY (taxpayerID) REFERENCES Individuals(taxpayerID);

--IRSagentID in Delinquents table references IRSagentID primary key in IRSAgents table
ALTER TABLE Delinquents ADD FOREIGN KEY (IRSagentID) REFERENCES IRSAgents(IRSagentID);

--collectionAgencyID in Delinquents table references taxpayerID primary key in Businesses table
ALTER TABLE Delinquents ADD FOREIGN KEY (collectionAgencyID) REFERENCES Businesses(taxpayerID);
