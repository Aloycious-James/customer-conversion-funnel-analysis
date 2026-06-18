CREATE TABLE customers (
    customer_id VARCHAR(50),
    name VARCHAR(100),
    email VARCHAR(150),
    country VARCHAR(50),
    age INT,
    signup_date DATE,
    marketing_opt_in BOOLEAN
);

CREATE TABLE sessions (
    session_id VARCHAR(50),
    customer_id VARCHAR(50),
    start_time TIMESTAMP,
    device VARCHAR(50),
    source VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE events (
    event_id NUMERIC,
    session_id NUMERIC,
    timestamp TIMESTAMP,
    event_type VARCHAR(50),
    product_id VARCHAR(50),
    qty NUMERIC,
    cart_size NUMERIC,
    payment VARCHAR(50),
    discount_pct NUMERIC,
    amount_usd NUMERIC
);

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_time TIMESTAMP,
    payment_method VARCHAR(50),
    discount_pct DECIMAL(5,2),
    subtotal_usd DECIMAL(10,2),
    total_usd DECIMAL(10,2),
    country VARCHAR(50),
    device VARCHAR(50),
    source VARCHAR(50)
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    product_id INT,
    unit_price_usd DECIMAL(10,2),
    quantity INT,
    line_total_usd DECIMAL(10,2)
);

CREATE TABLE products (
    product_id INT,
    category VARCHAR(100),
    name VARCHAR(255),
    price_usd DECIMAL(10,2),
    cost_usd DECIMAL(10,2),
    margin_usd DECIMAL(10,2)
);

CREATE TABLE reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    product_id INT,
    rating INT,
    review_text TEXT,
    review_time TIMESTAMP
);




ALTER TABLE events
RENAME TO events_old;


CREATE TABLE events AS
SELECT
    event_id,
    event_type,
    session_id,
    qty,
    payment,
    amount_usd,
    cart_size,
    discount_pct,
    timestamp,
    CAST(product_id AS NUMERIC)::INT AS product_id
FROM events_old;

select * from events_old;


SELECT
column_name,
data_type
FROM information_schema.columns
WHERE table_name = 'events';

SELECT COUNT(*)
FROM events e
JOIN products p
ON e.product_id = p.product_id;

drop table events_old;