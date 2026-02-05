-- Platform: Practice SQL / Interview Prep
-- Question: Find Previous Login Date per User
-- Difficulty: Medium
-- Date: 2026-02-04

-- Problem:
-- For each user, retrieve their current login date and the date of their 
-- immediate previous login. This is often used to calculate "days since last login."

-- Approach:
-- 1. Use a CTE (t1) with SELECT DISTINCT to remove any duplicate login entries 
--    for the same user on the same day.
-- 2. Use the LAG() window function to access the LoginDate from the preceding row.
-- 3. Partition by UserID so that the "previous date" stays within that specific user's history.
-- 4. Order by LoginDate ASC to ensure the lag looks at the chronologically previous event.
-- 5. Provide a default value (0) for the first login of each user where no previous record exists.

-- Concepts:
-- 1. Window Functions (LAG)
-- 2. Time-Series Analysis
-- 3. Data De-duplication (DISTINCT)
-- 4. PARTITION BY & ORDER BY

WITH t1 AS ( 
  SELECT DISTINCT 
    UserID, 
    LoginDate
  FROM UserLogins
)
SELECT 
  UserID, 
  LoginDate,
  LAG(LoginDate, 1, 0) OVER(
    PARTITION BY UserID 
    ORDER BY LoginDate ASC, UserID ASC
  ) AS previous_login 
FROM t1;