USE CATALOG bankingpoc;

-- =============================================================================
-- 1. EXECUTIVE KPI SUMMARY
-- =============================================================================
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(total_deposit_balance) AS total_deposits,
    SUM(total_loan_amount) AS total_loan_exposure,
    SUM(total_loan_amount - total_loan_paid_amount) AS total_outstanding_risk,
    SUM(total_transaction_volume) AS cumulative_transaction_volume
FROM gold.customer_360;

-- =============================================================================
-- 2. LOAN PRODUCT RISK EXPOSURE
-- =============================================================================
SELECT 
    loan_type,
    loan_status,
    total_loans_issued,
    total_disbursed_amount,
    total_recovered_amount,
    total_outstanding_amount,
    ROUND((total_recovered_amount / NULLIF(total_disbursed_amount, 0)) * 100, 2) AS recovery_rate_pct
FROM gold.loan_summary
ORDER BY total_disbursed_amount DESC;

-- =============================================================================
-- 3. BRANCH TRANSACTION VELOCITY
-- =============================================================================
SELECT 
    transaction_day,
    branch_name,
    city,
    transaction_type,
    transaction_count,
    total_amount
FROM gold.transaction_summary
ORDER BY transaction_day ASC, total_amount DESC;