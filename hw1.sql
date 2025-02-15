create database Academy;
go
use Academy;
go
create table Departments
(
    Id        int identity (1,1) not null primary key,
    Financing money              not null check (Financing >= 0) default 0,
    Name      nvarchar(100)      not null check (Name <> '') unique
);
go
create table Faculties
(
    Id   int identity (1,1) not null primary key,
    Dean nvarchar(max)      not null check (Dean <> ''),
    Name nvarchar(100)      not null check (Name <> '') unique
);
go
create table Groups
(
    Id     int identity (1,1) not null primary key,
    Name   nvarchar(10)       not null unique check (Name <> ''),
    Rating int                not null check (Rating between 0 and 5),
    Year   int                not null check (Year between 1 and 5)
);
go
create table Teachers
(
    Id             int identity (1,1) not null primary key,
    EmploymentDate date               not null check (EmploymentDate >= '1990-01-01'),
    IsAssistant    bit                not null                      default 0,
    IsProfessor    bit                not null                      default 0,
    Name           nvarchar(max)      not null check (Name <> ''),
    Position       nvarchar(max)      not null check (Position <> ''),
    Premium        money              not null check (Premium >= 0) default 0,
    Salary         money              not null check (Salary >= 0),
    Surname        nvarchar(max)      not null check (Surname <> '')
);
go
insert into Departments (Financing, Name)
values (15000, 'Mathematics');
insert into Departments (Financing, Name)
values (12000, 'Physics');
insert into Departments (Financing, Name)
values (10000, 'Computer Science');
insert into Departments (Financing, Name)
values (8000, 'Biology');

insert into Faculties (Dean, Name)
values ('Volodymir Ignacevich', 'Engineering');
insert into Faculties (Dean, Name)
values ('Ivanov Ivanov', 'Arts');
insert into Faculties (Dean, Name)
values ('Alice Brown', 'Computer Science');

insert into Groups (Name, Rating, Year)
values ('Group A', 4, 1);
insert into Groups (Name, Rating, Year)
values ('Group B', 3, 2);
insert into Groups (Name, Rating, Year)
values ('Group C', 2, 5);

insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
values ('1995-05-20', 0, 1, 'Alice Johnson', 'Professor', 500, 2000, 'Johnson');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
values ('2001-09-15', 1, 0, 'Andrey Atamanenko', 'Assistant', 300, 1500, 'Brown');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
values ('1998-03-10', 1, 0, 'Vlad Sinchanskyi', 'Assistant', 200, 1000, 'Davis');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
values ('1992-07-25', 0, 1, 'Vova Kustov', 'Professor', 600, 2500, 'Evans');
go
select Name, Financing, Id
from Departments
order by Id desc;
go
select Name as [Group Name], Rating as [Group Rating]
from Groups;
go
select Surname,
       (Premium / Salary) * 100             as [Premium Percentage of Salary],
       (Premium / (Salary + Premium)) * 100 as [Premium Percentage of Total Compensation]
from Teachers;
go
select 'The dean of faculty ' + Name + ' is ' + Dean as [Faculty Info]
from Faculties;
go
select Surname
from Teachers
where IsProfessor = 1
  and Salary > 1050;
go
select Name
from Departments
where Financing < 11000
   or Financing > 25000;
go
select Name
from Faculties
where Name <> 'Computer Science';
go
select Surname, Position
from Teachers
where IsProfessor = 0;
go
select Surname, Position, Salary, Premium
from Teachers
where IsAssistant = 1
  and Premium between 160 and 550;
go
select Surname, Salary
from Teachers
where IsAssistant = 1;
go
select Surname, Position
from Teachers
where EmploymentDate < '2000-01-01';
go
select Name as [Name of Department]
from Departments
where Name < 'Software Development'
order by Name;
go
select Surname
from Teachers
where IsAssistant = 1
  and (Salary + Premium) <= 1200;
go
select Name
from Groups
where Year = 5
  and Rating between 2 and 4;
go
select Surname
from Teachers
where IsAssistant = 1
  and (Salary < 550 or Premium < 200);

use Academy;
go
if object_id('Departments', 'U') is not null drop table Departments;
if object_id('Faculties', 'U') is not null drop table Faculties;
if object_id('Groups', 'U') is not null drop table Groups;
if object_id('Teachers', 'U') is not null drop table Teachers;
go