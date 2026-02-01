-- Platform: Practice SQL / Interview Prep
-- Question: Top 3 Highest Paid Employees per Department
-- Difficulty: Medium
-- Date: 2026-02-01

-- Problem:
-- Identify the top 3 highest-earning employees within each department. 
-- If there are salary ties, the RANK() function should include all 
-- employees tied for the 3rd spot.

-- Approach:
-- 1. Use a CTE (t1) to define the ranking window.
-- 2. Select employee details (Name, ID, Department, Salary).
-- 3. Use RANK() partitioned by Department to reset the count for each group.
-- 4. Order by Salary DESC within each partition to rank from highest to lowest.
-- 5. In the outer query, filter for rnk <= 3 to get the top 3 earners per dept.

-- Concepts:
-- 1. Window Functions (RANK)
-- 2. Partitioning Data (PARTITION BY)
-- 3. Top-N Analysis
-- 4. Common Table Expressions (CTEs)

WITH t1 AS (
  SELECT 
    Name,
    EmployeeID,
    Department,
    Salary,
    RANK() OVER(
      PARTITION BY Department 
      ORDER BY Salary DESC
    ) AS rnk 
  FROM Employees 
)
SELECT * FROM t1 
WHERE rnk <= 3;