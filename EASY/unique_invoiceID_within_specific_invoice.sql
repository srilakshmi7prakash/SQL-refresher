-- Platform: Practice SQL / Interview Prep
-- Question: Generate Unique Item ID per Invoice
-- Difficulty: Easy/Medium
-- Date: 2026-02-01

-- Problem:
-- Assign a unique sequence number (UID) to each item within an invoice. 
-- The numbering should restart for each new InvoiceID and be ordered 
-- alphabetically by the ItemName.

-- Approach:
-- 1. Select all columns from the InvoiceItems table.
-- 2. Use the ROW_NUMBER() window function to generate a unique sequence.
-- 3. Apply PARTITION BY InvoiceID to reset the counter for every unique invoice.
-- 4. Apply ORDER BY ItemName to ensure the sequence follows alphabetical order.

-- Concepts:
-- 1. Window Functions
-- 2. ROW_NUMBER()
-- 3. PARTITION BY (Logical Grouping)
-- 4. ORDER BY (In-window sorting)

SELECT 
    *,
    ROW_NUMBER() OVER(
        PARTITION BY InvoiceiD 
        ORDER BY ItemName
    ) AS UID
FROM InvoiceItems;