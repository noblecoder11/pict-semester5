-- deleting previous instances of following
DROP TABLE Borrower;
DROP TABLE Fine;
DROP PROCEDURE calculateFine_mock;

-- creating tables and inserting values
CREATE TABLE Borrower (rollno INT, name VARCHAR(20), doi DATE, bookName VARCHAR(20), status CHAR(1), PRIMARY KEY(rollno, bookName));
CREATE TABLE Fine (rollno INT, date DATE, amt INT);

INSERT INTO Borrower VALUES(1, 'Azad', '2022-09-20', 'toc', 'I');
-- trying to insert duplicate entry with same rollno and book
INSERT INTO Borrower VALUES(1, 'Azad', '2022-09-18', 'toc', 'I');
INSERT INTO Borrower VALUES(1, 'Azad', '2022-09-20', 'the alchemist', 'I');
INSERT INTO Borrower VALUES(2, 'Sanjiv', '2022-08-22', 'cns', 'I');
INSERT INTO Borrower VALUES(3, 'Chetan', '2022-08-15', 'dbms', 'I');
INSERT INTO Borrower VALUES(4, 'Minakshi', '2022-09-10', 'mrutyunjay', 'I');
INSERT INTO Borrower VALUES(5, 'Jaywant', '2022-09-28', 'sapiens', 'I');

-- procedure
\d //

CREATE PROCEDURE calculateFine_mock (IN roll INT, IN bname VARCHAR(20))
BEGIN
  -- declaration section
  DECLARE fine INT;
  DECLARE doi DATE;
  DECLARE ndays INT;
  DECLARE status CHAR(1);

  DECLARE EXIT HANDLER FOR SQLWARNING
  BEGIN
  ROLLBACK;
  SELECT 'Either there is no matching entry in Borrower table OR input is invalid' AS MESSAGE;
  END;

  -- execution section
  SELECT Borrower.doi, Borrower.status INTO doi, status FROM Borrower WHERE Borrower.rollno=roll AND Borrower.bookName=bname;
  IF STATUS = 'I' THEN
    SET ndays = DATEDIFF(curdate(), doi);
    IF ndays>15 AND ndays<=30 THEN
      SET fine = ndays*5;
    ELSEIF ndays>30 THEN
      SET fine = (ndays-30)*50+30*5;
    END IF;
	
    IF fine IS NOT NULL THEN
      INSERT INTO Fine VALUES(roll, curdate(), fine);
    END IF;
  ELSE 
    SELECT 'Book has been returned' AS MESSAGE;
  END IF;

  UPDATE Borrower SET status='R' WHERE rollno=roll and bookName=bname;

END;
//

\d ;

-- testing
-- less than 15 days
SET @rollno:=1, @bname:='toc';
CALL calculateFine_mock(@rollno, @bname);

-- book issued already
SET @rollno:=1, @bname:='toc';
CALL calculateFine_mock(@rollno, @bname);

-- invalid data
SET @rollno:='toc', @bname:=1;
CALL calculateFine_mock(@rollno, @bname);

-- no record exists
SET @rollno:=2, @bname:='toc';
CALL calculateFine_mock(@rollno, @bname);

-- more than 30 days
SET @rollno:=3, @bname:='dbms';
CALL calculateFine_mock(@rollno, @bname);

-- view data
SELECT * FROM Borrower;
SELECT * FROM Fine;
