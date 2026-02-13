-- Platform: Practice SQL / Interview Prep
-- Question: Tracking Product Price Fluctuations
-- Difficulty: Medium/Hard
-- Date: 2026-02-12

-- Problem:
-- For each product, retrieve the current price, the previous price 
-- from the last recorded date, and calculate the exact dollar 
-- difference between the two.

-- Approach:
-- 1. Use the LAG() window function to pull the 'Price' from the 
--    immediately preceding row.
-- 2. PARTITION BY ProductID to ensure price comparisons stay within 
--    the same item history.
-- 3. ORDER BY PriceDate ASC to ensure the "previous" row is 
--    chronologically correct.
-- 4. Subtract the result of the LAG() function from the current 'Price' 
--    to calculate the 'Price_difference'.

-- Concepts:
-- 1. Window Functions (LAG)
-- 2. Inline Arithmetic with Window Functions
-- 3. Time-Series Delta Calculation
-- 4. Partitioned Sequencing

SELECT 
    *,
    LAG(Price) OVER(
        PARTITION BY ProductID 
        ORDER BY PriceDate ASC
    ) AS Previous_Price,
    (Price - LAG(Price) OVER(
        PARTITION BY ProductID 
        ORDER BY PriceDate ASC
    )) AS Price_difference
FROM ProductPriceHistory;