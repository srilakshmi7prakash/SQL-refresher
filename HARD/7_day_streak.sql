-- Platform: Practice SQL / Interview Prep
-- Question: Identify 7-Day "Power User" Login Streaks (Gaps & Islands)
-- Difficulty: Hard
-- Date: 2026-02-13

-- Problem:
-- Find users who have logged in for at least 7 consecutive days. 
-- Unlike a simple 3-day check, this must account for streaks of any 
-- length by grouping consecutive dates together.

-- Approach:
-- 1. Use a CTE (t1) to create a "grouping anchor."
-- 2. Use ROW_NUMBER() to create a sequential count for each user's logins.
-- 3. Subtract that row number (as a day interval) from the LoginDate. 
--    *Logic: If dates are consecutive, the date and the row number 
--    increase at the same rate, making the resulting 'calc' date 
--    identical for the whole streak.*
-- 4. In the outer query, GROUP BY the UserID and this 'calc' anchor.
-- 5. Use HAVING COUNT(*) >= 7 to filter for streaks of a week or longer.

-- Concepts:
-- 1. Gaps and Islands Problem
-- 2. ROW_NUMBER() Window Function
-- 3. Date Math as a Grouping Tool
-- 4. Advanced Aggregation

WITH t1 AS 
( SELECT *, 
 DATE_SUB(LoginDate, INTERVAL ROW_NUMBER()OVER(PARTITION BY UserID ORDER BY LoginDate asc) DAY) as streak
 FROM UserActivity
)

SELECT UserID,count(*) as streak_length FROM t1 GROUP BY UserID,streak HAVING count(*)  >=7;


