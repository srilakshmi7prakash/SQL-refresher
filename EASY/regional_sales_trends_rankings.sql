-- Platform: Practice SQL / Interview Prep
-- Question: Regional Sales Trends and Rankings
-- Difficulty: Medium/Hard
-- Date: 2026-02-03

-- Problem:
-- For each sales record, calculate two metrics:
-- 1. A running total of sales within each region over time.
-- 2. A rank of the sale amount compared to other sales in that same region.

-- Approach:
-- 1. Create a CTE (t1) to calculate the cumulative sum (ColumnA).
-- 2. Partition by Region and order by SaleDate ASC to create the running total.
-- 3. In the outer query, use the results of the CTE to apply a second window function.
-- 4. Use RANK() partitioned by Region and ordered by SaleAmount DESC to identify 
--    the highest-value sales (ColumnB).

-- Concepts:
-- 1. Nested Window Functions
-- 2. Running Totals (SUM() OVER)
-- 3. Ranking (RANK() OVER)
-- 4. Common Table Expressions (CTEs)
-- 5. Multi-stage Data Transformation

WITH t1 AS (
  SELECT 
    *, 
    SUM(SaleAmount) OVER(
      PARTITION BY Region 
      ORDER BY SaleDate ASC
    ) AS ColumnA 
  FROM Sales
)
SELECT 
  *,
  RANK() OVER(
    PARTITION BY Region 
    ORDER BY SaleAmount DESC
  ) AS ColumnB
FROM t1;