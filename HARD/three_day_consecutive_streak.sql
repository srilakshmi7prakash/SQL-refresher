-- Platform: Practice SQL / Interview Prep
-- Question: Identify 3-Day Consecutive Login Streaks
-- Difficulty: Hard
-- Date: 2026-02-12

-- Problem:
-- Identify users who have logged in for at least three consecutive days.
-- Return the specific date that represents the middle of that 3-day streak.

-- Approach:
-- 1. Use a CTE (t1) to look both "backward" and "forward" for each user.
-- 2. Use LAG() to get the previous login date and LEAD() to get the next.
-- 3. Partition by UserID to ensure we don't compare different users' dates.
-- 4. In the outer query, use DATE_SUB and DATE_ADD to check if the 
--    previous login was exactly 1 day ago AND the next login is exactly 1 day ahead.
-- 5. Use SELECT DISTINCT to handle users who might have multiple login 
--    entries on the same day.

-- Concepts:
-- 1. Dual Window Functions (LAG & LEAD)
-- 2. Date Arithmetic (DATE_SUB, DATE_ADD, INTERVAL)
-- 3. Streak/Gaps and Islands Logic
-- 4. Multi-directional Context

WITH t1 AS ( 
  SELECT *, 
    LAG(LoginDate) OVER(PARTITION BY UserID ORDER BY LoginDate ASC) AS previous_login,
    LEAD(LoginDate) OVER(PARTITION BY UserID ORDER BY LoginDate ASC) AS next_login
  FROM UserLogins
)
SELECT DISTINCT 
  UserID, 
  LoginDate, 
  previous_login, 
  next_login 
FROM t1 
WHERE previous_login = DATE_SUB(LoginDate, INTERVAL 1 DAY)
  AND next_login = DATE_ADD(LoginDate, INTERVAL 1 DAY);