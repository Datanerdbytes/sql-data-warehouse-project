# Data Warehouse and Analytics Project
Welcome to the **Data Warehouse and Analytics Project** repository 🚀
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as portfolio projects,it highlights industry best practices in data engineering and analytics.

---
## 🔗📖 Project Overview
This project envolves:
1. Data Architecture: Designing a modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold.
2. ETL Pipelines: Extracting, Transforming, and Loading data from source systems into the warehouse.
3. Data Modeling: Developing fact and Dimension tables optimized for analytical queries.
4. Analytics and Reporting: Creating SQL-based reports and dashboards for actionable insights.

🎯 This repository is an excellent resource for professionals and students looking to showcase expertise in:
- SQL Developement
- Data Architec
- Data Engineering
- ETL Pipeline Developer
- Data Modeling
- Data Analytics

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objectives
Building a modern data warehouse using SQL Server to consolidate data, enabling analytical reporting and informed decision-making.

#### Specifications
- Data Sources: Import Data from two source systems (ERP and CRM) provided as CSV files.
- Data Quality: Cleanse and Resolve data quality issues prior to analysis.
- Integration: Combine both sources into a single, user-friendly data model designed for analytical queries. 
  Scope: Focus on the latest dataset only; historization of data is not required.
- Documentation**: Provide clear documentation of the data model to support both business stakeholders, and analytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

#### Objectives
Developed SQL-based analytics to deliver detailed insights into:

- Customer Behavior
- Product Performance
- Sales Trends

These insights empower stakeholders with business metrics, enabling strategic decision-making.

---
### Data Architecture
The data architecture for this project follows the Medallion Architecture __Bronze__, __Silver__, __Gold__ layers.

<img width="493" height="298" alt="Screenshot 2026-05-11 at 4 27 46 PM" src="https://github.com/user-attachments/assets/72a58904-4d21-41b2-88d4-d6294e50ef81" />

1. Bronze Layer: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server.
2. Silver Layer: Silver Layer includes data cleansing, standardization, and normalization, processs to prepare data for analysis.
3. Gold Layer: Houses business-ready data modeled a star-schema required for analytics and reporting.

---

## 🛡️ License

This project is licensed under the [MIT Licensed](LICENSE). You are free to use, modify, and share this project with proper attribution.



