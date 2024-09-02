create database bootcamp_exercise1;
use bootcamp_exercise1;

create table regions (
	region_id int PRIMARY KEY,
	region_name varchar(25),
	foreign key (region_id) references countries (region_id)
);

-- foreign key (customer_id) references table()

create table countries (
	country_id char(2) PRIMARY KEY,
	country_name varchar(40),
	region_id int,
	foreign key (country_id) references locations(country_id)
);

create table locations (
	location_id int PRIMARY KEY,
	street_address varchar(25),
	postal_code varchar(12),
	city varchar(30),
	state_province varchar(12),
	country_id char(2),
	foreign key (location_id) references departments(location_id)
);

create table departments (
	department_id int PRIMARY KEY,
	department_name varchar(30),
	manager_id int,
	location_id int,
	foreign key (department_id) references employees(department_id),
	foreign key (department_id) references job_history(department_id)
);

create table job_history (
	employee_id int PRIMARY KEY,
	start_date date PRIMARY KEY,
	end_date date,
	job_id varchar(10),
	department_id int,
	foreign key (employee_id) references employees(employee_id)
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
	department_id int
);

create table jobs (
	job_id varchar(10) PRIMARY KEY,
	job_title varchar(35),
	min_salary int,
	max_salary int,
	foreign key (job_id) references job_history(job_id),
	foreign key (job_id) references employees(job_id)
);

create table jobs_grades (
	grade_level varchar(2) PRIMARY KEY,
	lowest_sal int,
	highest_sal int
);