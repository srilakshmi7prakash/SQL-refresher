-- Platform: Practice SQL / Interview Prep
-- Question: Deterministic Price Ranking by Sub-Category
-- Difficulty: Easy/Medium
-- Date: 2026-02-03

-- Problem:
-- Rank products by price within their specific sub-category. 
-- In the event of a price tie, use ProductID as a secondary sort 
-- to ensure a consistent and deterministic rank.

-- Approach:
-- 1. Select all columns from the Products table.
-- 2. Use the RANK() window function to assign positions.
-- 3. Partition by SubCategory to reset the ranking for each group.
-- 4. Order by Price DESC to rank expensive items first.
-- 5. Add ProductID DESC as a tie-breaker in the ORDER BY clause.

-- Concepts:
-- 1. Window Functions (RANK)
-- 2. PARTITION BY (Category-based grouping)
-- 3. Multi-column Ordering (Tie-breaking)
-- 4. Deterministic Queries

SELECT 
    *,
    RANK() OVER(
        PARTITION BY SubCategory 
        ORDER BY Price DESC, ProductID DESC
    ) AS price_rnk
FROM Products;