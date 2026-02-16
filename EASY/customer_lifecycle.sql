-- Platform: Practice SQL / Interview Prep
-- Question: Customer Lifecycle (First vs. Last Purchase)
-- Difficulty: Easy/Medium
-- Date: 2026-02-16

-- Problem:
-- For each customer, identify their "Start Date" (first order) 
-- and their "Most Recent Activity" (last order).

-- Approach:
-- 1. Aggregate the CustomerOrders table using GROUP BY CustomerID.
-- 2. Use the MIN() aggregate function on OrderDate to find the earliest date.
-- 3. Use the MAX() aggregate function on OrderDate to find the latest date.

-- Concepts:
-- 1. Basic Aggregation
-- 2. Date Ranges
-- 3. Customer Retention Basics
-- 4. Grouping logic

SELECT 
    CustomerID, 
    MIN(OrderDate) AS First_Purchase, 
    MAX(OrderDate) AS Last_Purchase
FROM CustomerOrders 
GROUP BY CustomerID;