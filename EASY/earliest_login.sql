-- Platform: Practice SQL / Interview Prep
-- Question: Identify First Login per User
-- Difficulty: Medium
-- Date: 2026-02-01

-- Problem:
-- Find the earliest login record for every user. If a user has logged in 
-- multiple times, only the very first login (by timestamp) should be returned.

-- Approach:
-- 1. Use a CTE to assign a sequential number to each login per user.
-- 2. Use ROW_NUMBER() to ensure each row gets a unique sequence.
-- 3. Partition by UserID to isolate the login history for each individual.
-- 4. Order by LoginTimestamp (casted to DATETIME) in ascending order to find the earliest.
-- 5. Include LoginID in the ORDER BY as a tie-breaker for identical timestamps.
-- 6. Filter the results in the outer query where the row number (rn) is 1.

-- Concepts:
-- 1. ROW_NUMBER() Window Function
-- 2. Data Type Casting (CAST)
-- 3. Multi-column Sorting (Tie-breaking)
-- 4. First-Value Filtering

WITH t1 AS (
  SELECT 
    UserID, 
    Device,
    LoginID,
    ROW_NUMBER() OVER(
      PARTITION BY UserID 
      ORDER BY 
        CAST(LoginTimestamp AS DATETIME(0)) ASC, 
        LoginID ASC
    ) AS rn
  FROM UserLogins
)
SELECT * FROM t1 
WHERE rn = 1;