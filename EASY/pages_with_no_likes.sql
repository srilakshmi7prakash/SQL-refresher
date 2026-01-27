-- Platform: DataLemur
-- Question: Page With No Likes
-- Difficulty: Easy
-- Date: 2026-01-26

-- Problem:
-- Identify pages that do not have any likes.

-- Approach:
-- 1. Use LEFT JOIN to keep all records from pages.
-- 2. Join with page_likes on page_id.
-- 3. Filter rows where no matching like exists (NULL check).

-- Concepts:
-- LEFT JOIN, Anti-Join Pattern, NULL Filterin


SELECT pg.page_id, pg.page_name ,
pl.user_id, pl.liked_date
FROM pages pg
LEFT JOIN page_likes pl
ON pg.page_id = pl.page_id
WHERE pl.page_id IS NULL;