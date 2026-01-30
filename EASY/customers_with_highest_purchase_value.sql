-- Platform: Practice SQL / Interview Prep
-- Question: Top Customer by Total Order Value
-- Difficulty: Medium
-- Date: 2026-01-29

-- Problem:
-- Find the customer(s) who have the highest total order value
-- based on all their purchases.

-- Approach:
-- 1. Use a CTE to aggregate order values by customer_id.
-- 2. Calculate total order value using SUM(order_value).
-- 3. Store aggregated results in the first CTE.
-- 4. Use a second CTE to apply ranking.
-- 5. Rank customers by total order value in descending order.
-- 6. Filter customers with rank = 1.

-- Concepts:
-- 1. Common Table Expressions (CTEs)
-- 2. Aggregation using SUM()
-- 3. GROUP BY
-- 4. Window Functions (RANK)
-- 5. Analytical Queries
-- 6. Ranking and Ordering


WITH CTE AS (
  SELECT customer_id,
         SUM(order_value) AS value_customer
  FROM orders
  GROUP BY customer_id
),

CTE2 AS (
  SELECT customer_id,
         value_customer,
         RANK() OVER (ORDER BY value_customer DESC) AS rnk
  FROM CTE
)

SELECT customer_id,
       value_customer
FROM CTE2
WHERE rnk = 1;
