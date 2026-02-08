-- Platform: Practice SQL / Interview Prep
-- Question: Identify High-Value Multi-Category Customers
-- Difficulty: Medium
-- Date: 2026-02-08

-- Problem:
-- Identify "VIP" users who meet two specific criteria:
-- 1. They have spent a total of $500 or more.
-- 2. They have purchased items from at least 3 different product categories.

-- Approach:
-- 1. Use GROUP BY UserID to aggregate data at the individual customer level.
-- 2. Use SUM(Price) to calculate the total lifetime spend per user.
-- 3. Use COUNT(DISTINCT ProductCategory) to find the variety of their purchases.
-- 4. Use the HAVING clause to apply filters to these aggregated results.
-- 5. Filter for a sum >= 500 AND a count >= 3.

-- Concepts:
-- 1. Aggregation (SUM, COUNT DISTINCT)
-- 2. GROUP BY Clause
-- 3. HAVING Clause (Filtering Aggregates)
-- 4. Customer Segmentation

SELECT 
    UserID, 
    SUM(Price) AS Total_Spend, 
    COUNT(DISTINCT ProductCategory) AS Unique_Categories
FROM Sales 
GROUP BY UserID
HAVING SUM(Price) >= 500 
   AND COUNT(DISTINCT ProductCategory) >= 3;