CREATE DATABASE BOOTCAMP_EXERCISE2;
USE BOOTCAMP_EXERCISE2;

CREATE TABLE WORKER(
	WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR (25),
    LAST_NAME CHAR(25),
    SALARY NUMERIC (15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR (25)
);

INSERT INTO WORKER 
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES 
('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'),
('Niharika','Verma', 80000, '21-06-11 09:00:00', 'Admin'),
('Vishal','Singhal', 300000, '21-02-20 09:00:00', 'HR'),
('Mohan','Sarah', 300000, '21-03-19 09:00:00', 'Admin'),
('Amitabh','Singh', 500000, '21-02-20 09:00:00', 'Admin'),
('Vivek','Bhati', 490000,'21-06-11 09:00:00','Admin'),
('Vipul','Diwan', 200000,'21-06-11 09:00:00','Account'),
('Satish','Kumar', 75000,'21-01-20 09:00:00','Account'),
('Geetika','Chauhan', 90000,'21-04-11 09:00:00','Admin');

CREATE TABLE BONUS (
	WORKER_REF_ID INTEGER,
	BONUS_AMOUNT NUMERIC(10),
	BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES WORKER(WORKER_ID)
);

INSERT INTO BONUS VALUES
(6 , 32000, '21-11-02'),
(6, 20000, '22-11-02'),
(5 , 21000, '21-11-02'),
(9 , 30000, '21-11-02'),
(8 , 4500, '22-11-02');

SELECT * FROM WORKER; 
SELECT * FROM BONUS;

-- 2
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 1,1;

-- 3
SELECT concat(W1.FIRST_NAME,' ',LAST_NAME) AS 'WORKER NAME', W1.SALARY AS 'HIGHEST SALARY', W1.DEPARTMENT FROM WORKER W1 
 WHERE W1.SALARY = (SELECT max(W2.SALARY) FROM WORKER W2 WHERE W1.DEPARTMENT = W2.DEPARTMENT GROUP BY W2.DEPARTMENT); 
 
 -- 4
 SELECT CONCAT(W1.FIRST_NAME,' ', W1.LAST_NAME) AS NAME, W1.SALARY FROM WORKER W1 
 WHERE W1.SALARY = (SELECT W2.SALARY FROM WORKER W2 GROUP BY W2.SALARY HAVING COUNT(1) > 1);
 
 -- 5
 SELECT CONCAT(W.FIRST_NAME,' ', W.LAST_NAME)  AS NAME, W.SALARY, B.BONUS_AMOUNT, YEAR(B.BONUS_DATE) AS YEAR FROM WORKER W 
 LEFT JOIN BONUS B ON W.WORKER_ID = B.WORKER_REF_ID WHERE YEAR(B.BONUS_DATE) = 2021;
 
 -- 6
 delete from worker;
 -- failed to delete due to there is column 'WORKER_REF_ID' in table 'bonus' referencing the 'WORKER_ID' in table worker.
 
 -- 7
 drop table worker;
 -- failed to drop table worker due to there is column 'WORKER_REF_ID' in table 'bonus' referencing the 'WORKER_ID' in table worker.