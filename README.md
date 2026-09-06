# Azure Banking Lakehouse Medallion Architecture

An enterprise-grade, metadata-driven banking data platform built on Azure Data Lake Storage Gen2, Azure Data Factory, and Azure Databricks Unity Catalog.

## Architecture Highlights
- **Bronze Layer**: Raw ingestion from SQL Server to Delta Lake via ADF and parameterized notebooks.
- **Silver Layer**: Data cleansing, schema validation, quarantine routing for invalid records, and SCD Type 2 dimension versioning.
- **Gold Layer**: Aggregated business data marts (`customer_360`, `loan_summary`, `transaction_summary`).
- **Metadata & Audit Framework**: Dynamic control table driven watermarking with run-level logging.