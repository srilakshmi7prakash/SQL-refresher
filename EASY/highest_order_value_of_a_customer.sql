-- Platform: Practice SQL / Interview Prep
-- Question: Highest Single Order per Customer
-- Difficulty: Medium
-- Date: 2026-02-01

-- Problem:
-- For each customer, identify their highest value order(s). 
-- If a customer has multiple orders tied for the same maximum value, 
-- return all of them.

-- Approach:
-- 1. Use a CTE to calculate ranks without losing individual row detail.
-- 2. Apply the RANK() window function to the order_value.
-- 3. Use PARTITION BY customer_id to ensure the ranking resets for every customer.
-- 4. Use ORDER BY order_value DESC to assign rank 1 to the largest amount.
-- 5. In the outer query, filter for rnk = 1 to retrieve the top order(s) per person.

-- Concepts:
-- 1. Common Table Expressions (CTEs)
-- 2. Window Functions (RANK)
-- 3. Data Partitioning (PARTITION BY)
-- 4. Subqueries/CTE Filtering

WITH t AS (
  SELECT 
    customer_id,
    order_value,
    RANK() OVER(
      PARTITION BY customer_id 
      ORDER BY order_value DESC
    ) AS rnk
  FROM orders 
)
SELECT 
  customer_id, 
  order_value 
FROM t 
WHERE rnk = 1;