-- Platform: Practice SQL / Interview Prep
-- Question: Temperature Difference from Previous Day
-- Difficulty: Medium
-- Date: 2026-02-07

-- Problem:
-- Find the daily temperature change for each city. For each record, 
-- return the city, the date, the current temperature, and how much 
-- the temperature has risen or fallen since the previous recorded day.

-- Approach:
-- 1. Use the LAG() function to retrieve the temperature from the previous row.
-- 2. PARTITION BY City to ensure we aren't comparing temperatures of different cities.
-- 3. ORDER BY RecordDate ASC to ensure the "previous" row is the day before.
-- 4. Subtract the previous temperature from the current temperature to find the delta.
-- 5. Use a CTE to keep the code clean and handle the initial NULL value.

-- Concepts:
-- 1. Window Functions (LAG)
-- 2. Partitioning (PARTITION BY)
-- 3. Arithmetic in SQL
-- 4. Trend Analysis

WITH t1 AS (
  SELECT 
    City,
    RecordDate,
    Temperature,
    LAG(Temperature) OVER(
      PARTITION BY City 
      ORDER BY RecordDate ASC
    ) AS Prev_Temp
  FROM WeatherData
)
SELECT 
  City,
  RecordDate,
  Temperature,
  (Temperature - Prev_Temp) AS Temp_Change
FROM t1;