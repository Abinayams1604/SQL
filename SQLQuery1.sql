create database Abi;
create table student(id int,name varchar(50),city varchar(50));
insert into student values(1,'rose','chennai');
select * from student;
insert into student(id,name) values(2,'jack');
insert into student values(3,'liah','Tvl');
create table class(id int primary key,name varchar(50));
insert into class values(1,'jaya');
select * from class;
insert into class(name) values('sutha');
create table sub(id int primary key identity(1,1),name varchar(50));
select * from sub;
insert into sub values('ram');

