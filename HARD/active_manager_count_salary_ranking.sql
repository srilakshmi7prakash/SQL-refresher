-- Platform: Practice SQL / Interview Prep
-- Question: Active Manager Count & Salary Ranking
-- Difficulty: Hard
-- Date: 2026-02-10

-- Problem:
-- 1. For every employee, identify how many 'Active' colleagues share their Manager.
-- 2. Rank employees by Salary within their manager's team.
-- 3. Filter the results to only show teams that have more than one active member.

-- Approach:
-- 1. Use a CTE (t1) to calculate team-based metrics without losing row granularity.
-- 2. Use a conditional COUNT(CASE...) window function to count only 'Active' 
--    employees per ManagerID. 
--    (Note: Using NULL in ELSE ensures the count only increments for 'Active' rows).
-- 3. Use RANK() partitioned by ManagerID to see where each employee stands 
--    financially compared to their immediate peers.
-- 4. In the outer query, filter for Manager_Active_Count > 1 to exclude 
--    isolated or inactive teams.

-- Concepts:
-- 1. Conditional Window Counting
-- 2. Multi-Window Partitioning
-- 3. Filtered Aggregate Logic (CASE inside COUNT)
-- 4. Rank-based Team Analysis

WITH t1 AS (
  SELECT 
    EmployeeID, 
    Salary, 
    ManagerID,
    Status,
    COUNT(CASE WHEN Status = 'Active' THEN 1 ELSE NULL END) 
      OVER(PARTITION BY ManagerID) AS Manager_Active_Count,
    RANK() OVER(
      PARTITION BY ManagerID 
      ORDER BY Salary DESC
    ) AS Salary_Rank_In_Dept
  FROM EmployeeLog
)
SELECT * FROM t1 
WHERE Manager_Active_Count > 1;