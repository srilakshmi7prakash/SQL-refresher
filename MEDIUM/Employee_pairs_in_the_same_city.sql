-- Platform: Practice SQL / Interview Prep
-- Question: Identify Employee Pairs in the Same City
-- Difficulty: Medium
-- Date: 2026-02-14

-- Problem:
-- Find all unique pairs of employees who live in the same city.

-- Approach:
-- 1. Perform a SELF JOIN on the Employees table by aliasing it twice (e1 and e2).
-- 2. Use the condition e1.City = e2.City to find the commonality.
-- 3. Use the inequality e1.EmployeeID < e2.EmployeeID to ensure:
--    a) An employee is not paired with themselves (e1.ID != e2.ID).
--    b) We don't get duplicate reciprocal pairs 
--       (e.g., if we have Alice & Bob, we don't also need Bob & Alice).

-- Concepts:
-- 1. Self-Joins
-- 2. Table Aliasing
-- 3. Non-Equi Joins (using < instead of =)
-- 4. Combinatorial Logic

SELECT 
    e1.EmployeeName AS Employee_A,
    e2.EmployeeName AS Employee_B,
    e1.City
FROM Employees e1 
JOIN Employees e2 ON e1.City = e2.City
WHERE e1.EmployeeID < e2.EmployeeID;