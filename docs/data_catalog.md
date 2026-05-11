# Data Dictionary for Gold Layer

## The Gold Layer is the business-level representation, structured to support and reporting use cases. It consists of dimension tables and fact tables for specific business metrics.

### `1. gold.dim_customers`

| Column Name     | Data Type         | Description                                                                    |
| --------------- | ----------------- | ------------------------------------------------------------------------------ |
| customer_key    | INTEGER           | Surrogate key generated for each customer record using `ROW_NUMBER()`.         |
| customer_id     | INTEGER / VARCHAR | Unique customer identifier from the CRM system (`cst_id`).                     |
| customer_number | VARCHAR           | Business/customer reference number (`cst_key`).                                |
| first_name      | VARCHAR           | Customer's first name.                                                         |
| last_name       | VARCHAR           | Customer's last name.                                                          |
| country         | VARCHAR           | Customer's country derived from ERP location data.                             |
| marital_status  | VARCHAR           | Customer's marital status.                                                     |
| gender          | VARCHAR           | Customer gender. CRM gender is prioritized over ERP gender when values differ. |
| birthdate       | DATE              | Customer date of birth from ERP customer data.                                 |
| create_date     | DATE              | Date when the customer record was created in the CRM system.                   |

---

### `2. gold.dim_products`

| Column Name    | Data Type         | Description                                                                               |
| -------------- | ----------------- | ----------------------------------------------------------------------------------------- |
| product_key    | INTEGER           | Surrogate key generated for each active product record using `ROW_NUMBER()`.              |
| product_id     | INTEGER / VARCHAR | Unique product identifier (`prd_id`).                                                     |
| product_number | VARCHAR           | Business/product reference number (`prd_key`).                                            |
| product_name   | VARCHAR           | Name of the product.                                                                      |
| category_id    | VARCHAR           | Identifier of the product category.                                                       |
| category       | VARCHAR           | Product category name from ERP category mapping.                                          |
| subcategory    | VARCHAR           | Product subcategory name.                                                                 |
| maintenance    | VARCHAR           | Indicates whether the product requires maintenance or related maintenance classification. |
| cost           | DECIMAL           | Standard or base cost of the product.                                                     |
| product_line   | VARCHAR           | Product line classification.                                                              |
| start_date     | DATE              | Product effective start date.                                                             |

> Note: Only active/current products are included because records with `prd_end_dt IS NULL` are filtered.

---

### `3. gold.fact_sales`

| Column Name   | Data Type | Description                                                |
| ------------- | --------- | ---------------------------------------------------------- |
| order_number  | VARCHAR   | Unique sales order number.                                 |
| product_key   | INTEGER   | Foreign key referencing `gold.dim_products.product_key`.   |
| customer_key  | INTEGER   | Foreign key referencing `gold.dim_customers.customer_key`. |
| order_date    | DATE      | Date when the order was placed.                            |
| shipping_date | DATE      | Date when the order was shipped.                           |
| due_date      | DATE      | Expected due or delivery date of the order.                |
| sales_amt     | DECIMAL   | Total sales amount for the order line.                     |
| quantity      | INTEGER   | Quantity of products sold.                                 |
| price         | DECIMAL   | Unit price of the product sold.                            |
