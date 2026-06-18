SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM sessions;
SELECT COUNT(*) FROM events;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM reviews;

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT session_id, COUNT(*)
FROM sessions
GROUP BY session_id
HAVING COUNT(*) > 1;

SELECT event_id, COUNT(*)
FROM events
GROUP BY event_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


SELECT
COUNT(*) FILTER (WHERE session_id IS NULL) AS null_session,
COUNT(*) FILTER (WHERE event_type IS NULL) AS null_event_type,
COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product,
COUNT(*) FILTER (WHERE timestamp IS NULL) AS null_timestamp
FROM events;
