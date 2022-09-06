-- below command can be used to run sql file in terminal
-- mysql --host="10.10.11.220" --user="t31132" --database="t31132db" -p < "31132/a5.sql"

CREATE TABLE Student (rollno INT, name VARCHAR(20), class VARCHAR(20), PRIMARY KEY(name));
CREATE TABLE Result (name VARCHAR(20), tot_marks INT, PRIMARY KEY(name), FOREIGN KEY(name) REFERENCES Student(name));

INSERT INTO Student VALUES(1, 'Shreyash', '');
INSERT INTO Student VALUES(2, 'Aditya', '');
INSERT INTO Student VALUES(3, 'Pratik', '');
INSERT INTO Student VALUES(4, 'Darshan', '');
INSERT INTO Student VALUES(5, 'Pranav', '');

INSERT INTO Result VALUES('Shreyash', 99);
INSERT INTO Result VALUES('Aditya', 74);
INSERT INTO Result VALUES('Pratik', 45);
INSERT INTO Result VALUES('Darshan', 21);
INSERT INTO Result VALUES('Pranav', 75);

\d //

CREATE FUNCTION calculateGrade(
	rollno INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE grade VARCHAR(20);
	DECLARE marks INT;
	
	SELECT tot_marks INTO marks FROM Student NATURAL JOIN Result WHERE Student.rollno=rollno;
	
	if marks is null then
	    set grade='Error';
	    return grade;
	end if;
	
	IF marks>=75 THEN
	    SET grade='Distinction';
	ELSEIF (50<=marks and marks<75) THEN
	    SET grade='First Class';
	ELSEIF (35<=marks and marks<50) THEN
	    SET grade='Pass Class';
	ELSE
	    SET grade='Fail Class';
	END IF;
	
	UPDATE Student SET Student.class=grade where Student.rollno=rollno;
	RETURN grade;
END
//

\d ;

SELECT calculateGrade(1);
SELECT calculateGrade(2);
SELECT calculateGrade(3);
SELECT calculateGrade(4);
SELECT calculateGrade(5);

SELECT * FROM Student;
