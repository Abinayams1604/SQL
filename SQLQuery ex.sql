create database student;
create table student( id int primary key identity(1,1),Name char(50), DOB date,Mobile_Number bigint,Address varchar(50),city varchar(50));
insert into student values('liah','2004-07-20',7889564986,'Devi Nagar','chennai');
insert into student values('ram','2002-04-23',8493478934,'Gandhi street','Tenkasi');
insert into student values('joy','2007-05-13',7493478956,'Nehru street','kovai');
insert into student values('rani','1996-06-10',9493678967,'Raja Nagar','Tirunelveli');
insert into student values('akila','2012-07-23',6493478954,'Happy street','Rajapalayam');
insert into student values('hari','2022-04-13',7854396543,'amul street','kanyakumari');
insert into student values('devi','1990-07-12',8675649876,'Murugan street','chennai');
insert into student values('maha','2012-04-20',8745696543,'mukesh street','salem');
insert into student values('gayu','2016-10-25',9874563256,'Rathi colony','madurai');
insert into student values('sabari','1993-05-19',7865439865,'matha street','Tirupur');
select * from student;



alter table student alter column city varchar(100);  
alter table student add age int;
alter table student drop column age;

create table teacher( id int primary key identity(1,1),Name char(50), DOB date,Mobile_Number bigint,Address varchar(50),city varchar(50));
select * from teacher;
insert into teacher values('maha','2012-04-20',8745696543,'mukesh street','salem');
insert into teacher values('gayu','2016-10-25',9874563256,'Rathi colony','madurai');
insert into teacher values('sabari','1993-05-19',7865439865,'matha street','Tirupur');
drop table teacher;


delete from teacher;
select * from teacher;
delete from teacher where id=12;
delete from teacher where id in (6,7);
delete from teacher where id between 4 and 9;
delete from student where id between 1 and 10;
select Name,city from student;

truncate table teacher;
truncate table student;
select * from student;
update student set city='tvl';

begin tran
update student set city='Tenkasi' where id=6;
begin tran rollback;

begin tran
update student set city='Teni' where id=6;
commit;
begin tran rollback;

begin tran
insert into student values('sabari','1993-05-19',7865439865,'matha street','Tirupur');
save tran s1;
begin tran
insert into student values('hari','2022-04-13',7854396543,'amul street','kanyakumari');
save tran s2;
begin tran
insert into student values('devi','1990-07-12',8675649876,'Murugan street','chennai');
save tran s3;
begin tran
insert into student values('maha','2012-04-20',8745696543,'mukesh street','salem');
save tran s4;
begin tran
insert into student values('gayu','2016-10-25',9874563256,'Rathi colony','madurai');
save tran s5;
begin tran
insert into student values('liah','2004-07-20',7889564986,'Devi Nagar','chennai');
save tran s6;

select * from student;
update student set city='Tenkasi' where id=39;
begin tran rollback tran s5;




--28-01-2026
create table cons(id int primary key identity(1,1),name varchar(50) not null,
mobile bigint unique,email varchar(100) constraint uq_email unique,
city varchar(50) constraint df_city default 'tambaram',
age int constraint ck_age check(age>18));
insert into cons values('vimal',9473826746,'vimal2804@gmail.com',
'villupuram',25);
select * from cons;
insert into cons(mobile,email,city,age) values(9573826746,'vimal2604@gmail.com',
'cuddalore',24);
insert into cons(name,mobile,email,age) values('santhosh',9573827746,'vimal2504@gmail.com',
23);
select * from cons;
insert into cons(name,mobile,email,city,age) values('arjun',9573827747,'vimal2503@gmail.com','theni',15);

alter table cons drop constraint [UQ__cons__A32E2E1CAC134639],[uq_email],
[ck_age],[df_city];
alter table cons add constraint uq_mobile unique(mobile);
alter table cons add constraint df_city default 'pondy' for city;
alter table cons add constraint ck_age check(age>18);
alter table cons alter column name varchar(50);
alter table cons alter column name varchar(50) not null;


--29-01-2026
--join(merge column )
alter table student add did int constraint fk_dept foreign key references department(did);
update student set did=1 where sid in (1,12,27,5);
update student set did=2 where sid in (2,13,28,6);
update student set did=3 where sid in (3,14,29,7);
update student set did=4 where sid in (4,15,30,8);
update student set did=5 where sid in (10,16,26,9);
select * from student;
select * from student inner join department on department.did=student.did;
select student.sname,department.dname from student inner join department on department.did=student.did;
select s.sname,d.dname from student s inner join department d on d.did=s.did;
select s.sname,d.dname from student s left join department d on d.did=s.did;
select s.sname,d.dname from student s right join department d on d.did=s.did;
select s.sname,d.dname from student s full join department d on d.did=s.did;
select s.sname,d.dname from student s cross join department d ;

---30/01/2026----
alter table department add fid int constraint fk_fees foreign key references fees(fid);
update department set fid=1 where did in (1,5);
update department set fid=2 where did in (2,4);
update department set fid=3 where did in (3,6);
update department set fid=4 where did in (10,8);
update department set fid=5 where did in (7,9);
select * from department;

select s.sname,d.dname,f.famount from student s inner join department d on d.did=s.did inner join fees f on f.fid=d.fid;

--set function(row merge)-combine multiple select statement on getting into single table-union(unique),union all(all record),intersect(common),except(uncommon)
select sid from student
intersect
select did  from department;

---top clause

select top(5) * from student;

--sorting(order by)

select * from student order by sname asc;
select * from student order by sname desc;

--distinct(unique)

select distinct (did) from student;

--function is a block of code(file format- save)(reuseability,output query)
--inbuilt function,userdefined function
--aggregate(number)-avg,count,max,min,sum

select sum(famount) from fees;
--date and time
--string




create database college;
create table student( sid int primary key identity(1,1),sname char(50), city varchar(50),age int);
select * from student;
insert into student values('Arun', 'Chennai', 22),
('Priya', 'Madurai', 21),
('Karthik', 'Coimbatore', 23),
('Sneha', 'Salem', 20),
('Vijay', 'Trichy', 24),
('Divya', 'Erode', 22),
('Rahul', 'Vellore', 25),
('Meena', 'Thanjavur', 21),
('Suresh', 'Tirunelveli', 23),
('Anitha', 'Hosur', 22),
('Manoj', 'Nagercoil', 24),
('Kavya', 'Karur', 20),
('Ajith', 'Dindigul', 26),
('Pooja', 'Namakkal', 21),
('Ramesh', 'Cuddalore', 27),
('Lakshmi', 'Kanchipuram', 22),
('Santhosh', 'Thoothukudi', 23),
('Nisha', 'Virudhunagar', 20),
('Pradeep', 'Nagapattinam', 24),
('Harini', 'Perambalur', 22),
('Gokul', 'Pudukkottai', 25),
('Swathi', 'Ariyalur', 21),
('Deepak', 'Sivagangai', 26),
('Rekha', 'Ramanathapuram', 23),
('Madhan', 'Dharmapuri', 24),
('Shalini', 'Krishnagiri', 22),
('Varun', 'Tenkasi', 23),
('Janani', 'Villupuram', 21),
('Naveen', 'Tiruppur', 25),
('Keerthana', 'Mayiladuthurai', 20);

create table department( did int primary key identity(1,1),dname char(50));
select * from department;
insert into department values ('Computer Science'),
('Mechanical'),
('Electrical'),
('Electronics'),
('Civil'),
('Information Technology'),
('Artificial Intelligence'),
('Data Science'),
('Cyber Security'),
('Biomedical');

create table fees( fid int primary key identity(1,1),famount int);
select * from fees;
insert into fees values(1000),
(2500),
(3200),
(4700),
(5800),
(6000),
(7200),
(8500),
(9100),
(10000);

select * from student;
select * from department;

create table cons(id int primary key identity(1,1),name varchar(50) not null,
mobile bigint unique,email varchar(100) constraint uq_email unique,
city varchar(50) constraint df_city default 'tambaram',
age int constraint ck_age check(age>18));
insert into cons values('vimal',9473826746,'vimal2804@gmail.com',
'villupuram',25);
select * from cons;
insert into cons(mobile,email,city,age) values(9573826746,'vimal2604@gmail.com',
'cuddalore',24);
insert into cons(name,mobile,email,age) values('santhosh',9573827746,'vimal2504@gmail.com',
23);
select * from cons;
insert into cons(name,mobile,email,city,age) values('arjun',9573827747,'vimal2503@gmail.com','theni',15);

alter table cons drop constraint [UQ__cons__A32E2E1CAC134639],[uq_email],
[ck_age],[df_city];
alter table cons add constraint uq_mobile unique(mobile);
alter table cons add constraint df_city default 'pondy' for city;
alter table cons add constraint ck_age check(age>18);
alter table cons alter column name varchar(50);
alter table cons alter column name varchar(50) not null;

--29-01-2026
--join(merge column )
alter table student add did int constraint fk_dept foreign key references department(did);
update student set did=1 where sid in (1,12,27,5);
update student set did=2 where sid in (2,13,28,6);
update student set did=3 where sid in (3,14,29,7);
update student set did=4 where sid in (4,15,30,8);
update student set did=5 where sid in (10,16,26,9);
select * from student;
select * from student inner join department on department.did=student.did;
select student.sname,department.dname from student inner join department on department.did=student.did;
select s.sname,d.dname from student s inner join department d on d.did=s.did;
select s.sname,d.dname from student s left join department d on d.did=s.did;
select s.sname,d.dname from student s right join department d on d.did=s.did;
select s.sname,d.dname from student s full join department d on d.did=s.did;
select s.sname,d.dname from student s cross join department d ;

/*30*/

alter table department add fid int constraint fk_fees foreign key references fees(fid);
update department set fid=1 where did in (1,5);
update department set fid=2 where did in (2,6);
update department set fid=3 where did in (3,7);
update department set fid=4 where did in (4,8);
update department set fid=5 where did in (10,9);
select * from department;
select s.sname,d.dname,f.famount from student s  inner join department d on d.did=s.did inner join fees f on f.fid=d.fid;

select sum(famount) from fees;
select avg(famount) from fees;
select max(famount) from fees;
select min(famount) from fees;
select count(famount) from fees;

--date and time

select CURRENT_TIMESTAMP;
select GETDATE();
select GETUTCDATE();
select SYSDATETIME();
select SYSDATETIMEOFFSET();
select SYSUTCDATETIME();
select DATEADD(YEAR,7,getdate());
--year -yyyy,yy
--quarter -qq,q
--month- mm,m
--week- ww,wk
--dayofyear -dy,y
--day - dd,d
--weekday-dw,w
--hour -hh
--minute - mi,n
--second -ss,s
--milisecond - ms

select DATEDIFF(year,'2005-04-16',GETDATE());
select DATENAME(year,getdate());
select DATEPART(year,getdate());
select DATENAME(DAYOFYEAR,getdate());
select DATENAME(day,getdate());
select DATENAME(WEEKDAY,getdate());
select DATEPART(weekday,getdate());
select DAY(GETDATE());
select month(GETDATE());
select year(GETDATE());
select ISDATE('20260216');

--string function
--ascii
select sname,ascii(sname) from student;
select ascii('A');
--char(no to ascii letter)
select char(65);
--charindex(position of letter)
select sname,CHARINDEX('a',sname) from student;
select sname,CHARINDEX('a',sname,3) from student;

--string

select right('keerthi',3) ;

select sname,left(sname,3) from student;
select sname,substring(sname,3,2) from student;
select sname,len(sname)from student;
select DATALENGTH('    kumar    ') ;
select sname,len('     kavi     ')from student;--(len count stop the word)
select sname,datalength('     kavi    ') from student;--(datalength count after the word space)
select sname,LOWER (sname) from student;
select sname,UPPER(sname) from student;
select ltrim('     kavi     ')from student;
select trim('     kavi     ')from student;
select rtrim('     kavi     ')from student;
select sname,quotename(sname) from student;
select sname,quotename(sname,'{}') from student;
select sname,replace(sname,'a','o') from student;
select sname, replicate(sname,5) from student;
select sname,reverse(sname) from student;
select concat(sid,sname,city) from student;
select concat_WS('-',sid,sname,city) from student;

--operators
---Arithmetic operator

select sid,did,(sid+did) from student;
select sid,did,(sid-did) from student;
select sid,did,(sid*did) from student;
select sid,did,(sid/did) from student;
select sid,did,(sid%did) from student;

---comparison operator

select * from student where sid=3;
select * from student where sid<>3;
select * from student where sid<3;
select * from student where sid>3;
select * from student where sid<=3;
select * from student where sid>=3;

---logical operator
--and,or,in,between,like,not,all,any,some,exists

--and
select * from student where sid=22 and sname='kumar';
--or
select * from student where sid=22 or sname='kumar';
--in
select * from student where sid in (22,16,3); 
--between
select * from student where sid between 4 and 14;
--like
select * from student where sname like '%s%'; 
select * from student where sname like 's%'; 
select * from student where sname like '%a'; 
--not in
select * from student where sid not in (21,16,6);
select * from student where sid not between 4 and 15;
--all
select * from student where did=all
(select did from department where dname='Mechanical' );
select * from student where did=all
(select did from department where dname='Data Science' );
select * from student where did=all
(select did from department where dname='chemistry' );
select * from student where did=all
(select did from department where dname=('Mechanical''Electrical' ));
--any
select * from student where did=any
(select did from department where dname='Mechanical' );
select * from student where did=any
(select did from department where dname='Data Science' );
select * from student where did=any
(select did from department where dname='chemistry' );
select * from student where did=any
(select did from department where dname in ('Mechanical','Electrical'));
--some
select * from student where did=some
(select did from department where dname='Mechanical' );
select * from student where did=some
(select did from department where dname='Data Science' );
select * from student where did=some
(select did from department where dname='chemistry' );
select * from student where did=some
(select did from department where dname in ('Mechanical','Electrical'));
--exists
select * from student where exists
(select did from department where dname='Mechanical' );
select * from student where  exists
(select did from department where dname='Data Science' );
select * from student where exists
(select did from department where dname='chemistry' );
select * from student where  exists
(select did from department where dname in ('Mechanical','Electrical'));

--Ranking function
--1. row_number()
--2.rank()
--3.dense_rank()
--4.ntile()


create table student_marks( sid int primary key identity(1,1),sname char(50), department varchar(50),mark int);
select * from student_marks;
insert into student_marks values('Arun', 'CSE', 85),
('Bala', 'IT', 78),
('Charan', 'ECE', 88),
('Deepak', 'EEE', 85),
('Eswar', 'MECH', 72),
('Farhan', 'CIVIL', 81),
('Gokul', 'CSE', 90),
('Hari', 'IT', 74),
('Imran', 'ECE', 69),
('Jagan', 'EEE', 88),
('Karthik', 'MECH', 76),
('Lokesh', 'CIVIL', 64),
('Manoj', 'CSE', 92),
('Naveen', 'IT', 71),
('Pradeep', 'ECE', 85),
('Rahul', 'EEE', 73),
('Santhosh', 'MECH', 80),
('Tarun', 'CIVIL', 71),
('Uday', 'CSE', 68),
('Vignesh', 'IT', 89),
('Yogesh', 'ECE', 72),
('Abishek', 'EEE', 82),
('Dinesh', 'MECH', 73),
('Kishore', 'CIVIL', 66),
('Madhan', 'CSE', 91),
('Nithin', 'IT', 79),
('Pranav', 'ECE', 84),
('Rakesh', 'EEE', 73),
('Surya', 'MECH', 82),
('Vijay', 'CIVIL', 65);

--Ranking function
--1. row_number()
select *,ROW_NUMBER() over(order by mark) from student_marks;
select *,ROW_NUMBER() over(order by mark desc) from student_marks;
select *,ROW_NUMBER() over(partition by department order by mark desc) from student_marks;
select *,ROW_NUMBER() over(partition by mark order by mark desc) from student_marks;

--2.rank()
select *,rank() over(order by mark desc) from student_mark;

--3.dense_rank()
select *,dense_rank() over(order by mark desc) from student_marks;

--4.ntile()
select *,ntile(5) over(order by mark desc) from student_marks;

--common table expression(cte)-virtual table(already ouput table to create another table)

with cte_mark as (select *,dense_rank() over(order by mark desc) as Rank from student_marks)
select Rank,count(sid) as count from cte_mark group by Rank;

--Table variable(does not save database only for testing purpose)
--declare keyword ,@, variable name,datatype

declare @stud table (sid int,sname varchar(50),age int)
insert into @stud values(1,'arun',20),(2,'sobi',23),(3,'jai',24)
select * from @stud
update @stud set age=21 where sid=2
select * from @stud

--temp table(automatic delete, it store in system database-> tempdp)
--local tem table(create table # table name)-server change, window close(delete table)
--global tem table(create table ## table name)-window close(delete table)

create table #lib(bid int,bname varchar(50));
create table ##stud(sid int,sname varchar(50),scity varchar(50));
insert into #lib values(1,'science'),(2,'social'),(3,'Tamil');
insert into ##stud values(1,'san','chennai'),(2,'ram','porur'),(3,'veera','tvl');
select * from #lib;
select * from ##stud;

--error handling(try-code,catch-error response)
--compile time error,run time error(external)
--(input,timeout,page not found
--6 types of error
begin try
select 1/0
end try
begin catch
select ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE()
end catch;

--condititon statement
--single,multiple
--if and else(single),if ,else if, else(multiple)

--single
declare @age int 
set @age=(select age from student where sid=1)
if (@age>18)
select('you are eligible')
else
select ('you are not eligible')
--multiple
declare @mark int
set @mark= (select mark from student_marks where sid=3)
if (@mark>80 and @mark<=100)
select('Excellent')
else if(@mark>60 and @mark<=80)
select('Good')
else if(@mark>40 and @mark<=60)
select('Average')
else if(@mark<40)
select('reappear')
else
select('check your mark')

--case statement(check more than one input)
select *,case when mark>90 and mark <=100 then 'o'
               when mark>80 and mark <=90 then 'a'
			   when mark>70 and mark <=80 then 'b'
			   else 'check your mark'end from student_marks

---looping statement
--intial varaible declaration and values assignment
--condition checking
--increment or decrement part
declare @i int 
set @i=1
while(@i<=30)
begin
select @i
set @i=@i+1
end
---break and continue statement
declare @j int 
set @j=0
while(@j<10)
begin
if(@j=5)
break
select @j
set @j=@j+1
end
---starting date and ending date (hw)
--method 1(date)
declare @start_date date
declare @end_date date
set @start_date='2025-01-01'
set @end_date='2026-01-01'
while(@start_date<@end_date)
begin
select @start_date
set @start_date=dateadd(day,1,@start_date) 
end
--method 2(datetime)
declare @start_date datetime
declare @end_date datetime
set @start_date='2025-01-01 00:00:00'
set @end_date='2026-01-01 00:00:00'
while(@start_date<@end_date)
begin
select @start_date
set @start_date=@start_date+1
end
--method 3(int)
declare @start_date int
declare @end_date int
set @start_date=20250101
set @end_date=20260101
while(@start_date<@end_date)
begin
select @start_date
set @start_date =convert(int,format(dateadd(day,1,convert
(date,cast(@start_date as char(8)))),'yyyyMMdd'))
end

---cursor(table record arrange one by one)
--declare the variable for columns
--declare cursor
--pass the data to the cursor
--open cursor
--fetch data from the cursor
--use looping statement
--display the fetched data
--fetch data from the cursor
--close looping statement
--close cursor
--deallocate cursor

--types of cursor
--static
--dynamic
--fast_forward
--forward_only

--directions
--first,next,prior,last



declare @smid int;
declare @smname varchar(50);
declare @smdept varchar(50);
declare @smmark int;
declare cursor_1 cursor dynamic
for select sid,sname,department,mark from student_marks where sid=1;
open cursor_1
fetch first from cursor_1 into @smid,@smname,@smdept,@smmark 
while @@FETCH_STATUS=0
begin
select @smid,@smname,@smdept,@smmark
update student_marks set department='IT' where current of cursor_1
fetch next from cursor_1 into @smid,@smname,@smdept,@smmark 
end
close cursor_1
deallocate cursor_1
select*from student_marks;
--user defined function
--1.scalar valued function(single,not in table format output)
--2.inline table valued function(table formatoutput)
--3.multi table valued function(pass table into another table and also create extra column in inside table)


--1.scalar valued function(single,not in table format output)

create function scal_fun()
returns varchar(50)
as begin
return (select sname from student_marks )
end
select dbo.scal_fun()

alter function scal_fun()
returns varchar(50)
as begin
return (select sname from student_marks where sid=1 )
end
select dbo.scal_fun()

create function scal_fun2(@sid int)
returns varchar(100)
as begin
return(select department from student_marks where sid=@sid)
end
select dbo.scal_fun2(10)

--2.inline table value function


create function in_line()
returns table
as
return select * from student_marks 
select * from in_line()

alter function in_line(@id int,@id1 int)
returns table
as
return select * from student_marks where sid between @id and @id1
select * from in_line(5,22)

---3.multi table valued function(more than one table output)

create function multi_fun()
returns @stud table(smid int,smname varchar(50),smdept varchar(50),smarks int,result varchar(50))
as begin
insert into @stud (smid,smname,smdept,smarks)
select sid,sname,department,mark from student_marks
update @stud set result='pass' where smarks>=70
return
end
select * from multi_fun()

alter function multi_fun()
returns @stud table(smid int,smname varchar(50),smdept varchar(50),smarks int,result varchar(50))
as begin
insert into @stud (smid,smname,smdept,smarks)
select sid,sname,department,mark from student_marks
update @stud set result='pass' where smarks>=70
return
end
select * from multi_fun()

--copy data from one table to another table
create table student_mark2( sid int primary key identity(1,1),sname char(50), department varchar(50),mark int);
select * from student_marks;
insert into student_mark values('Arun', 'CSE', 85),
('Bala', 'IT', 78),
('Charan', 'ECE', 88),
('Deepak', 'EEE', 85),
('Eswar', 'MECH', 72),
('Farhan', 'CIVIL', 81),
('Gokul', 'CSE', 90),
('Hari', 'IT', 74),
('Imran', 'ECE', 69),
('Jagan', 'EEE', 88),
('Karthik', 'MECH', 76),
('Lokesh', 'CIVIL', 64),
('Manoj', 'CSE', 92),
('Naveen', 'IT', 71),
('Pradeep', 'ECE', 85),
('Rahul', 'EEE', 73),
('Santhosh', 'MECH', 80),
('Tarun', 'CIVIL', 71),
('Uday', 'CSE', 68),
('Vignesh', 'IT', 89),
('Yogesh', 'ECE', 72),
('Abishek', 'EEE', 82),
('Dinesh', 'MECH', 73),
('Kishore', 'CIVIL', 66),
('Madhan', 'CSE', 91),
('Nithin', 'IT', 79),
('Pranav', 'ECE', 84),
('Rakesh', 'EEE', 73),
('Surya', 'MECH', 82),
('Vijay', 'CIVIL', 65);
select * from student_marks;
truncate table student_mark2;

insert into student_mark2(sname,department,mark)
select sname,department,mark from student_marks;


create function single_cell(@id int)
returns varchar(100)
as begin
return (select concat_ws ('-',smid,smname,smdept,smarks)
from student_marks where smid=@id
end
select dbo.single_cell(10)


---view
--simple

create view view_1
as select * from student_marks
select * from view_1

alter view view_1 with encryption
as select sname as result1,mark as result2 from student_marks
select * from view_1

--complex

create view view_2
as select s.sname as ouput1,d.dname as output2 from student s inner join department d on d.did=s.sid
select * from view_2
exec sp_helptext view_1

alter view view_2 with encryption,schemabinding
as select s.sname as ouput1,d.dname as output2 from dbo.student s inner join dbo.department d on d.did=s.sid
select * from view_2

---trigger
--ddl trigger(database)-one time use of ddl comment
--dml trigger(table)



create table trig_0( id int,name varchar(50),dept varchar(50),mark int,message varchar(50),ins_date datetime) ;
select * from trig_0;

--ddl
create trigger trig_1 on database
for
create_table,alter_table,drop_table as 
print'You are not able to create ,alter or drop tables from the database'
rollback
--testing the ddl
create table test(id int); 

--dml
--after,instead off
create trigger trig_2 on student_marks
after insert as begin
insert into trig_0 select sid,sname,department,mark,'hello',getdate() from inserted
end
insert into student_marks values('Bala', 'IT', 78);
select * from trig_0;
select * from student_marks

--
alter trigger trig_2 on student_marks
instead of  insert as begin
insert into trig_0 select sid,sname,department,mark,'hello',getdate() from inserted
end
insert into student_marks values('Bala', 'IT', 78);
select * from trig_0;
select * from student_marks
--after update

create trigger trig_3 on student_marks
after update  as begin
insert into trig_0 select sid,sname,department,mark,'hello',getdate() from inserted
end
update student_marks set department='mech' where sid=1;
select * from trig_0;
select * from student_marks

--after delete

create trigger trig_4 on student_marks
after update  as begin
insert into trig_0 select sid,sname,department,mark,'hello',getdate() from deleted
end
delete student_marks  where sid=7;
select * from trig_0;
select * from student_marks

--stored procedure

create procedure ins_proc
@name varchar(50),@dep varchar(50),@mark int
as begin 
insert into student_marks values(@name,@dep,@mark)
select * from student_marks
end
exec ins_proc @name='Arun' ,@dep ='IT',@mark=100

--update

create procedure update_pro
@name varchar(50),@id int
as begin
update student_marks set sname=@name where sid=@id
select * from student_marks where sid=@id
end
exec update_pro @name='Anu',@id=9

--delete 

create procedure delete_pro
@id int
as begin
delete from student_marks where sid=@id
select * from student_marks where sid=@id
end
exec delete_pro @id=31

--alter

alter procedure delete_pro
@id int
as begin
delete student_marks where sid=@id
select * from student_marks 
end
exec delete_pro @id=28














