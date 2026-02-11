-- Platform: Practice SQL / Interview Prep
-- Question: Daily Category Leaders in Competitive Markets
-- Difficulty: Hard
-- Date: 2026-02-11

-- Problem:
-- 1. Identify the highest-grossing product for each category every day.
-- 2. Only include categories that had at least 2 different products sold 
--    on that day (to ensure we are looking at "competitive" wins).
-- 3. Maintain product visibility even if sales data is missing.

-- Approach:
-- 1. Use a CTE (t1) to combine product names with daily sales volume.
-- 2. Use a Window Function COUNT(ProductID) partitioned by Date and Category 
--    to determine how many unique products were active in that group.
-- 3. Use RANK() partitioned by Category and Date, ordered by Revenue DESC 
--    to find the daily winner.
-- 4. In the outer query, filter for rnk = 1 (the winner) and 
--    distinct_products >= 2 (the competition threshold).

-- Concepts:
-- 1. Window Function Aggregates (COUNT OVER)
-- 2. Ranking in Subgroups (RANK OVER)
-- 3. Multi-Level Partitioning
-- 4. LEFT JOIN for Data Integrity

WITH t1 AS (
  SELECT 
    ds.SaleDate, 
    p.ProductName, 
    p.Category,
    ds.Revenue,
    COUNT(ds.ProductID) OVER(
      PARTITION BY ds.SaleDate, p.Category
    ) AS distinct_products,
    RANK() OVER(
      PARTITION BY p.Category, ds.SaleDate 
      ORDER BY ds.Revenue DESC
    ) AS rnk
  FROM Products p 
  LEFT JOIN DailySales ds ON p.ProductID = ds.ProductID
)
SELECT * FROM t1 
WHERE rnk = 1 
  AND distinct_products >= 2;