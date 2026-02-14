-- Platform: Practice SQL / Interview Prep
-- Question: Employees Out-earning Their Managers
-- Difficulty: Medium/Hard
-- Date: 2026-02-14

-- Problem:
-- Identify employees whose salary is higher than the salary 
-- of the manager they report to.

-- Approach:
-- 1. Perform a SELF JOIN on the EmployeeSalaries table.
-- 2. Alias the first instance as 'es1' (the Employees) and the 
--    second as 'es2' (the Managers).
-- 3. Link them where the Employee's ManagerID matches the Manager's EmployeeID.
-- 4. Filter the results to only include rows where the Employee Salary 
--    is greater than the Manager Salary.

-- Concepts:
-- 1. Self-Joins (Parent-Child relationships)
-- 2. Hierarchical Data Traversal
-- 3. Logical Comparison across joined rows

SELECT 
    es1.EmployeeID AS Employee_ID,
    es1.Salary AS Employee_Salary,
    es2.EmployeeID AS Manager_ID,
    es2.Salary AS Manager_Salary
FROM EmployeeSalaries es1 
JOIN EmployeeSalaries es2 ON es1.ManagerID = es2.EmployeeID 
WHERE es1.Salary > es2.Salary;