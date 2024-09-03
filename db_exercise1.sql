create database bootcamp_exercise1;
use bootcamp_exercise1;

create table jobs (
	job_id varchar(10) PRIMARY KEY,
	job_title varchar(35),
	min_salary int,
	max_salary int
);

create table regions (
	region_id int PRIMARY KEY,
	region_name varchar(25)

);


create table countries (
	country_id char(2) PRIMARY KEY,
	country_name varchar(40),
	region_id int,
    foreign key (region_id) references regions (region_id)	
);

create table locations (
	location_id int PRIMARY KEY,
	street_address varchar(25),
	postal_code varchar(12),
	city varchar(30),
	state_province varchar(12),
	country_id char(2),
    foreign key (country_id) references countries(country_id)	
);



create table departments (
	department_id int PRIMARY KEY,
	department_name varchar(30),
	manager_id int,
	location_id int,
	foreign key (location_id) references locations(location_id)
);



create table employees (
	employee_id int PRIMARY KEY,
	first_name varchar(20),
	last_name varchar(25),
	email varchar(25),
	phone_number varchar(20),
	hire_date date,
	job_id varchar(10),
	salary int,
	commission_pct int,
	manager_id int,
	department_id int,
    foreign key (department_id) references departments(department_id),  
    foreign key (job_id) references jobs(job_id) 
  -- foreign key (employee_id) references job_history(employee_id)
);

create table job_history (
	employee_id int,
	start_date date,
	end_date date,
	job_id varchar(10),
	department_id int,
	foreign key (department_id) references departments(department_id),
    foreign key (job_id) references jobs(job_id),
    foreign key (employee_id) references employees(employee_id),
	PRIMARY KEY (employee_id, start_date)
);

-- create table jobs_grades (
-- 	grade_level varchar(2) PRIMARY KEY,
-- 	lowest_sal int,
-- 	highest_sal int
-- );

insert into jobs values ('ST_CLERK', 'Store Clerk', 1000, 9999);
insert into jobs values ('MK_REP', 'Marketing Representative', 2000, 9222);
insert into jobs values ('IT_PROG', 'IT Programmer', 3000, 9333);
insert into jobs values ('AC_CLERK', 'Account Clerk', 4000, 9444);

insert into regions values (1, 'Northeast' );
insert into regions values (2, 'Southwest' );
insert into regions values (3, 'West' );
insert into regions values (4, 'Southeast' );
insert into regions values (5, 'Midwest' );


insert into countries values ('DE', 'Germany', 1 );
insert into countries values ('IT', 'Italy', 1 );
insert into countries values ('JP', 'Japan', 3 );
insert into countries values ('US', 'United State', 2 );
insert into countries values ('KR', 'Korea', 3 );

insert into locations values (1000, '1297 Via Cola di Rie','989','ROMA',null,'IT');
insert into locations values (1100, '93091 Calle della Te','10934','Venice',null,'IT');
insert into locations values (1200, '2017 Shinjuku-ku','1689','Tokyo', 'Tokyo JP' , null);
insert into locations values (1400, '2014 Jabberwocky Rd','26192','Southlake', 'Texas' ,'US');
insert into locations values (1500, '9876 HongJong Rd','19432','Korea', 'Kimchi' ,'KR');

insert into departments values (10, 'Administration', 200, 1100);
insert into departments values (20, 'Marketing', 202, 1200);
insert into departments values (30, 'Purchasing', 202, 1400);
insert into departments values (40, 'Account', 203, 1500);


insert into employees values (100, 'Steven','King','SKING','515-1234567','1987-06-17','ST_CLERK', 24000, 0.00, 109, 10);
insert into employees values (101, 'Neena','Kochhar','NKOCHHAR','515-1234568','1987-06-18','MK_REP', 17000, 0.00, 103, 20);
insert into employees values (102, 'Lex','De Haan','LDEHAAN','515-1234569','1987-06-19','IT_PROG', 17000, 0.00, 108, 30);
insert into employees values (103, 'Alexander','Hunold','AHUNOLD','590-4234567','1987-06-20','MK_REP', 9000, 0.00, 105, 20);
insert into employees values (105, 'Betty','Chan','BECHAN','490-4234888','1970-06-20','MK_REP', 19000, 0.00, null, null);
insert into employees values (200, 'Christ','Lee','CHLEE','870-4232323','1987-01-10','MK_REP', 17000, 0.00, null, 30);
insert into employees values (202, 'Victor','Lau','VILAU','378-0674351','1995-02-23','IT_PROG', 13000, 0.00, null, 30);


insert into job_history values (102, '1993-01-13','1998-07-24','IT_PROG', 20);
insert into job_history values (101, '1989-09-21','1993-10-27','MK_REP', 10);
insert into job_history values (101, '1993-10-28','1997-03-15','MK_REP', 30);
insert into job_history values (100, '1996-02-17','1999-12-19','ST_CLERK', 30);
insert into job_history values (103, '1998-03-24','1999-12-31','MK_REP', 20);

-- 03Sep24
-- 3
select location_id, street_address, city, state_province, country_id from locations;
-- 4
select first_name, last_name, department_id from employees;
-- 8
select d.department_name, count(e.department_id) as 'no. of employees' from employees e left join departments d on e.department_id = 
d.department_id group by e.department_id;
-- 11
select d.department_name, ROUND(AVG(e.salary), 2) as 'avg salary' from employees e left join departments d on e.department_id = 
d.department_id group by e.department_id;


-- 04Sep24
-- 6
select e1.employee_id, e1.last_name, e1.manager_id, e2.last_name from employees e1 left join employees e2 on e1.manager_id = e2.employee_id;
-- 10
select d.department_name, concat(e.first_name, ' ', e.last_name) as 'manager name' , l.city, c.country_name from departments d 
left join employees e on d.manager_id = e.employee_id
left join locations l on d.location_id = l.location_id
left join countries c on l.country_id = c.country_id;