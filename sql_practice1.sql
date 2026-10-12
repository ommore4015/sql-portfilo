-- 1. Find all employees earning more than $70,000.
/*+-----------------------+
| Tables_in_omsql_trial |
+-----------------------+
| customers             |
| employee              |
| order_items           |
| orders      
| products          |*/

use omsql_trial ;
select * from employee where salary > 70000 ;

-- 2. Find the 5 most recent orders.
select * from orders order by order_date desc limit 5 ;

--  3. Find all customers whose email is a Gmail address.
select * from customers where email like '%@gmail.com' ;
 
-- 4. Find all orders with status either 'shipped' or 'delivered'.
select * from orders where status in ('shipped','delivered') ;

-- 5. Find customers with a missing phone number.
select * from customers where phone is null ;

-- 6. Find all distinct product categories.
select distinct category from products ;

-- 7. Find orders placed in the last 30 days.
select * from orders order by order_date desc limit 30 ;  

-- 8. Find products priced between $50 and $200.
select * from products where price between 1600 and 2500 ;

-- 9. Sort employees by department, then by salary descending 
-- within each.
select * from employee order by department ASC , salary DESC ;

--  10. Rename the output column 'name' to 'Full Name'.
select name as full_name from employee ;

-- 11. Find the 3 highest-priced products.
select * from products order by price DESC limit 3 ;

-- 12. Find employees whose name starts with "A".
select * from employee where name like 'A%' ;
 
-- 13/24 joins 
 
-- 13.List each order alongside the customer's name.
select order_id , name 
from  orders
inner join customers on 
orders.customer_id = customers.customer_id ;

-- 14. List every customer, and their order id if they have one
select c.name , o.order_id 
from customers c
left join orders o on 
c.customer_id = o.customer_id ;

-- 15.Find customers who have never placed an order. 
select c.name 
from customers c 
left join orders o on
c.customer_id = o.customer_id where o.order_id is null ;

-- 16.List every employee with their manager's name.
 select e.name as employee,
 m.name as manager 
 from employee e 
 left join employee m on 
 e.manager_id = m.employee_id ;
 
-- 17.Reconcile two tables, showing rows that exist in only one of them.
select * from orders o join customers c on
o.customer_id = c.customer_id where ;

-- 18. Find pairs of students in the same class.
select c.name , o.name 
from customers c 
inner join orders o on
c.customer_id = o.customer_id ;

-- aggregation function #25 to #36

use omsql_trial ;
select * from orders;
select * from customers ;

-- find orders where region is west ;
select * from orders 
where region = 'west' ;

-- 25. Total salary per dep . 
select department, sum(salary) as total_salary 
from employee
group by department ;

-- 26. Regions where average revenue exceeds $5,000.
show tables ;
select region , round(avg(revenue),2) as avg_revenue from sales 
group by region having avg(revenue) > 5000 ;

-- 27. Count of distinct customers per product category.
select region , count(distinct customer_id) from orders
group by region ; 



