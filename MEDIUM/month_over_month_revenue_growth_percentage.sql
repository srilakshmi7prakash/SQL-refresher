-- Platform: Practice SQL / Interview Prep
-- Question: Month-over-Month Revenue Growth Percentage
-- Difficulty: Medium/Hard
-- Date: 2026-02-13

-- Problem:
-- Calculate the percentage change in revenue compared to the 
-- previous month to track business growth or decline.

-- Approach:
-- 1. Use a CTE (previous_month_calc) to fetch the prior month's 
--    revenue using the LAG() window function.
-- 2. Ensure chronological order using ORDER BY SaleMonth ASC.
-- 3. In the outer query, apply the growth formula: 
--    ((Current - Previous) / Previous) * 100.
-- 4. Use * 1.0 to ensure decimal precision and ROUND() for 
--    cleaner presentation.

-- Concepts:
-- 1. Time-series Analysis
-- 2. Window Functions (LAG)
-- 3. Percentage Growth Formula
-- 4. Arithmetic with Window Results

WITH previous_month_calc AS ( 
  SELECT 
    *, 
    LAG(TotalRevenue) OVER(ORDER BY SaleMonth ASC) AS previous_month_revenue
  FROM MonthlySales
)
SELECT 
  *,  
  ROUND(
    ((TotalRevenue - previous_month_revenue) * 1.0 / NULLIF(previous_month_revenue, 0)) * 100, 
    2
  ) AS growth_percentage
FROM previous_month_calc;