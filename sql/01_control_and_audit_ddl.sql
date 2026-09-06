USE CATALOG bankingpoc;

-- =============================================================================
-- 1. CONTROL FRAMEWORK DDL (Metadata-Driven Pipeline Configuration)
-- =============================================================================
CREATE SCHEMA IF NOT EXISTS control;

CREATE TABLE IF NOT EXISTS control.pipeline_config (
    config_id BIGINT,
    source_system STRING,
    source_type STRING,
    source_database_name STRING,
    source_schema_name STRING,
    source_table_name STRING,
    row_count STRING,
    column_count STRING,
    load_type STRING,
    table_type STRING,
    key_column STRING,
    delta_column_1 STRING,
    delta_column_2 STRING,
    delta_column_3 STRING,
    partition_key_column STRING,
    adls_base_path STRING,
    adls_target_path STRING,
    adls_file_type STRING,
    target_catalog_name STRING,
    target_schema_name STRING,
    target_table_name STRING,
    start_time STRING,
    updt_end_time STRING,
    last_utc_end_time STRING,
    last_pipeline_run_date STRING,
    status STRING,
    source_query STRING,
    is_incremental STRING
) USING DELTA;

-- =============================================================================
-- 2. AUDIT FRAMEWORK DDL (Pipeline Run Telemetry & Watermarking)
-- =============================================================================
CREATE SCHEMA IF NOT EXISTS audit;

CREATE TABLE IF NOT EXISTS audit.pipeline_run_log (
    id BIGINT GENERATED ALWAYS AS IDENTITY,
    pipeline_name STRING,
    source_name STRING,
    run_id STRING,
    trigger_type STRING,
    trigger_name STRING,
    source_schema_name STRING,
    source_table_name STRING,
    target_catalog_name STRING,
    target_schema_name STRING,
    target_table_name STRING,
    copy_duration STRING,
    pipeline_start_time STRING,
    pipeline_end_time STRING,
    execution_status STRING,
    error_details STRING,
    rows_read STRING,
    rows_copied STRING,
    data_read STRING,
    data_written STRING,
    load_type STRING,
    start_time STRING,
    end_time STRING,
    last_load_date STRING,
    adls_target_path STRING
) USING DELTA;