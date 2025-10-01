-- 1. Create dim_customers
CREATE TABLE dim_customers (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(10),
    company_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- 2. Create dim_products
CREATE TABLE dim_products (
    product_key SERIAL PRIMARY KEY,
    product_id INTEGER,
    product_name VARCHAR(100),
    category_name VARCHAR(50),
    unit_price DECIMAL(10,2)
);

-- 3. Create dim_time
CREATE TABLE dim_time (
    time_key SERIAL PRIMARY KEY,
    order_date DATE,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    quarter INTEGER
);

-- 4. Create fact_orders (last, because it references others)
CREATE TABLE fact_orders (
    order_detail_key SERIAL PRIMARY KEY,
    customer_key INTEGER REFERENCES dim_customers(customer_key),
    product_key INTEGER REFERENCES dim_products(product_key),
    time_key INTEGER REFERENCES dim_time(time_key),
    order_amount DECIMAL(10,2),
    quantity INTEGER,
    discount_amount DECIMAL(10,2)
);

