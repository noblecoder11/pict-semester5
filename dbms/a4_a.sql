-- library fine system

create table Borrower (rollno int primary key, name varchar(20), doi date, bookName varchar(20), status char(1));
create table Fine (rollno int, date date, amt int, foreign key(rollno) references Borrower(rollno) on delete cascade);

