-- Platform: Practice SQL / Interview Prep
-- Question: Identify Recent Below-Average Transactions
-- Difficulty: Medium/Hard
-- Date: 2026-02-10

-- Problem:
-- For each user, determine if their most recent transaction was less than 
-- or equal to their overall average transaction amount. This can be used 
-- to flag potential "cooling off" in customer spending.

-- Approach:
-- 1. Use a CTE (t1) to calculate two window functions simultaneously.
-- 2. Use AVG(Amount) OVER(PARTITION BY UserID) to get the historical average 
--    for each user without collapsing rows.
-- 3. Use RANK() partitioned by UserID and ordered by TransactionDate DESC 
--    to identify the most recent transaction as rank 1.
-- 4. In the outer query, filter for latest_transaction = 1 to isolate the 
--    most recent event.
-- 5. Add a secondary filter (Amount <= Average) to find cases where that 
--    recent spend didn't meet their usual average.

-- Concepts:
-- 1. Window Functions (AVG, RANK)
-- 2. Comparing Row Values to Aggregates
-- 3. Common Table Expressions (CTEs)
-- 4. Filtering on Multiple Window Results

WITH t1 AS (
  SELECT 
    *,
    AVG(Amount) OVER(PARTITION BY UserID) AS Average,
    RANK() OVER(
      PARTITION BY UserID 
      ORDER BY TransactionDate DESC
    ) AS latest_transaction
  FROM Transactions
)
SELECT 
  * FROM t1
WHERE latest_transaction = 1 
  AND Amount <= Average;