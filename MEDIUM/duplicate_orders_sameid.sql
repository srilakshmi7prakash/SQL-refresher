-- Platform: Practice SQL / Data Cleaning
-- Question: Deduplicate Orders based on Multiple Attributes
-- Difficulty: Medium
-- Date: 2026-05-01



-- Problem
-- Identify and remove duplicate entries from the CustomerOrders table where an order is considered a duplicate if it shares the same customer_id, order_date, and amount. Only the first occurrence (based on the lowest order_id) should be retained.

-- Approach
-- Define Sections: Use PARTITION BY to create logical "sections" (frames) for every unique combination of customer_id, order_date, and amount.

-- Sequence the Rows: Within each section, apply ROW_NUMBER() ordered by order_id. This assigns a 1 to the earliest order and higher numbers to subsequent duplicates.

-- Isolate Originals: Wrap the logic in a Common Table Expression (CTE) to create a temporary result set called sectioned_orders.

-- Filter: Select only the rows where the sequence number equals 1, effectively discarding all "sections" containing duplicate data.

-- Concepts
-- Window Functions (ROW_NUMBER): Assigns a unique sequential integer to rows within a partition.

-- Partitioning: Creating logical boundaries to reset calculations (The "Section" Theory).

-- Common Table Expressions (CTEs): Improving readability by isolating complex window logic before the final selection.

-- Deduplication Logic: Using ranking to identify and filter redundant data.


WITH streak_data AS 

(
SELECT * , DATE_SUB(active_month , INTERVAL ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY active_month ) MONTH ) AS streak FROM UserActivity ),

ordered_activity AS 
(
SELECT user_id , COUNT(*) AS month_streak, streak FROM streak_data GROUP BY  user_id , streak
)

SELECT user_id , MAX(month_streak) AS highest_streak FROM ordered_activity GROUP BY 
user_id ;