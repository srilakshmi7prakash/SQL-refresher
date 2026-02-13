-- Platform: Practice SQL / Interview Prep
-- Question: Top 3 Most Expensive Products per Category
-- Difficulty: Medium
-- Date: 2026-02-13

-- Problem:
-- For each product category, identify the top 3 most expensive products.
-- Ensure that ties in price do not skip ranking positions.

-- Approach:
-- 1. Use a CTE (ranked_products) to assign a rank to each product.
-- 2. Apply DENSE_RANK() partitioned by CategoryName.
-- 3. Order by Price DESC so that the most expensive item receives rank 1.
-- 4. In the outer query, filter for ranks 1, 2, and 3.

-- Concepts:
-- 1. Window Functions (DENSE_RANK)
-- 2. Ranking with Ties
-- 3. Top-N Filtering
-- 4. Partitioning by Category

WITH ranked_products AS (
  SELECT 
    *,
    DENSE_RANK() OVER(
      PARTITION BY CategoryName 
      ORDER BY Price DESC
    ) AS product_rnk
  FROM Products
)
SELECT 
  * FROM ranked_products 
WHERE product_rnk <= 3; 