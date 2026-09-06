USE CATALOG bankingpoc;

-- =============================================================================
-- 1. QUARANTINE DATA PATTERN (Data Quality Gate)
-- =============================================================================
CREATE TABLE IF NOT EXISTS silver.quarantine_records (
    quarantine_id BIGINT GENERATED ALWAYS AS IDENTITY,
    source_table STRING,
    record_identifier STRING,
    rejection_reason STRING,
    raw_record_json STRING,
    quarantined_timestamp TIMESTAMP
) USING DELTA;

-- =============================================================================
-- 2. UNITY CATALOG DATA MASKING (PII Protection for Customer Contact)
-- =============================================================================
CREATE OR REPLACE FUNCTION silver.mask_email(email STRING)
RETURNS STRING
RETURN CASE 
    WHEN is_account_group_member('compliance_officers') THEN email
    ELSE concat(substr(email, 1, 2), '****@', split(email, '@')[1])
END;

ALTER TABLE silver.customer 
ALTER COLUMN email SET MASK silver.mask_email;

-- Grant Scoped Access to Analytical Personas
CREATE GROUP IF NOT EXISTS bi_analysts;
GRANT USAGE ON CATALOG bankingpoc TO `bi_analysts`;
GRANT USAGE ON SCHEMA bankingpoc.gold TO `bi_analysts`;
GRANT SELECT ON SCHEMA bankingpoc.gold TO `bi_analysts`;