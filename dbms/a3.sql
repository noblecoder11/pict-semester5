create table dept (dept_id INT PRIMARY KEY, dname varchar(20), dlocation varchar(20));
create table employee (emp_id int primary key, dept_id int, foreign key(dept_id) references dept(dept_id) on delete cascade, fname varchar(20), lname varchar(20), designation varchar(20), salary int, join_date date);
create table project (proj_id int primary key, dept_id int, foreign key(dept_id) references dept(dept_id) on delete cascade, pname varchar(20), plocation varchar(20), pcost int, pyear int);

-- Insert at least 10 records in the Employee table and insert other tables accordingly.
insert into dept values(1, 'Computer', 'Pune');
insert into dept values(2, 'IT', 'Pune');
insert into dept values(3, 'Computer', 'Mumbai');
insert into dept values(4, 'IT', 'Mumbai');
insert into dept values(5, 'Production', 'Nagpur');
insert into dept values(6, 'Production', 'Nagpur');

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

--1. Find Employee details and Department details using NATURAL JOIN.
select * from employee natural join dept;

--2. Find the fname,designation,dlocation,JoinDate
select fname, designation, dlocation, join_date from employee natural join dept;

--3. Find the Employee details ,Proj_id,Project cost who does not have Project location as ‘Hyderabad’.
select employee.*, proj_id, pcost from employee natural join project where plocation!='Pune';

--4. Find Department Name ,employee name, designation for which project year is 2020,
select dname, fname, designation from employee natural join project natural join dept where pyear=2022;

--5. Display designation,Dept_id which Project cost is greater than 30000
select designation, dept_id from employee natural join project where pcost>5000000;

--6. Find the names of all the Projects that started in the year 2015.
select pname from project where pyear=2015;

--7. List the dname having number of employees are 10
select dept_id, count(emp_id) as strength from employee group by dept_id having strength>2;

--8. Display the total number of employee who have joined any project before 2009
select count(*) from employee natural join project where pyear<2009;

--9. Create a view showing the employee and Department details. (complex view)
create view emp_dept as (select * from employee natural join dept);

--10. Perform Manipulation on simple view-Insert, update, delete, drop view.
create view emp_sal as select emp_id, fname, lname, dept_id, salary from employee;
insert into emp_sal values('13', 'Jayesh', 'Kulkarni', 2, 500000);
update emp_sal set salary=50000 where emp_id=13;
delete from emp_sal where emp_id=13;
drop view emp_sal;
