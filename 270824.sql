-- comment 270824
create database db_cinema;
use db_cinema;
create table cinemas (
	id int,
    name varchar(30),
    address varchar(50)
);
insert into cinemas (id, name, address) values (1, 'Broadway Mongkok', '123, Mong Kok st');
insert into cinemas (id, name, address) values (2, 'UA Tsim Sha Tsui', '456, Tsim Sha Tsui st');
insert into cinemas (id, name, address) values (3, 'UA Diamonds Hill', '789, Diamonds st');

create table movies (
	id int,
    name varchar(50),
    actor varchar(40),
    cinema_id int,
    director_id int,
    duration_mins int
);

insert into movies (id, name, actor, cinema_id, director_id, duration_mins) values ( 1, 'King Kong', 'Chan Tai Man', 1, 2, 100 );
insert into movies (id, name, actor, cinema_id, director_id, duration_mins) values ( 2, 'DORAEMON 2', 'Doraemon', 2, 1, 75 );
insert into movies (id, name, actor, cinema_id, director_id, duration_mins) values ( 3, 'Batman 3', 'Mr. Batman', 1, 1, 85 );
insert into movies (id, name, actor, cinema_id, director_id, duration_mins) values ( 4, 'King Kong 2', 'Chan Tai Man', 2, 2, 120 );
insert into movies (id, name, actor, cinema_id, director_id, duration_mins) values ( 5, 'Superman', 'Lee chiu yan', 3, 2, 70 );

create table directors (
id int,
name varchar(50),
birthday date
);

insert into directors (id, name, birthday) values (1, 'Wong Kar Wai', '1970-10-31');
insert into directors (id, name, birthday) values (2, 'Wong Jing', '1985-11-15');

-- 2 tables (  one to many)
-- where, group by, having, order by (  )
select m.director_id from movies m where cinema_id <> 3 group by m.director_id having avg(m.duration_mins > 95);

