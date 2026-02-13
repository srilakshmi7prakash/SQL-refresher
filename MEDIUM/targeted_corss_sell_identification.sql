-- Platform: Practice SQL / Interview Prep
-- Question: Targeted Cross-Sell Identification
-- Difficulty: Medium
-- Date: 2026-02-13

-- Problem:
-- Identify users who have purchased a "Laptop" but have never 
-- purchased a "Mouse". This helps in creating a marketing list 
-- for accessory promotions.

-- Approach:
-- 1. Use a CTE (product_count) to aggregate purchase behavior at the User level.
-- 2. Use "Pivot-style" conditional aggregation: SUM(CASE WHEN...) to count 
--    specific product occurrences for each user.
-- 3. In the outer query, filter for users where the Laptop count is at least 1 
--    and the Mouse count is exactly 0.

-- Concepts:
-- 1. Conditional Aggregation (CASE WHEN inside SUM)
-- 2. Pivoting Rows to Columns
-- 3. Behavioral Filtering (Existence vs. Non-existence)
-- 4. Target Audience Segmentation

WITH product_count AS (
  SELECT 
    UserID,
    SUM(CASE WHEN ProductName = 'Laptop' THEN 1 ELSE 0 END) AS lap_count,
    SUM(CASE WHEN ProductName = 'Mouse' THEN 1 ELSE 0 END) AS mouse_count
  FROM Orders 
  GROUP BY UserID
)
SELECT 
  * FROM product_count 
WHERE lap_count >= 1 
  AND mouse_count = 0;