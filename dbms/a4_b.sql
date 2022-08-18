-- calculate area of circle for radius 5 to 9 and store it in Areas table

create table Areas(radius int primary key, area double);

delimiter //

create procedure circle_area ()
begin
declare r int;
declare area double;
set r = 4;
label: LOOP
SET r = r +1;
select r;
set area = 3.14*r*r;
IF r=10 THEN
LEAVE label;
ELSE
INSERT INTO Areas values(r, area);
END IF;
END LOOP label;
end
//

delimiter ;

call circle_area();

select * from circle_area();
