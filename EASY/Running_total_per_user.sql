-- Platform: Practice SQL / Interview Prep
-- Question: Calculate Running Total per User
-- Difficulty: Medium
-- Date: 2026-02-02

-- Problem:
-- Calculate a cumulative sum of transaction amounts for each user, 
-- ordered chronologically (or by TransactionID), so that each row 
-- shows the total balance up to that point.

-- Approach:
-- 1. Select all columns from the Transactions table.
-- 2. Use the SUM() aggregate function as a window function.
-- 3. Apply PARTITION BY UserID to ensure the running total resets for each new user.
-- 4. Apply ORDER BY TransactionID to define the sequence in which the values are added.
-- 5. The windowing clause defaults to "RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW".

-- Concepts:
-- 1. Window Functions (SUM)
-- 2. Running Totals / Cumulative Aggregates
-- 3. PARTITION BY
-- 4. Window Framing (Implicit)

SELECT 
    *,
    SUM(Amount) OVER(
        PARTITION BY UserID 
        ORDER BY TransactionID ASC
    ) AS Running_total
FROM Transactions;