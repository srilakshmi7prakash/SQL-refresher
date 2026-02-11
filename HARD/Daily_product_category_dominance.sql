-- Platform: Practice SQL / Interview Prep
-- Question: Daily Product Category Dominance
-- Difficulty: Hard
-- Date: 2026-02-11

-- Problem:
-- 1. Calculate the percentage of total daily category revenue contributed 
--    by each individual product.
-- 2. Identify "Dominant Products"—those that represent 50% or more 
--    of their category's total sales on any given day.
-- 3. Ensure products with no sales are handled correctly via a LEFT JOIN.

-- Approach:
-- 1. Use a CTE (t1) to join the Products table with DailySales.
-- 2. Apply a Window Function SUM(Revenue) partitioned by both Category 
--    and SaleDate to get the total daily "pot" for that category.
-- 3. Calculate the percentage: (Product Revenue / Category Total) * 100.
-- 4. Use ROUND(..., 2) for clean reporting and multiply by 1.0 to ensure 
--    floating-point precision.
-- 5. In the outer query, filter for percentages >= 50 and remove NULLs 
--    (products with no sales that day).

-- Concepts:
-- 1. Left Joins
-- 2. Multi-column Partitioning (PARTITION BY Category, SaleDate)
-- 3. Window Aggregates
-- 4. Percentage of Total Calculations
-- 5. Data Filtering & NULL Handling

WITH t1 AS (
  SELECT 
    ds.SaleDate, 
    p.ProductName, 
    p.Category,
    ds.Revenue,
    ROUND(
      (ds.Revenue * 1.0 / SUM(ds.Revenue) OVER(PARTITION BY p.Category, ds.SaleDate)) * 100, 
      2
    ) AS Category_sales_percentage
  FROM Products p 
  LEFT JOIN DailySales ds ON p.ProductID = ds.ProductID
)
SELECT * FROM t1 
WHERE Category_sales_percentage >= 50 
  AND Category_sales_percentage IS NOT NULL;