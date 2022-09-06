CREATE TABLE O_rollcall(rollno INT PRIMARY KEY, name VARCHAR(20), addr VARCHAR(30));

INSERT INTO O_rollcall VALUES(1, 'Amit', 'Nashik');
INSERT INTO O_rollcall VALUES(2, 'Shital', 'Pune');
INSERT INTO O_rollcall VALUES(3, 'Ranak', 'Manmad');

CREATE TABLE N_rollcall(rollno INT, name VARCHAR(20), addr VARCHAR(30));

\d //

CREATE PROCEDURE mergeTables()
BEGIN
  DECLARE rollno INT;
  DECLARE exit_loop BOOLEAN;
  DECLARE c1 CURSOR FOR SELECT O_rollcall.rollno FROM O_rollcall;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop=TRUE;
  OPEN c1;

  emp_loop: LOOP
    FETCH c1 INTO rollno;
    IF NOT EXISTS (SELECT * FROM N_rollcall WHERE N_rollcall.rollno=rollno) THEN
      INSERT INTO N_rollcall SELECT * FROM O_rollcall WHERE O_rollcall.rollno=rollno;
    END IF;
    IF exit_loop THEN
      CLOSE c1;
      LEAVE emp_loop;
    END IF;
  END LOOP emp_loop;
END;
//

\d ;
