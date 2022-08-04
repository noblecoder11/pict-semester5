use dbmslab;
create table dept (dept_id INT PRIMARY KEY, dname varchar(20), dlocation varchar(20));
create table employee (emp_id int primary key, dept_id int, foreign key(dept_id) references dept(dept_id) on delete cascade, fname varchar(20), lname varchar(20), designation varchar(20), salary int, join_date date);
create table project (proj_id int primary key, dept_id int, foreign key(dept_id) references dept(dept_id) on delete cascade, pname varchar(20), plocation varchar(20), pcost int, pyear int);

-- To delete tables
-- drop table dept;
-- drop table employee;
-- drop table project;

-- 1. Insert at least 10 records in the Employee table and insert other tables accordingly.

insert into dept values(1, 'Computer', 'Pune');
insert into dept values(2, 'IT', 'Pune');
insert into dept values(3, 'Computer', 'Mumbai');
insert into dept values(4, 'IT', 'Mumbai');
insert into dept values(5, 'Production', 'Nagpur');
insert into dept values(6, 'Production', 'Nagpur');

-- I inserted all 'dlocation's as 'Pune'. So these commands were used to change it
-- update dept set dlocation='Mumbai' where (dept_id=3 or dept_id=4);
-- update dept set dlocation='Nagpur' where (dept_id=5 or dept_id=6);

insert into employee values (1, 1, 'Shreyash', 'Halge', 'Team Lead', 100000, '2021-07-26');
insert into employee values (2, 6, 'Pranav', 'Unkal', 'Project Manager', 150000, '2020-04-17');
insert into employee values (3, 2, 'Vaibhav', 'Kulkarni', 'Team Lead', 90000, '2018-04-27');
insert into employee values (4, 4, 'Pankaj', 'Patil', 'Developer', 50000, '2012-11-30');
insert into employee values (5, 5, 'Hardik', 'Pandya', 'Marketing Head', 200000, '2011-07-06');
insert into employee values (6, 3, 'Harshita', 'Arora', 'CEO', 1000000, '2008-03-06');
insert into employee values (7, 1, 'Tanaya', 'Modani', 'Team Lead', 100000, '2022-07-26');
insert into employee values (8, 1, 'Gayatri', 'Kudal', 'Developer', 70000, '2022-06-05');
insert into employee values (9, 2, 'Yash', 'Anchule', 'Developer', 50000, '2022-07-26');
insert into employee values (10, 3, 'Darshan', 'Mohekar', 'CTO', 700000, '2008-12-12');
insert into employee values (11, 4, 'Aniket', 'Kulkarni', 'Intern', 10000, '2022-03-26');

insert into project values (1, 1, 'Chatbot', 'Pune', 1000000, 2022);
insert into project values (2, 6, 'Border Communication', 'Mumbai', 10000000, 2004);
insert into project values (3, 1, 'Student Management', 'New Dehli', 500000, 2005);
insert into project values (4, 3, 'Healthcare', 'Pune', 9000000, 2006);
insert into project values (5, 4, 'Stock Predictor', 'Nagpur', 1000000, 2012);
insert into project values (6, 2, 'Messaging App', 'Bengaluru', 7000000, 2007);

-- select * from employee;
-- select * from project;
-- select * from dept;

-- 2. Display all Employee details with Department ‘Computer’ and ‘IT’ and Employee first name starting with 'p' or 'h'.
select * from employee left join dept on employee.dept_id=dept.dept_id where 
(dept.dname='Computer' or dept.dname='IT')
and
(emp_id in (select emp_id from employee where fname like 'H%' or fname like 'P%')); 

-- 3. Lists the number of different Employee Positions. 
select distinct designation from employee;

-- 4. Give 10% increase in Salary of the Employee whose joindate before 2015. 
update employee
set salary=salary+salary*0.10
where (YEAR(join_date) <= 2015 and emp_id>0);

-- 5. Delete all the department details having location as ‘mumbai’. 
delete from dept where (dlocation='Mumbai' and dept_id>0);

-- 6. Find the names of Projects with location ‘pune’ . 
select * from project where plocation='Pune';

-- 7. Find the project having cost in between 100000 to 500000. 
select * from project where pcost between 100000 and 500000;

-- 8. Find the project having maximum price and find average Project cost.
select * from project where pcost=(select max(pcost) from project);

-- 9. Display all employees with Emp _id and Emp name in descending order.
select * from employee order by fname desc;

-- 10. Display Proj_name,Plocation ,Pcost of all project started in 2004,2005,2007 
select pname, plocation, pcost from project where pyear=2004 or pyear=2005 or pyear=2007;

-- 11. Calculate experience of employees
select fname, timestampdiff(day, join_date, CURDATE()) as experience from employee;
