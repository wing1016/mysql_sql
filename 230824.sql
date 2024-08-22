-- comment 230824
create database db_cinema;
use db_cinema;
create table cinemas (
	id int,
    name varchar(30),
    address varchar(50)    
);
insert into cinemas (id, name, address) values (1, "Broadway Mongkok", "123, Mong Kok st");
insert into cinemas (id, name, address) values (2, "UA Tsim Sha Tsui", "456, Tsim Sha Tsui st");

create table movies (
	id int,
    name varchar(50),
    actor varchar(40),
    cinema_id int
);

insert into movies (id, name, actor, cinema_id) values ( 1, "King Kong", "Chan Tai Man", 1  );
insert into movies (id, name, actor, cinema_id) values ( 2, "DORAEMON 2", "Doraemon", 2  );

create table directors (
id int,
name varchar(50),
movie_id int
);
insert into directors (id, name, movie_id) values (1, "Wong Kar Wai", 1);
insert into directors (id, name, movie_id) values (2, "Wong Jing", 2);

