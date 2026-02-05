-- Platform: Practice SQL / Interview Prep
-- Question: Compare Monthly Revenue to Previous Month
-- Difficulty: Easy/Medium
-- Date: 2026-02-06

-- Problem:
-- Retrieve monthly revenue data along with the revenue from the previous month.
-- For the first available month (where no previous data exists), the current 
-- month's revenue should be used as the default value.

-- Approach:
-- 1. Select all columns from the MonthlyRevenue table.
-- 2. Use the LAG() window function to access the Revenue from the preceding row.
-- 3. Set the offset to 1 to look back exactly one month.
-- 4. Set the default value to Revenue so that the first row of the result set 
--    shows its own revenue instead of NULL.
-- 5. Order by Month ASC to ensure the lag function follows a chronological sequence.

-- Concepts:
-- 1. Window Functions (LAG)
-- 2. Handling NULLs in Window Functions (Default Values)
-- 3. Chronological Sequencing
-- 4. Trend Analysis

SELECT 
    *,
    LAG(Revenue, 1, Revenue) OVER(
        ORDER BY Month ASC
    ) AS Previous_Month_Revenue
FROM MonthlyRevenue;