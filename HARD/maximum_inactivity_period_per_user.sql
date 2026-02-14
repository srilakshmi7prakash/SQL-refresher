-- Platform: Practice SQL / Interview Prep
-- Question: Maximum Inactivity Period per User
-- Difficulty: Medium/Hard
-- Date: 2026-02-14

-- Problem:
-- For each user, find the longest period of time (in days) between 
-- two consecutive login events.

-- Approach:
-- 1. Use a CTE (ranked_logins) to look ahead at the next login event.
-- 2. Use the LEAD() window function to pull the date of the 
--    following login for each specific user.
-- 3. In the outer query, use DATEDIFF() to calculate the distance 
--    between the current login and the next one.
-- 4. Aggregate with MAX() and GROUP BY UserID to isolate the single 
--    largest gap for every individual.

-- Concepts:
-- 1. Window Functions (LEAD)
-- 2. Date Differencing (DATEDIFF)
-- 3. Aggregating Window Results
-- 4. Churn/Retention Analysis

WITH ranked_logins AS ( 
  SELECT 
    *,
    LEAD(LoginDate) OVER(PARTITION BY UserID ORDER BY LoginDate ASC) AS next_login_date
  FROM UserLogins
)
SELECT 
  UserID, 
  MAX(DATEDIFF(next_login_date, LoginDate)) AS max_diff 
FROM ranked_logins 
GROUP BY UserID;