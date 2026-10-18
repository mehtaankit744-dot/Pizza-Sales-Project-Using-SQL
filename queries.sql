-- Q1--Retrieve the total number of orders placed.

-- SELECT COUNT(order_id) AS total_orders FROM orders;


-- Q2--Calculate the total revenue generated from pizza sales
#---aliasing is done after JOIN and FROM--------
-- SELECT 
-- round(sum(od.quantity*p.price),2) AS total_revenue
-- FROM order_details od
-- JOIN pizzas p ON od.pizza_id = p.pizza_id;


-- Q3--Identify the name highest-priced pizza.
-- SELECT pizza_types.name, pizzas.price AS highest_priced_pizza
-- FROM pizza_types 
-- JOIN pizzas
-- ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
-- ORDER BY pizzas.price DESC LIMIT 1;

#--alternative solution by subqueries
-- SELECT pt.name, p.price
-- FROM pizza_types pt
-- JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
-- WHERE p.price = (SELECT MAX(price) FROM pizzas);


-- Q4--Identify the most common pizza size ordered.
-- SELECT pizzas.size, COUNT(order_details.order_details_id)
-- FROM pizzas JOIN order_details ON 
-- pizzas.pizza_id = order_details.pizza_id 
-- GROUP BY pizzas.size;

-- Q5--List the top 5 most ordered pizza types 
-- along with their quantities
-- SELECT pizza_types.name,
-- SUM(order_details.quantity) AS quantity
-- FROM pizza_types JOIN 
-- pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
-- GROUP BY pizza_types.name 
-- ORDER BY quantity DESC
-- LIMIT 5 ;


-- Q5--Join the necessary tables to 
-- find the total quantity of each pizza category ordered.
-- SELECT pizza_types.category, 
-- sum(order_details.quantity) AS total_quantity
-- FROM pizza_types JOIN pizzas
-- ON pizza_types.pizza_type_id = pizzas.pizza_type_id
-- JOIN order_details 
-- ON order_details.pizza_id = pizzas.pizza_id
-- GROUP BY category 
-- ORDER BY category DESC; 

-- Q6--Determine the distribution of orders by hour of the day
-- SELECT HOUR(order_time) AS hours,
-- COUNT(order_id) AS order_count
-- FROM orders
-- GROUP BY HOUR(order_time)

-- Q7--find the category-wise distribution of pizzas.
-- SELECT category, COUNT(name) AS category_wise FROM pizza_types
-- GROUP BY category;


#--Q8-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day.
-- SELECT ROUND(AVG(quantity),0) FROM 
-- (SELECT orders.order_date, sum(order_details.quantity) AS quantity
-- FROM orders 
-- JOIN order_details ON orders.order_id = order_details.order_id
-- GROUP BY orders.order_date) AS total_order;


#--Q9--Determine the top 3 most ordered pizza types based on revenue.
-- SELECT pizza_types.name,
-- SUM(order_details.quantity*pizzas.price) AS revenue
-- FROM pizza_types JOIN pizzas
-- ON pizzas.pizza_type_id = pizza_types.pizza_type_id
-- JOIN order_details ON order_details.pizza_id  = pizzas.pizza_id
-- GROUP BY pizza_types.name ORDER BY revenue DESC LIMIT 3;

-- Calculate the percentage contribution 
-- of each pizza category to total revenue.
WITH category_rev AS (
    SELECT pizza_types.category, 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS revenue
    FROM pizza_types JOIN pizzas ON
    pizza_types.pizza_type_id = pizzas.pizza_type_id 
    JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category
)
SELECT 
    category,
    revenue,
    ROUND((revenue / (SELECT SUM(revenue) FROM category_rev)) * 100, 2) AS percentage_contribution
FROM category_rev;






































