CREATE TABLE emp(empno INT, lname VARCHAR(20), salary INT, PRIMARY KEY(empno));
CREATE TABLE emp_audit(empno INT, lname VARCHAR(20), datetime DATETIME, action VARCHAR(20));

INSERT INTO emp VALUES (1, 'Sharma', 100000);
INSERT INTO emp VALUES (2, 'York', 80000);
INSERT INTO emp VALUES (3, 'Stuart', 120000);
INSERT INTO emp VALUES (4, 'Bruce', 150000);
INSERT INTO emp VALUES (5, 'Matthews', 50000);

\d //

CREATE TRIGGER mytrigger
AFTER UPDATE ON emp
FOR EACH ROW
BEGIN
INSERT INTO emp_audit SET empno=OLD.empno, lname=OLD.lname, datetime=NOW(), action='UPDATE';
END;//

\d ;

UPDATE emp SET lname='Stewart' WHERE empno=3;
UPDATE emp SET lname='Watts' WHERE empno=5;

-- ----------------------
create table lib_table(b_id int, title varchar(20), edition int, no_of_copies int);
create table lib_audit_table(b_id int, title varchar(20), edition int, no_of_copies int, date_of_modif date, type_of_operation varchar(20), username varchar(50));

insert into lib_table values(1, 'CNS', 2, 10);
insert into lib_table values(2, 'TOC', 3, 20);
insert into lib_table values(3, 'DS', 1, 30);
insert into lib_table values(4, 'DBMS', 8, 5);
insert into lib_table values(5, 'SPOS', 5, 5);

\d //

CREATE TRIGGER lib_update_trigger
AFTER UPDATE ON lib_table
FOR EACH ROW
BEGIN
INSERT INTO lib_audit_table SET b_id=OLD.b_id, title=OLD.title, edition=OLD.edition, no_of_copies=OLD.no_of_copies, date_of_modif=CURDATE(), type_of_operation='UPDATE', username=CURRENT_USER();
END;//

CREATE TRIGGER lib_delete_trigger
AFTER DELETE ON lib_table
FOR EACH ROW
BEGIN
INSERT INTO lib_audit_table SET b_id=OLD.b_id, title=OLD.title, edition=OLD.edition, no_of_copies=OLD.no_of_copies, date_of_modif=CURDATE(), type_of_operation='DELETE', username=CURRENT_USER();
END;//

\d ;

UPDATE lib_table SET no_of_copies=9 WHERE b_id=1;
UPDATE lib_table SET no_of_copies=21 WHERE b_id=2;
