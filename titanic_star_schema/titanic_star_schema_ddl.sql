-- Titanic Star Schema DDL

CREATE TABLE dim_passenger (
    PassengerKey INT PRIMARY KEY,
    PassengerId INT NOT NULL UNIQUE,
    PassengerName VARCHAR(255),
    Sex VARCHAR(20),
    Age DECIMAL(5,2),
    Title VARCHAR(50)
);

CREATE TABLE dim_class (
    ClassKey INT PRIMARY KEY,
    Pclass INT NOT NULL UNIQUE,
    ClassName VARCHAR(50),
    ClassTier VARCHAR(20)
);

CREATE TABLE dim_embarkation (
    EmbarkationKey INT PRIMARY KEY,
    Embarked VARCHAR(20) NOT NULL UNIQUE,
    EmbarkationName VARCHAR(50)
);

CREATE TABLE dim_cabin (
    CabinKey INT PRIMARY KEY,
    Cabin VARCHAR(100) NOT NULL UNIQUE,
    CabinDeck VARCHAR(20)
);

CREATE TABLE dim_ticket (
    TicketKey INT PRIMARY KEY,
    Ticket VARCHAR(100) NOT NULL UNIQUE,
    TicketPrefix VARCHAR(50)
);

CREATE TABLE dim_family (
    FamilyKey INT PRIMARY KEY,
    SibSp INT,
    Parch INT,
    FamilySize INT,
    IsAlone INT
);

CREATE TABLE dim_age_band (
    AgeBandKey INT PRIMARY KEY,
    AgeBand VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dim_fare_band (
    FareBandKey INT PRIMARY KEY,
    FareBand VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dim_source (
    SourceKey INT PRIMARY KEY,
    SourceDataset VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE fact_passenger_outcome (
    PassengerOutcomeFactKey INT PRIMARY KEY,
    PassengerKey INT NOT NULL,
    ClassKey INT NOT NULL,
    EmbarkationKey INT NOT NULL,
    CabinKey INT NOT NULL,
    TicketKey INT NOT NULL,
    FamilyKey INT NOT NULL,
    AgeBandKey INT NOT NULL,
    FareBandKey INT NOT NULL,
    SourceKey INT NOT NULL,
    PassengerCount INT NOT NULL,
    SurvivedFlag INT NOT NULL,
    DiedFlag INT NOT NULL,
    FareAmount DECIMAL(10,4),
    FOREIGN KEY (PassengerKey) REFERENCES dim_passenger(PassengerKey),
    FOREIGN KEY (ClassKey) REFERENCES dim_class(ClassKey),
    FOREIGN KEY (EmbarkationKey) REFERENCES dim_embarkation(EmbarkationKey),
    FOREIGN KEY (CabinKey) REFERENCES dim_cabin(CabinKey),
    FOREIGN KEY (TicketKey) REFERENCES dim_ticket(TicketKey),
    FOREIGN KEY (FamilyKey) REFERENCES dim_family(FamilyKey),
    FOREIGN KEY (AgeBandKey) REFERENCES dim_age_band(AgeBandKey),
    FOREIGN KEY (FareBandKey) REFERENCES dim_fare_band(FareBandKey),
    FOREIGN KEY (SourceKey) REFERENCES dim_source(SourceKey)
);