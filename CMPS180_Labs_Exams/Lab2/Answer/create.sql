DROP SCHEMA Lab2 CASCADE; 
CREATE SCHEMA Lab2;

CREATE TABLE TaxReturns (
	taxpayerID INT NOT NULL,
	taxYear INT NOT NULL,
	kind CHAR(1),
	dateFiled DATE NOT NULL,
	income DECIMAL(11,2),
	taxOwed DECIMAL(11,2),
	PRIMARY KEY (taxpayerID, taxYear),
	UNIQUE (taxpayerID, dateFiled)
);

CREATE TABLE Payments (
	taxpayerID INT NOT NULL,
	datePaid DATE NOT NULL,
	amountPaid DECIMAL(11,2) NOT NULL,
	PRIMARY KEY (taxpayerID, datePaid)
);

CREATE TABLE Individuals (
	taxpayerID INT PRIMARY KEY NOT NULL,
	name VARCHAR(30),
	address VARCHAR(30),
	spouseID INT,
	lastDateFiled DATE,
	lastDatePaid DATE,
	totalTaxOwed DECIMAL(11,2),
	UNIQUE (spouseID)
);

CREATE TABLE Businesses (
	taxpayerID INT PRIMARY KEY NOT NULL,
	name VARCHAR(30),
	address VARCHAR(30),
	businessType CHAR(1),
	lastDateFiled DATE,
	lastDatePaid DATE,
	totalTaxOwed DECIMAL(11,2),
	UNIQUE (name, address)
);

CREATE TABLE IRSagents (
	IRSagentID CHAR(6) PRIMARY KEY NOT NULL,
	taxpayerID INT NOT NULL,
	jobLevel INT,
	active BOOLEAN
);

CREATE TABLE Delinquents (
	taxpayerID INT PRIMARY KEY NOT NULL,
	IRSagentID CHAR(6),
	collectionAgencyID INT
);

