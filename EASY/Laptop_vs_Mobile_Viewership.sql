-- Platform: DataLemur
-- Question: Laptop vs Mobile Viewership
-- Difficulty: Easy
-- Date: 2026-01-27

-- Problem:
-- Calculate the total viewership for laptops and mobile devices,
-- where mobile viewership is defined as the sum of tablet and phone views.

-- Approach:
-- 1. Use conditional aggregation to count rows for each device category.
-- 2. Treat 'laptop' as one category.
-- 3. Treat 'tablet' and 'phone' combined as the mobile category.
-- 4. Sum 1 for each matching row using CASE inside SUM.

-- Concepts:
-- Conditional Aggregation, SUM with CASE, Device Categorization


SELECT 
 SUM(
   CASE 
     WHEN device_type IN ('phone','tablet')
     THEN 1
     ELSE 0 
   END 
 ) AS mobile_views,
 SUM(
  CASE 
    WHEN device_type = 'laptop'
    THEN 1
    ELSE 0
  END 
  )AS laptop_views
FROM viewership;