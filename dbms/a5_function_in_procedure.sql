create table Stud_Marks(roll int primary key, name varchar(30), total_marks int);
create table Result (roll int, name varchar(30), class varchar(20), foreign key (roll) references Stud_Marks(roll));

\d //

CREATE FUNCTION calculate_grade
(rollno INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE marks INT;
DECLARE grade VARCHAR(20);

select total_marks into marks from Stud_Marks where Stud_Marks.roll = rollno;
 
if marks is null then
set grade = "Error";
return grade;
end if;
 
if marks<=35 then
	set grade = "FAIL";
elseif marks>35 and marks<75 then
	set grade = "PASS";
else 
	set grade = "A";
end if;

return grade;
end
//

create procedure create_result(rollno int)
begin
declare sname varchar(30);
declare grade varchar(20);

set grade = calculate_grade(rollno);

select name into sname from Stud_Marks where Stud_Marks.roll = rollno;
insert into Result values(rollno, sname, grade);
end;
//

\d ;
call create_result(1);

select * from Result;
