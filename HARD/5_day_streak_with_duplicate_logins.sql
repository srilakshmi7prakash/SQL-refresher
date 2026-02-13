-- Platform: Practice SQL / Interview Prep
-- Question: Robust 5-Day Streak Detection (Handling Duplicates)
-- Difficulty: Expert
-- Date: 2026-02-13

-- Problem:
-- Find users with a 5-day login streak, ensuring that multiple logins 
-- on the same day are only counted once.

-- Approach:
-- 1. CTE (t1): De-duplicate the data. Use DISTINCT to get unique 
--    UserID/LoginDate pairs.
-- 2. CTE (t2): Apply the "Gaps and Islands" anchor logic. 
--    (Date - RowNumber) identifies consecutive blocks.
-- 3. Outer Query: Group by the UserID and the streak anchor. 
--    Filter for counts >= 5.

-- Concepts:
-- 1. Data De-duplication (SELECT DISTINCT)
-- 2. Gaps and Islands (ROW_NUMBER Subtraction)
-- 3. Layered CTEs
-- 4. Defensive SQL Programming

WITH t1 AS ( 
  SELECT DISTINCT LoginDate, UserID 
  FROM UserLogins
),
t2 AS ( 
  SELECT *, 
    DATE_SUB(LoginDate, INTERVAL ROW_NUMBER() OVER(PARTITION BY UserID ORDER BY LoginDate ASC) DAY) AS streak
  FROM t1
)
SELECT 
  COUNT(*) AS Days_In_Streak, 
  UserID 
FROM t2 
GROUP BY UserID, streak 
HAVING COUNT(*) >= 5;