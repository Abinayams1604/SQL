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
