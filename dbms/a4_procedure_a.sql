-- library fine system

CREATE TABLE Borrower (rollno INT PRIMARY KEY, name VARCHAR(20), doi DATE, bookName VARCHAR(20), status CHAR(1));
CREATE TABLE Fine (rollno INT, date DATE, amt INT, FOREIGN KEY(rollno) REFERENCES Borrower(rollno) ON DELETE CASCADE);

INSERT INTO Borrower VALUES (1, 'Aditya', '2022-08-12', 'toc', 'I');
INSERT INTO Borrower VALUES (2, 'Shreyash', '2022-08-21', 'spos', 'I');
INSERT INTO Borrower VALUES (3, 'Pratik', '2022-07-21', 'cns', 'I');
INSERT INTO Borrower VALUES (4, 'Pranav', '2022-07-05', 'dbms', 'I');
INSERT INTO Borrower VALUES (5, 'Darshan', '2022-08-09', 'ds', 'I');

delimiter //

CREATE PROCEDURE calculate_fine (IN rollno INT, IN name VARCHAR(20))
BEGIN
	DECLARE fine INT;
	DECLARE date_of_issue INT;
	DECLARE days INT;

	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
	    ROLLBACK;
	    SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated' AS MESSAGE;
	END;

	SELECT doi into date_of_issue from Borrower where Borrower.rollno=rollno and Borrower.bookName=name;
	SET days = DATEDIFF(CURDATE(), date_of_issue);
	
	IF (days>=15 AND days<=30) THEN
	    SET fine=days*5;
	ELSEIF (days>30) THEN
	    SET fine=(days-30)*50+150;
	END IF;
	
	UPDATE Borrower SET status='R' where Borrower.rollno=rollno and Borrower.bookName=name;
	
	IF(fine is not null) THEN
	    INSERT INTO Fine VALUES(rollno, CURDATE(), fine);
	END IF;
END;
//

delimiter ;

-- exception handling is required for below input as datatypes are different
SET @myName := 'Shreyash';
SET @myrollno := 2;
CALL calculate_fine(@myName, @myrollno);

SET @myrollno := 2;
SET @mybookname := 'spos';
CALL calculate_fine(@myrollno, @mybookname);

SET @myrollno := 3;
SET @mybookname := 'cns';
CALL calculate_fine(@myrollno, @mybookname);

-- exception handling is required for below input as rollno does not exist in Borrower table
SET @myrollno := 7;
SET @mybookname := 'cns';
CALL calculate_fine(@myrollno, @mybookname);
