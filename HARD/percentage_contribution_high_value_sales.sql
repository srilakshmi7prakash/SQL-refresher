-- Platform: Practice SQL / Interview Prep
-- Question: Percentage Contribution to High-Value Department Sales
-- Difficulty: Hard
-- Date: 2026-02-10

-- Problem:
-- 1. Calculate a "Department Total" that only includes sales greater than $1000.
-- 2. Determine what percentage each individual sale contributes to that 
--    specific high-value departmental total.
-- 3. Handle potential division-by-zero errors for departments with no high-value sales.

-- Approach:
-- 1. Use a CTE (t1) to perform conditional window aggregation.
-- 2. Use CASE WHEN inside a SUM() OVER() to only add SaleAmount to the total 
--    if it exceeds $1000.
-- 3. Partition by Department to keep totals localized.
-- 4. In the outer query, divide the individual SaleAmount by the Dept_total_sales.
-- 5. Use NULLIF(..., 0) to return a NULL instead of an error if the total is zero.
-- 6. Multiply by 100.0 (using a decimal to ensure float division) for the percentage.

-- Concepts:
-- 1. Conditional Aggregation (CASE WHEN inside SUM)
-- 2. Window Functions (SUM OVER)
-- 3. NULLIF for Error Handling
-- 4. Percentage Calculation & Floating Point Math

WITH t1 AS (
  SELECT 
    *, 
    SUM(CASE WHEN SaleAmount > 1000 THEN SaleAmount ELSE 0 END) 
      OVER(PARTITION BY Department) AS Dept_total_sales
  FROM EmployeeSales
)
SELECT 
  *,
 ROUND(((SaleAmount * 1.0/ NULLIF(Dept_total_sales, 0)) * 100),2 ) AS Percentage_Of_Dept 
FROM t1;