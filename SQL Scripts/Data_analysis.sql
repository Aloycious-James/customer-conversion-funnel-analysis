SELECT
event_type,
COUNT(*) AS total_events
FROM events
GROUP BY event_type
ORDER BY total_events DESC;

SELECT
    event_type,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS pct_of_events
FROM events
GROUP BY event_type
ORDER BY total_events DESC;


WITH funnel AS (
    SELECT
        COUNT(CASE WHEN event_type='page_view' THEN 1 END) AS page_views,
        COUNT(CASE WHEN event_type='add_to_cart' THEN 1 END) AS add_to_cart,
        COUNT(CASE WHEN event_type='checkout' THEN 1 END) AS checkout,
        COUNT(CASE WHEN event_type='purchase' THEN 1 END) AS purchase
    FROM events
)

SELECT
    page_views,
    add_to_cart,
    checkout,
    purchase,

    ROUND(add_to_cart*100.0/page_views,2) AS view_to_cart_pct,
    ROUND(checkout*100.0/add_to_cart,2) AS cart_to_checkout_pct,
    ROUND(purchase*100.0/checkout,2) AS checkout_to_purchase_pct,
    ROUND(purchase*100.0/page_views,2) AS overall_conversion_pct

FROM funnel;


SELECT
ROUND(SUM(total_usd),2) AS total_revenue
FROM orders;


SELECT
COUNT(*) AS total_orders
FROM orders;


SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM customers;


SELECT
ROUND(AVG(total_usd),2) AS average_order_value
FROM orders;


SELECT
ROUND(AVG(total_usd),2) AS average_order_value
FROM orders;


SELECT
ROUND(
SUM(total_usd) /
COUNT(DISTINCT customer_id)
,2) AS revenue_per_customer
FROM orders;


SELECT
p.category,
ROUND(SUM(oi.line_total_usd),2) AS revenue,
ROUND(AVG(r.rating),2) AS avg_rating
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
LEFT JOIN reviews r
ON p.product_id = r.product_id
GROUP BY p.category
ORDER BY revenue DESC;



SELECT COUNT(*)
FROM events e
JOIN products p
ON e.product_id = p.product_id;



SELECT
    p.category,
    COUNT(DISTINCT oi.order_id) AS orders,
    SUM(oi.quantity) AS units_sold,
    ROUND(AVG(oi.unit_price_usd),2) AS avg_price,
    ROUND(SUM(oi.line_total_usd),2) AS revenue
FROM order_items oi
JOIN products p
    ON CAST(oi.product_id AS INT) = CAST(p.product_id AS INT)
GROUP BY p.category
ORDER BY revenue DESC;


SELECT
    p.category,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(
        SUM(oi.line_total_usd) /
        COUNT(DISTINCT oi.order_id),
        2
    ) AS AOV
FROM order_items oi
JOIN products p
ON CAST(oi.product_id AS INT) =
   CAST(p.product_id AS INT)
GROUP BY p.category
ORDER BY AOV DESC;


SELECT
    p.category,
    COUNT(CASE WHEN e.event_type='page_view' THEN 1 END) AS page_views,
    COUNT(CASE WHEN e.event_type='add_to_cart' THEN 1 END) AS add_to_carts
FROM events e
JOIN products p
ON e.product_id = p.product_id
GROUP BY p.category;


SELECT
    source,
    COUNT(*) AS orders,
    ROUND(SUM(total_usd),2) AS revenue
FROM orders
GROUP BY source
ORDER BY revenue DESC;


SELECT
    payment_method,
    COUNT(*) AS orders,
    ROUND(SUM(total_usd),2) AS revenue
FROM orders
GROUP BY payment_method;


SELECT
    country,
    COUNT(*) AS orders,
    ROUND(SUM(total_usd),2) AS revenue
FROM orders
GROUP BY country
ORDER BY revenue DESC;


SELECT
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct <= 10 THEN '1-10%'
        WHEN discount_pct <= 20 THEN '11-20%'
        ELSE '20%+'
    END AS discount_group,
    COUNT(*) AS orders,
    ROUND(AVG(total_usd),2) AS avg_order_value
FROM orders
GROUP BY discount_group;


SELECT
    p.name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.line_total_usd),2) AS revenue
FROM order_items oi
JOIN products p
ON CAST(oi.product_id AS INT)=CAST(p.product_id AS INT)
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 10;