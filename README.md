# Enterprise Banking Lakehouse Platform (Medallion Architecture)

An end-to-end, metadata-driven banking lakehouse engineered using **Azure Data Factory (ADF)**, **Azure Data Lake Storage Gen2 (ADLS Gen2)**, and **Azure Databricks Unity Catalog**.

---

## 🏛️ Architecture Overview

```text
[On-Premises SQL Server]
       │
       ▼ (Self-Hosted IR / ADF Dynamic Copy Activity)
[ADLS Gen2 Landing (Parquet)]
       │
       ▼ (Databricks Bronze Engine: Parameterized Ingestion & Telemetry)
[Bronze Delta Tables] (Raw Append-Only + Metadata Lineage Columns)
       │
       ▼ (Databricks Silver Engine: Validation, Regex Quarantine & SCD Type 2)
[Silver Delta Tables] (Cleansed Dimensional & Fact Entities + Quarantine Log)
       │
       ▼ (Databricks Gold Engine: Curated Data Mart Aggregations)
[Gold Delta Tables] (Customer 360, Loan Risk Exposure, Branch Transaction Velocity)
       │
       ▼
[Databricks SQL / AI/BI Dashboards] (Executive Presentation Layer)