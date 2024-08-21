-- create database db_bc2405p
-- databases -> tables ( row x coloumns )
use db_bc2405p;
create table customers (
	id int,
    name varchar(50),
    email varchar(50)
);
-- insert into table name ( column name ) values ( value)
insert into customers ( id, name, email ) values (1, 'John Lau', 'John@gmail.com');
insert into customers ( id, name, email ) values (2, 'Peter Wong', 'peter@gmail.com');
insert into customers ( id, name, email ) values (3, 'Ho Po Wing', 'wing@gmail.com');
select * from customers where id = 2 and id = 1;
select name from customers where id = 1;

-- Order by 
select * from customers order by id asc; 
select count(*) from customers order by name asc; 

-- where , order by
select * from customers where id = 1 order by id desc;

create table students(
	id integer,   -- int
    name varchar(20),
    weight numeric(5, 2),  -- 2d.p. 	5-2 integer
    height numeric(5, 2)
);
insert into students (id, name, weight, height) values (1, 'wing', 46.7, 167);
insert into students (id, name, weight, height) values (3, 'Victor', 50.8, 180);
update  students set id = 2 where id = 1 and name = 'Joanna';
select * from students;

insert into students (id, name, weight, height) values (4.5, 'Susan', 45.5, 130);

