-- Platform: Practice SQL / Interview Prep
-- Question: Calculate Stock Price Percentage Change
-- Difficulty: Medium/Hard
-- Date: 2026-02-05

-- Problem:
-- For each stock ticker, calculate the percentage change in price 
-- compared to its previous recorded price point in chronological order.

-- Approach:
-- 1. Use a CTE (t1) to retrieve the current price and the price from 
--    the immediate previous row using the LAG() function.
-- 2. Partition by Ticker to ensure price comparisons only happen 
--    within the same stock symbol.
-- 3. Order by PriceTime ASC to ensure we are comparing a price to 
--    the one that came right before it in time.
-- 4. In the outer query, apply the percentage change formula: 
--    ((Current - Previous) / Previous) * 100.

-- Concepts:
-- 1. Window Functions (LAG)
-- 2. Financial Calculations (Percentage Change)
-- 3. Common Table Expressions (CTEs)
-- 4. Chronological Data Sequencing

WITH t1 AS (
  SELECT 
    *, 
    LAG(Price) OVER(
      PARTITION BY Ticker 
      ORDER BY PriceTime ASC 
    ) AS Previous_Price 
  FROM StockPrices
)
SELECT 
  *,
  ((Price - Previous_Price) / Previous_Price) * 100 AS Price_Diff
FROM t1;