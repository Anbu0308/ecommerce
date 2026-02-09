create database project;
use project;
show tables;
select * from ecommerce_customers;
select * from ecommerce_orders;
select * from ecommerce_orders where region ='South' and price >500;

# 1. Total Orders Counts total number of orders placed.
select count(*) from ecommerce_orders;

# 2. Total Revenue Calculates overall business revenue.
select sum(price*quantity) from ecommerce_orders;

# 3. Average Order Value Measures average revenue per order.
select avg(price*quantity) from ecommerce_orders;

# 4. Regional Sales Analysis Identifies region-wise sales contribution.
select region,
	sum(price*quantity) as total_price 
    from ecommerce_orders 
    group by region;

# 5. TOP 5 ORDERS BY PRICE
select order_id,customer_name,price from ecommerce_orders order by price limit 5;


# 6. JOIN CUSTOMERS AND ORDERS
select o.order_id,c.customer_name,c.email,c.city,o.price from 
	ecommerce_customers as c join
	ecommerce_orders as o on c.customer_name=o.customer_name;


# 7. CASE STATEMENT (PRICE CATEGORY)
select customer_name,category,price,
case 
	when price > 1000 then 'premimum'
	when price between 500 and 1000 then 'midlevel'
	when price <500 then 'budget' end as price_category 
	from ecommerce_orders 
    order by category,price;
    
    
# 8. SUBQUERY WITH AVG
select * from ecommerce_orders 
	where price>(select avg(price) 
    from ecommerce_orders);
    

# 9. GROUP BY AGGREGATE
select region,sum(quantity) as total_item_sold
	from ecommerce_orders
	group by region
	order by total_item_sold;
    

# 10. MONTHLY REVENUE
select 
	date_format(order_date,'%y-%m') as month,
    sum(quantity*price) as total_revenue
	from ecommerce_orders
	group by month
	order by month;
    

# 11. TOP 5 BEST SELLING PRODUCTS
select product,sum(quantity) as total_quantity
	from ecommerce_orders 
	group by product 
	order by total_quantity desc limit 5;
    
    
# 12. REVENUE BY CATEGORY
select category,sum(quantity*price) as revenue
	from ecommerce_orders
	group by category
	order by revenue;


#13. CITY-WISE REVENUE
select ecommerce_customers.city,
	sum(ecommerce_orders.quantity*ecommerce_orders.price) as revenue
	from ecommerce_orders
	join ecommerce_customers on
    ecommerce_orders.customer_name=ecommerce_customers.customer_name
	group by city
	order by revenue;
