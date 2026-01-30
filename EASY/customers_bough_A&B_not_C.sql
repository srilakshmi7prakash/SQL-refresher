-- Platform: Practice SQL / Interview Prep
-- Question: Customers Who Bought A and B but Not C
-- Difficulty: Easy–Medium
-- Date: 2026-01-29

-- Problem:

-- Find customers who have purchased both Product A and Product B, but have not purchased Product C.

-- Approach:

-- 1. Identify customers who purchased Product C using a subquery.

-- 2. Exclude those customers using NOT IN.

-- 3. Identify customers who purchased Product A using a subquery.

-- 4. Ensure they are included using IN.

-- 5. Identify customers who purchased Product B using another subquery.

-- 6. Return customers who satisfy all three conditions.

-- Concepts:

-- 1. Subqueries

-- 2. IN and NOT IN

-- 3. Filtering with Multiple Conditions

-- 4. Set-Based Logic



SELECT * FROM customer_purchases
WHERE customer_name 
     NOT IN
    (SELECT customer_name FROM 
    customer_purchases WHERE 
    product = 'C')
    
    AND customer_name  
     IN
    (SELECT customer_name FROM 
    customer_purchases WHERE 
    product = 'A')
    
        AND customer_name  
        IN
    (SELECT customer_name FROM 
    customer_purchases WHERE 
    product = 'B')

  
