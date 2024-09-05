-- comment
-- database -> table (row x column)
create database db_bc2405p;

-- login
use db_bc2405p;

-- Table name is per database
create table customers (
	id int,
    name varchar(50),
    email varchar(50)
);

-- insert into table_name (column1_name, ....) values (column1_value, .....);
insert into customers (id, name, email) values (1, 'John Lau', 'john@gmail.com');
insert into customers (id, name, email) values (2, 'Peter Wong', 'peter@gmail.com');

-- "*" means all columns
-- "where" means conditions on columns
select * from customers;
select * from customers where id = 2;
select * from customers where id = 1 or id = 2;
select * from customers where id = 1 and id = 2; -- no data matches this criteria
select name, email from customers where id = 1; -- John, john@gmail.com

-- order by
select * from customers order by id; -- asc
select * from customers order by id asc;
select * from customers order by id desc;

-- where (filter), order by (sort)
select * from customers where id = 1 order by id desc;

create table students (
	id integer, -- int
    name varchar(20),
    weight numeric(5,2), -- 5-2 (integer), 2 (decimal place)
    height numeric(5,2)
);

insert into students (id, name, weight, height) values (1, 'John Wong', 60.7, 165.50);
insert into students (id, name, weight, height) values (2, 'Peter Wong', 65.7, 175);
insert into students (id, name, weight, height) values (3.5, 'Jenny Wong', 68.55, 180.5);
insert into students (id, name, weight, height) values (3.4, 'Tom Wong', 68.55, 180.5);

insert into students (id, name, weight, height) values (5, 10, 68.55, 180.5);
insert into students (id, name, weight, height) values (6, 'Sally Cheung', 68.555, 180.5); -- 68.56

select * from students;
-- create table -> datetime, integer, numeric(10,2), varchar(50)

-- you can skip some column(s) when you execute insert statement
insert into students (id, name, weight) values (7, 'Benny Wong', 65.7);
select * from students;

-- If you don't specify the columns name, then you have to put all column values
insert into students values (8, 'Steven Wong', null, 174.3);

-- DDL (Data Definition Language): create/drop table, add/drop column, modify column defintion
-- DML (Data Manipulation Language): insert row, update column, delete row, truncate table (remove all data)

-- +, -, *, /, %
select weight + height as ABC, weight, height, id, name from students;
select s.weight + s.height as DEF, s.* from students s where s.weight > 65.5 order by name;

-- >, <, >=, <=, <>, !=, =
select * from students where id <> 6 and id <> 8;
-- not in 
select * from students where id not in (6, 8);
select * from students where id in (1,2,3);

select * from students where name = 'John Wong';

-- like, not like
select * from students where name like '%Wong%'; -- Any name with prefix (0 or more characters) and suffix (0 or more character)
select * from students where name like '%Wong'; -- end with Wong

select * from students where name not like '%Wong';

-- Null check
select * from students where weight is null or height is null;

-- Functions
insert into students (id, name, weight, height) values (9, '張小強', 68.55, 180.5);
select char_length(s.name) as name_char_length, length(s.name) as name_length, s.* from students s;

-- substring() -> start from 1
select upper(s.name), lower(s.name), substring(s.name, 1, 3), trim(s.name), replace(s.name, 'Wong' ,'Chan'), s.* from students s;

-- Java: indexOf(), DB: instr() return position 
-- position starts from 1
-- if not found, return 0
select instr(s.name, 'Wong'), s.* from students s;

create table orders (
	id integer,
    total_amount numeric(10, 2),
	customer_id integer
);

select * from orders; -- List<Order>
insert into orders values (1, 2005.10, 2);
insert into orders values (2, 10000.9, 2);
insert into orders values (3, 99.9, 1);

-- sum()
-- 3ms (without network consideration)
select sum(o.total_amount) from orders o;
select avg(o.total_amount) from orders o where customer_id = 2;

-- filter first, and then min(), max()
select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;
select min(o.total_amount), max(o.total_amount) from orders o;

select o.*, 1 as number, 'hello' as string from orders o;

-- why can we put all functions in select statement?
-- Ans: Aggregation Functions -> reuslt must be 1 row
select min(o.total_amount), max(o.total_amount), sum(o.total_amount), avg(o.total_amount), count(o.total_amount) from orders o;

-- o.total_amount -> NOT an aggregate result
select o.total_amount, sum(o.total_amount) from orders o; -- error
select o.total_amount, min(o.total_amount) from orders o; -- error
select o.total_amount, max(o.total_amount) from orders o; -- error

-- group by
select sum(total_amount) from orders where customer_id = 1;
select sum(total_amount) from orders where customer_id = 2;

-- group by -> select "group key" and agg functions
-- o.* -> group information or individual data information?
select o.customer_id, sum(o.total_amount), avg(o.total_amount), min(o.total_amount), max(o.total_amount), count(1)
from orders o group by o.customer_id; -- OK

select o.customer_id, sum(o.total_amount), o.id from orders o group by o.customer_id; -- NOT OK, why?
-- 1 99.9 3
-- 2 12006 (1 or 2?)

-- group by "unique key" -> meaningless
select o.id, sum(o.total_amount) from orders o group by o.id;

-- GROUP BY + HAVING
insert into orders values (4, 10000.9, 3);
insert into orders values (5, 20000, 3);

select o.customer_id, avg(o.total_amount) as avg_amount
from orders o 
where o.customer_id in (2, 3) -- first filter before group by (5 rows -> 4 rows) -> result: 4rows x 3columns
group by o.customer_id -- result: 2 rows x 2 columns
having avg(o.total_amount) > 10000 -- another filter after group by (result): 1 row x 2 columns
order by avg(o.total_amount) desc
;

-- 2 tables (one to many)
-- where, group by, having, order by

-- example: authors and books

select * from customers where name = 'JOHN LAU'; -- case insenstive
select * from customers where UPPER(name) = 'JOHN LAU'; -- if case sensitive, we should use upper() or lower()

select * from customers where name like '%HN%';
select * from customers where name like 'JO%LAU';

select * from customers where name like '_OHN%';
select * from customers where name like '_HN%';

select ceil(o.total_amount), floor(o.total_amount), ROUND(o.total_amount, 0), o.* from orders o;

SELECT POWER(2, 3.5) AS result;

select 1, ABS(-5) from dual;

-- Date formatting (MYSQL)
SELECT DATE_FORMAT('2023-08-31', '%Y-%m-%d') from dual;
SELECT DATE_FORMAT('2023-08-31', '%Y-%m-%d') + INTERVAL 1 DAY from dual;
SELECT STR_TO_DATE('2023-12-31', '%Y-%m-%d') + INTERVAL 1 DAY from dual;

-- Oracle
select to_date('20240831', 'YYYYMMDD') + 1 from dual;

-- Extract Year or Month or Day (MySQL)
SELECT EXTRACT(YEAR FROM DATE_FORMAT('2023-08-31', '%Y-%m-%d')) from dual;
SELECT EXTRACT(MONTH FROM DATE_FORMAT('2023-08-31', '%Y-%m-%d')) from dual;
SELECT EXTRACT(DAY FROM DATE_FORMAT('2023/08/31', '%Y/%m/%d')) from dual;

-- Result:
-- 2024 2
-- 2023 2
-- 2022 1

select EXTRACT(YEAR from tran_date) as YEAR, count(1) as NUMBER_OF_ORDERS
from orders
group by EXTRACT(YEAR from tran_date)
having count(1) >= 2;


select * from orders;
alter table orders add column tran_date date; -- DDL

update orders 
set tran_date = DATE_FORMAT('2023-08-31', '%Y-%m-%d')
where id = 1;

update orders 
set tran_date = DATE_FORMAT('2024-08-02', '%Y-%m-%d')
where id = 2;

update orders 
set tran_date = DATE_FORMAT('2023-12-04', '%Y-%m-%d')
where id = 3;

update orders 
set tran_date = DATE_FORMAT('2024-02-28', '%Y-%m-%d')
where id = 4;

update orders 
set tran_date = DATE_FORMAT('2022-06-01', '%Y-%m-%d')
where id = 5;

-- COALESCE/ IFNULL doesn't update the original data
select ifnull(s.weight, 'N/A'), ifnull(s.height, 'N/A'), s.* from students s;
select COALESCE(s.weight, 'N/A'), COALESCE(s.height, 'N/A'), s.* from students s;

-- < 2000 -> 'S'
-- >= 2000 and <= 10000 -> 'M'
-- > 10000 -> 'L'
select CASE WHEN o.total_amount < 2000 THEN 'S'
			WHEN o.total_amount between 2000 and 10000 THEN 'M'
			ELSE 'L'
		END AS category
    , o.*
from orders o;

-- between (inclusive)
select * 
from orders 
where tran_date between DATE_FORMAT('2023-08-31', '%Y-%m-%d') 
and DATE_FORMAT('2023-12-04', '%Y-%m-%d');

-- EXISTS (customers, orders)
-- Find the customer(s) who has order(s)

insert into customers values (3, 'Jenny Yu', 'jenny@hotmail.com');
insert into customers values (4, 'Benny Kwok', 'benny@hotmail.com');
select * from customers;
select * from orders;

-- "o.customer_id = c.id" -> check if the customer exists in orders
-- Approach 1 (you cannot select columns from order table)
select c.*
from customers c
where exists (select 1 from orders o where o.customer_id = c.id);

-- JOIN tables
-- 4 customers x 6 orders -> 24 rows
select *
from customers c inner join orders o; -- on

-- INNER JOIN is similar to EXISTS
-- Approach 2
select c.id, c.name, o.total_amount, o.tran_date
from customers c inner join orders o on o.customer_id = c.id;

select * from orders;


select *
from customers c
where not exists (select 1 from orders o where o.customer_id = c.id);

select * from orders;
insert into orders values (6, 9999, 3, DATE_FORMAT('2024-08-04', '%Y-%m-%d'));

-- distinct one column
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date)) from orders;
-- distinct two columns
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date)), total_amount from orders;

select o.*, (select max(total_amount) from orders), 20000.00, 1
from orders o;

-- Subquery (slow performance)
-- First SQL to execute: select id from customers where name like '%LAU'
-- Secondly, DBMS executes "select * from orders where customer_id in ...."
select *
from orders
where customer_id in (select id from customers where name like '%LAU');
use db_bc2405p;
select * from customers;

-- DDL
ALTER TABLE customers ADD CONSTRAINT pk_customer_id primary key (id);

insert into customers values ( 5, 'Mary Chan', 'mary@gmail.com' );

-- ADD FK
ALTER table orders Add constraint fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id);

insert into orders values ( 8, 9000, 5, date_format('2024-08-04','%y-%m-%d') );  
alter table customers add constraint unique_email unique (email);		

-- NOT NULL
ALTER TABLE customers modify name varchar(50) not null;	

use db_bc2405p;
show tables;

create view orders_202408
as
select * 
from orders 
where tran_date between DATE_FORMAT('2020-08-01','%Y-%m-%d') and DATE_FORMAT('2025-10-01','%Y-%m-%d');

DROP VIEW orders_202408;

SELECT * FROM orders_202408;

select * from orders;
