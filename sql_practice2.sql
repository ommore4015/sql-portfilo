show databases; 
use omsql_trial;
show tables;

create table if not exists students(
roll_num int primary key ,
name varchar(20),
DOB date ,
marks int,
grade char(2)
);

describe students ;

INSERT INTO students VALUES
(1,'Om','2004-12-30',85,'B'),
(2,'Rahul','2003-05-12',92,'A'),
(3,'Sneha','2004-08-20',76,'C'),
(4,'Priya','2003-11-18',95,'A'),
(5,'Amit','2004-02-14',68,'D'),
(6,'Neha','2003-09-25',81,'B'),
(7,'Rohan','2004-07-10',90,'A'),
(8,'Karan','2003-03-30',55,'F'),
(9,'Pooja','2004-06-15',88,'B'),
(10,'Anjali','2003-01-05',97,'A');

select * from students ;
-- practice 7/8/2026
-- 1. Display all records.
select * from students ;

-- 2. Display only student names.
select name from students ;

-- 3. Show students who scored more than 80 marks
select name , marks from students where marks > 80 ;

-- 4. Display students whose grade is 'A'.
select name , grade from students where grade = 'A';
select * from students where grade = "A";

-- 5. Display students ordered by marks in descending order.
select * from students order by marks DESC;

-- 6. Find the highest marks.
select max(marks) as max_marks_of_students from students ;
select * from students order by marks DESC limit 1;

-- 7. Find the average marks. 
select avg(marks) as avg_marks from students ;

-- 8. Count how many students are in each grade.
select grade,count(*) as grade_count from students group by grade;

-- 9. Display the top 3 students based on marks.
select * from students order by marks DESC limit 3 ;

-- 10. Display the second highest marks.
select max(marks) as second_highest from students where marks < (select max(marks) from students) ;

-- 11. display the third highest marks 
select max(marks) as third_highest from students where marks < (select max(marks) as second_highest from students where marks < (select max(marks) from students) );

use omsql_trial;

show tables ;

select * from students ;

-- 1.Display all student records.
select * from students ;

-- 2. Display only the name and marks columns.
select name , marks from students ;

-- 3. Display students whose marks are greater than 80.
select * from students where marks > 80 ;

-- 4. Display students whose grade is 'A'.
select * from students where grade = 'A' ;

-- 5. Display students whose marks are between 70 and 90.
select * from students where marks between 70 and 90 ;
 
-- 6. Display students whose names start with 'A'.
select * from students where name like 'A%';
 
-- 7. Display students whose names end with 'a'
select * from students where name like '%A';

-- 8. Display all students in ascending order of marks.
select * from students order by marks DESC ;

-- 9. Find the highest marks.
select name,max(marks) as highest_marks from students;

-- joins 
show databases;
use information_schema;
show tables;
create database practice;

use practice;

create table students(
student_id int primary key,
student_name varchar(50),
course_id int,
city varchar(50)
);

INSERT INTO students VALUES
(1,'Om',101,'Pune'),
(2,'Rahul',102,'Mumbai'),
(3,'Priya',103,'Nashik'),
(4,'Amit',104,'Nagpur'),
(5,'Sneha',NULL,'Pune'),
(6,'Karan',102,'Delhi'),
(7,'Riya',105,'Jaipur');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    duration VARCHAR(20),
    fees INT
);

INSERT INTO courses VALUES
(101,'Python','3 Months',15000),
(102,'SQL','2 Months',10000),
(103,'Power BI','2 Months',12000),
(106,'Java','4 Months',18000),
(107,'Data Science','6 Months',35000);

-- 1.Show every student with their course name.
select students.student_name,courses.course_name
from students 
inner join courses
on students.course_id = courses.course_id ;

-- alias 
select s.student_name,c.course_name
from students s
inner join courses c
on s.course_id = c.course_id ;

-- 2 . Show all students whether they have a course or not.
select students.student_name , courses.course_name
from students 
left join courses
on students.course_id = courses.course_id;

/*output
Om	Python
Rahul	SQL
Priya	Power BI
Amit	
Sneha	
Karan	SQL
Riya	
*/

-- 3.show every course even if no student is enroll
select students.student_name,courses.course_name
from students
right join courses
on students.course_id = courses.course_id ;

-- 4.Show only students whose course fee is greater than 11,000.
select students.student_name,
courses.course_name ,
courses.fees
from students 
inner join courses
on students.course_id = courses.course_id 
where courses.fees > 11000 ;

-- 5.Display student name, city and course duration.
select students.student_name,
students.city,
courses.duration 
from students
inner join courses
on students.course_id = courses.course_id ;

-- 6. Find students who have not enrolled in any course.
select students.student_name,courses.course_name 
from students 
left join courses
on students.course_id = courses.course_id 
where courses.course_name is null ;

-- 7.Find courses that have no students.
select students.student_name , courses.course_name
from students 
right join courses
on students.course_id = courses.course_id 
where students.student_name is null ;

-- 8.Show student name, course name and fees sorted by fees.
select students.student_name, 
       courses.course_name , 
	   courses.fees
from students 
inner join courses
on students.course_id = courses.course_id
order by courses.fees DESC ;

-- 9.Count how many students are enrolled in each course.
select courses.course_name, count(students.student_id) as total_studets
from courses
left join students 
on courses.course_id = students.course_id 
group by courses.course_name ;

-- 10.Show all students and all courses
select students.student_name , courses.course_name 
from students 
left join courses
on students.course_id = courses.course_id 

union 

select students.student_name , courses.course_name 
from students 
right join courses 
on students.course_id = courses.course_id ;

use practice;

-- 11.Show the student name, city, course name, and fees.
select students.student_name ,
	   students.city ,
       courses.course_name,
       courses.fees 
from students 
inner join courses 
on students.course_id = courses.course_id ;

-- 12.Display only students who are from Pune along with their course names
select students.student_name ,
	   students.city,
	   courses.course_name 
from students 
inner join courses
on students.course_id = courses.course_id 
where students.city = 'pune' ;

-- 13.Find all students enrolled in the SQL course.
select students.student_name,
       courses.course_name 
from students 
inner join courses
on students.course_id = courses.course_id 
where courses.course_name = 'SQL' ;

-- 14.Display students whose course fee is between 10,000 and 15,000.
select students.student_name , courses.course_name , courses.fees
from students 
inner join courses
on students.course_id = courses.course_id 
where courses.fees between 10000 and 15000 ;

-- 15.Show all students and courses, sorted alphabetically by student name.
select students.student_name , courses.course_name
from students 
left join courses 
on students.course_id = courses.course_id 
order by students.student_name ASC ;

-- 16.Count the number of students enrolled in each course.
select courses.course_name , count(students.student_id)
as total_students
from courses
left join students 
on courses.course_id = students.course_id 
group by courses.course_name ;

use practice;

-- 17. Find the course with the highest fee along with enrolled students.
select students.student_name ,
	   courses.course_name ,
       courses.fees 
from students 
inner join courses
on students.course_id = courses.course_id 
where courses.fees 

-- ALL opeator
-- 13/7/2026
show tables ;
select * from products ;
/*
+------------+--------------+-------------+----------+
| product_id | product_name | category    | price    |
+------------+--------------+-------------+----------+
|          1 | Laptop       | Electronics | 50000.00 |
|          2 | Mouse        | Electronics |   800.00 |
|          3 | Keyboard     | Electronics |  1500.00 |
|          4 | Table        | Furniture   |  7000.00 |
|          5 | Chair        | Furniture   |  3000.00 |
|          6 | Mobile       | Electronics | 25000.00 |
|          7 | Sofa         | Furniture   | 20000.00 |
+------------+--------------+-------------+----------+
*/
select * from orders ;
/*
+----------+------------+----------+---------------+
| order_id | product_id | quantity | customer_name |
+----------+------------+----------+---------------+
|      101 |          1 |        2 | Om            |
|      102 |          2 |        5 | Rahul         |
|      103 |          4 |        1 | Sneha         |
|      104 |          6 |        3 | Amit          |
|      105 |          2 |        2 | Om            |
+----------+------------+----------+---------------+
*/

-- Q1. Find products that cost more than every Furniture product.
select product_name 
from products 
where price > ALL(
select price 
from products 
where category = 'furniture'
);

-- Q2. Find products cheaper than every Electronics product.
select product_name,price 
from products 
where price < ALL(
select price
from products
where category = 'electronics'
);

update products set price = 500 where product_name = 'chair' ;

-- 3. Find products whose price is greater than all products ordered by sneha.
SELECT product_name, price
FROM Products
WHERE price > ALL (
    SELECT p.price
    FROM Products p
    JOIN Orders o
    ON p.product_id=o.product_id
    WHERE customer_name='sneha'
);
use practice;
show tables ;
select * from orders;
/*
+----------+------------+----------+---------------+
| order_id | product_id | quantity | customer_name |
+----------+------------+----------+---------------+
|      101 |          1 |        2 | Om            |
|      102 |          2 |        5 | Rahul         |
|      103 |          4 |        1 | Sneha         |
|      104 |          6 |        3 | Amit          |
|      105 |          2 |        2 | Om            |
+----------+------------+----------+---------------+
*/
select * from products ;
/*
+------------+--------------+-------------+----------+
| product_id | product_name | category    | price    |
+------------+--------------+-------------+----------+
|          1 | Laptop       | Electronics | 50000.00 |
|          2 | Mouse        | Electronics |   800.00 |
|          3 | Keyboard     | Electronics |  1500.00 |
|          4 | Table        | Furniture   |  7000.00 |
|          5 | Chair        | Furniture   |   500.00 |
|          6 | Mobile       | Electronics | 25000.00 |
|          7 | Sofa         | Furniture   | 20000.00 |
+------------+--------------+-------------+----------+
*/

-- Q1. Find products that have been ordered.
select product_name 
from products p
where exists (
select *
from orders o 
where p.product_id = o.product_id );

-- Q2. Find customers who ordered Electronics products.
select customer_name 
from orders 
where exists(
select * 
from products p
where p.product_id = orders.product_id 
and category = 'electronics' );

-- Q3. Find Furniture products that have orders. 
select product_name 
from products p
where category = 'furniture' 
and exists (
select * 
from orders 
where p.product_id = orders.product_id )
;

-- Q4. Find products that have never been ordered
select product_name 
from products p
where not exists (
select * from 
orders o  
where p.product_id = o.product_id );

-- Q5. Find Furniture products that have never been ordered.
select product_name 
from products p
where category = 'furniture' 
and not exists (
select * from orders o
where p.product_id = o.product_id )
;

-- 18/7/2026
-- practice 
/*
1.frame clause 
2.CTE(with,with recursive)
3.window function
*/
use practice;
show tables ;

/*
+--------+--------+------------+-----------+------------+
| emp_id | name   | department | salary    | manager_id |
+--------+--------+------------+-----------+------------+
|      1 | CEO    | Management | 150000.00 |       NULL |
|      2 | Rahul  | IT         |  90000.00 |          1 |
|      3 | Amit   | IT         |  70000.00 |          2 |
|      4 | Rohini | IT         |  65000.00 |          3 |
|      5 | Priya  | HR         |  60000.00 |          1 |
|      6 | Sneha  | HR         |  55000.00 |          5 |
|      7 | Vikram | Finance    |  80000.00 |          1 |
|      8 | Neha   | Finance    |  75000.00 |          7 |
|      9 | Rakesh | Sales      |  50000.00 |          1 |
|     10 | Anjali | Sales      |  45000.00 |          9 |
|     11 | Kiran  | Sales      |  52000.00 |          9 |
|     12 | Pooja  | Marketing  |  68000.00 |          1 |
+--------+--------+------------+-----------+------------+
*/
-- 1.Show each employee along with the average salary of their department
select name ,department,salary , avg(salary) over(partition by department order by salary ASC) as avg_salary from Employee;

-- 2. Display employee salary along with company's highest salary.
select *, max(salary) over () as max_salary from employee ;

-- 3.Assign rank according to manager id . 
select *,rank() over(order by manager_id asc) as rank_num from employee;

-- .Assign rank according to manager id.  (by using row num)
select * , row_number() over(partition by department order by manager_id) as row_num from employee ;

-- assign dense rank according to manager id 
select * , dense_rank() over(order by manager_id ASC) as dense_rank_row from employee ;

-- 4. Find the second highest salary using DENSE_RANK 
select * from 
(select *, dense_rank() over(order by salary DESC) as rnk from employee)t 
where rnk = 2 ;

-- 5.Find previous employee salary. 
select * , lag(salary,1,0)
over(order by salary ) as prev_emp_salary from employee ;

-- 6.Find next employee salary.
select *,lead(salary,1,0) over(order by salary) next_emp_salary from employee ;

-- 7.Calculate running total of salary. 
select * , sum(salary) over(order by salary) as running_sum from employee;

-- 8.Find salary difference with previous employee.
select *,salary - lag(salary) over(order by emp_id) as diff_with_prev_salary from employee;

-- 9.Find top 3 highest-paid employees in every department.
-- select * , dense_rank() over(partition by department order by salary desc) as highest_paid_employee from employee ;
select * from (
select * , dense_rank()
over(partition by department order by salary desc)
as highest_rank_emp from employee)t
where highest_rank_emp <= 3 ;

-- 10.Find employees whose salary is greater than department average.
select * from (select *,avg(salary) over(partition by department order by salary) avg_salary from employee)t where salary > avg_salary ;

/*
19/7/2026
FRAME CLAUSE
*/

 USE PRACTICE;
 select * from sales ;
 /*
 +---------+------------+---------+
| sale_id | sale_date  | amount  |
+---------+------------+---------+
|       1 | 2025-01-01 |  500.00 |
|       2 | 2025-01-02 |  700.00 |
|       3 | 2025-01-03 |  300.00 |
|       4 | 2025-01-04 |  800.00 |
|       5 | 2025-01-05 |  900.00 |
|       6 | 2025-01-06 |  400.00 |
|       7 | 2025-01-07 |  600.00 |
|       8 | 2025-01-08 | 1000.00 |
|       9 | 2025-01-09 |  550.00 |
|      10 | 2025-01-10 |  750.00 |
|      11 | 2025-01-11 |  650.00 |
|      12 | 2025-01-12 |  850.00 |
+---------+------------+---------+
*/
-- 1.Running total.
select *,sum(amount) over(order by sale_date rows between unbounded 
preceding and current row) running_total from sales ;

-- 2.Previous 2 rows total.
select *,sum(amount) over(order by sale_date rows between 2 preceding
and current row) as prev_2_row_total from sales ;

-- 3.Next 2 rows total.
select *, sum(amount)
over(order by sale_date rows between current row and 2 following)
as next_two from sales ;

-- 4.Previous 3 days sales.
select *,sum(amount) 
over(order by sale_date rows between 3 preceding and current row )
as prev_theree_salary from sales ;

-- 21/07/2026
/* CTE (COMMAN TABLE EXPRESSION)
1.WITH 
2.WITH RECURSIVE
*/
use practice ;
select * from sales ;
/*
+---------+------------+---------+
| sale_id | sale_date  | amount  |
+---------+------------+---------+
|       1 | 2025-01-01 |  500.00 |
|       2 | 2025-01-02 |  700.00 |
|       3 | 2025-01-03 |  300.00 |
|       4 | 2025-01-04 |  800.00 |
|       5 | 2025-01-05 |  900.00 |
|       6 | 2025-01-06 |  400.00 |
|       7 | 2025-01-07 |  600.00 |
|       8 | 2025-01-08 | 1000.00 |
|       9 | 2025-01-09 |  550.00 |
|      10 | 2025-01-10 |  750.00 |
|      11 | 2025-01-11 |  650.00 |
|      12 | 2025-01-12 |  850.00 |
+---------+------------+---------+
*/
-- 1.Create a simple CTE.
with sales_data as (
select * from sales)
select * from sales_data ;

-- 2.Employees earning above average salary. 
with above_avg_salary as(
select avg(amount) as avg_salary from sales )
select * from sales where amount > 
(select avg_salary from above_avg_salary);

select * from employee;

-- 3.Department-wise average salary.
with dept_wise_avg_salary as (
select department,round(avg(salary),2) from employee group by department )
select * from dept_wise_avg_salary ;

-- 4.Multiple CTE. create multiple location 
with avg_salary as (
select avg(salary) as average from employee ),
max_salary as 
(select max(salary) as maximum from employee),
min_salary as 
(select min(salary) as minimum from employee)
select * from avg_salary,max_salary,min_salary ;
 
-- 5.Recursive multiplication table of 5
with recursive mul_table as(
select 1 as n

union all

select n+1 from mul_table where n < 10 )

select n as number ,n*5 as table_5 from mul_table ;

  