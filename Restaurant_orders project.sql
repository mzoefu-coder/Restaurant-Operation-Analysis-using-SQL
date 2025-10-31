-- OBJECTIVE 1: EXPLORE THE ITEMS TABLE
-- 1. View the menu_items table and write a query to find the number of items in the menu

SELECT*
FROM menu_items;


SELECT COUNT(*)
FROM menu_items;

-- 2.What are the least and most expensive items on the menu
SELECT*
FROM menu_items
ORDER BY price;

SELECT*
FROM menu_items
ORDER BY price DESC;


-- 3. How many italian dishes are on the menu? what are the least and most expensive italian dishes on the menu?

SELECT count(*) category
FROM menu_items
WHERE category LIKE "Italian%";


SELECT *
FROM menu_items
WHERE category LIKE "Italian%"
ORDER BY price;

SELECT *
FROM menu_items
WHERE category LIKE "Italian%"
ORDER BY price DESC;

-- 4. HOW many dishes are in each category? what is the average dish price within each category?

SELECT category,COUNT(menu_item_id) as num_dishes
FROM menu_items
GROUP BY category;

SELECT category,AVG(price) as avg_price
FROM menu_items
GROUP BY category;


-- OBJECTIVE 2: EXPLORE THE ORDERS TABLE

-- 1. View the order_details table. what is the date range of rhe table
SELECT*
FROM order_details;

SELECT *
FROM order_details
ORDER BY order_date;


SELECT MIN(order_date),MAX(order_date)
FROM order_details
ORDER BY order_date;


-- 2. How many orders were made within this date range? How many items were ordered within this date range?
SELECT COUNT(DISTINCT order_id)
FROM order_details;

SELECT COUNT(*)
FROM order_details;

-- 3. which orders had the most order of items?
SELECT order_id, COUNT(item_id) as num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 4. How many orders had more than 12 items?
SELECT COUNT(*) FROM
(SELECT order_id, COUNT(item_id) as num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) as num_orders;


-- OBJECTIVE 3: ANALYZE CUSTOMER BEHAVIOR

-- 1. Combine the menu_items and order_details tables into a single table
SELECT*
FROM order_details;

SELECT*
FROM menu_items;

SELECT *
FROM order_details o
LEFT JOIN menu_items m
	ON o.item_id = m.menu_item_id;
    
    
-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name,category,COUNT(order_details_id) as num_purchases
FROM order_details o
LEFT JOIN menu_items m
	ON o.item_id = m.menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases;
    
-- 3. What were the top 5 orders that spent the most money?

SELECT order_id,SUM(price) as total_spend
FROM order_details o
LEFT JOIN menu_items m
	ON o.item_id = m.menu_item_id
GROUP BY order_id 
ORDER BY total_spend DESC
LIMIT 5;

    
-- 4. View the details of the highest spend order. what insights can you gather from the results?
SELECT category,COUNT(item_id) as num_items
FROM order_details o
LEFT JOIN menu_items m
	ON o.item_id = m.menu_item_id
WHERE order_id = 440
GROUP BY category;
    


-- 5. view the details of the top 5 highest spend orders . what insights can you gather from the results?

SELECT order_id,category,COUNT(item_id) as num_items
FROM order_details o
LEFT JOIN menu_items m
	ON o.item_id = m.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id,category;









