-- 1) Survival rate by passenger class
SELECT c.ClassName,
       SUM(f.SurvivedFlag) AS Survivors,
       SUM(f.PassengerCount) AS Passengers,
       ROUND(100.0 * SUM(f.SurvivedFlag) / SUM(f.PassengerCount), 2) AS SurvivalRatePct
FROM fact_passenger_outcome f
JOIN dim_class c ON f.ClassKey = c.ClassKey
GROUP BY c.ClassName
ORDER BY c.Pclass;

-- 2) Survival rate by sex and age band
SELECT p.Sex,
       a.AgeBand,
       SUM(f.SurvivedFlag) AS Survivors,
       SUM(f.PassengerCount) AS Passengers,
       ROUND(100.0 * SUM(f.SurvivedFlag) / SUM(f.PassengerCount), 2) AS SurvivalRatePct
FROM fact_passenger_outcome f
JOIN dim_passenger p ON f.PassengerKey = p.PassengerKey
JOIN dim_age_band a ON f.AgeBandKey = a.AgeBandKey
GROUP BY p.Sex, a.AgeBand
ORDER BY p.Sex, a.AgeBand;

-- 3) Revenue proxy and survival by embarkation point
SELECT e.EmbarkationName,
       ROUND(SUM(f.FareAmount), 2) AS TotalFareAmount,
       SUM(f.SurvivedFlag) AS Survivors,
       SUM(f.PassengerCount) AS Passengers
FROM fact_passenger_outcome f
JOIN dim_embarkation e ON f.EmbarkationKey = e.EmbarkationKey
GROUP BY e.EmbarkationName
ORDER BY TotalFareAmount DESC;

-- 4) Survival rate by family size
SELECT fam.FamilySize,
       SUM(f.SurvivedFlag) AS Survivors,
       SUM(f.PassengerCount) AS Passengers,
       ROUND(100.0 * SUM(f.SurvivedFlag) / SUM(f.PassengerCount), 2) AS SurvivalRatePct
FROM fact_passenger_outcome f
JOIN dim_family fam ON f.FamilyKey = fam.FamilyKey
GROUP BY fam.FamilySize
ORDER BY fam.FamilySize;