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
