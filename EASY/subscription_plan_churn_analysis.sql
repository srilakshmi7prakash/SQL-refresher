-- Platform: Practice SQL / Interview Prep
-- Question: Predict Next Subscription Plan (Churn Analysis)
-- Difficulty: Medium
-- Date: 2026-02-05

-- Problem:
-- Track the progression of user subscription plans over time. For each 
-- subscription record, identify the next plan the user upgraded or 
-- downgraded to. If there is no subsequent plan, mark the user as 'CHURNED'.

-- Approach:
-- 1. Select all columns from the Subscriptions table.
-- 2. Use the LEAD() window function to look at the 'PlanName' in the following row.
-- 3. Set the offset to 1 to capture the immediate next change.
-- 4. Provide 'CHURNED' as the default value to handle the final record for each user.
-- 5. Use PARTITION BY UserID to ensure we only look at plan changes for the same person.
-- 6. Use ORDER BY ChangeDate ASC to move forward through the user's timeline.

-- Concepts:
-- 1. Window Functions (LEAD)
-- 2. Partitioning Data (PARTITION BY)
-- 3. Lead/Lag Default Values
-- 4. Customer Churn Identification

SELECT 
    *,
    LEAD(PlanName, 1, 'CHURNED') OVER(
        PARTITION BY UserID 
        ORDER BY ChangeDate ASC
    ) AS Next_Plan
FROM Subscriptions;