# Northwind Data Warehouse - Star Schema

## 📊 Project Overview
A complete data warehouse implementation using star schema design for the Northwind database. This project demonstrates ETL processes, dimensional modeling, and analytical querying.

## 🏗️ Schema Design
![Star Schema Diagram](star_schema.png)

## 📁 Database Structure

### Fact Table
- **fact_orders** - Sales transactions with measures
  - order_amount, quantity, discount_amount
  - Foreign keys to all dimensions

### Dimension Tables
- **dim_customers** - Customer information (91 records)
- **dim_products** - Product catalog (77 records)  
- **dim_time** - Time intelligence (809 records)

## 🛠️ Technical Stack
- PostgreSQL 16
- pgAdmin 4
- draw.io (for schema design)

## 📈 Key Features
- Star schema optimized for analytics
- Pre-built analytical queries
- Performance indexes
- Sample reports and views

## 🚀 Getting Started

### Prerequisites
- PostgreSQL with Northwind database
- pgAdmin or similar SQL client

### Installation
1. Run the SQL scripts in `queries.sql`
2. Execute in order: dimensions first, then fact table
3. Create indexes for performance

## 📊 Sample Analytics
The repository includes queries for:
- Sales by country and category
- Monthly revenue trends  
- Customer segmentation
- Product performance
- Window function analyses

## 📝 Files Included
- `star_schema.png` - Visual diagram of the schema
- `queries.sql` - Complete SQL code including:
  - Table creation
  - Data population
  - Analytical queries
  - Performance optimization

## 👨‍💻 Author
Your Name
