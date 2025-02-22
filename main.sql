create database Hospital;
use Hospital;
go
CREATE TABLE Departments
(
    Id        INT IDENTITY (1,1) PRIMARY KEY,
    Building  INT           NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY         NOT NULL CHECK (Financing >= 0) DEFAULT 0,
    Floor     INT           NOT NULL CHECK (Floor >= 1),
    Name      NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> '')
);

CREATE TABLE Diseases
(
    Id       INT IDENTITY (1,1) PRIMARY KEY,
    Name     NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> ''),
    Severity INT           NOT NULL CHECK (Severity >= 1) DEFAULT 1
);

CREATE TABLE Doctors
(
    Id      INT IDENTITY (1,1) PRIMARY KEY,
    Name    NVARCHAR(MAX) NOT NULL CHECK (Name <> ''),
    Phone   CHAR(10)      NOT NULL,
    Premium MONEY         NOT NULL CHECK (Premium >= 0) DEFAULT 0,
    Salary  MONEY         NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL CHECK (Surname <> '')
);

CREATE TABLE Examinations
(
    Id        INT IDENTITY (1,1) PRIMARY KEY,
    DayOfWeek INT           NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    EndTime   TIME          NOT NULL,
    Name      NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> ''),
    StartTime TIME          NOT NULL CHECK (StartTime BETWEEN '08:00' AND '18:00')
);

CREATE TABLE Wards
(
    Id       INT IDENTITY (1,1) PRIMARY KEY,
    Building INT          NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Floor    INT          NOT NULL CHECK (Floor >= 1),
    Name     NVARCHAR(20) NOT NULL UNIQUE CHECK (Name <> '')
);


insert into Departments (Building, Floor, Name, Financing) values (1, 1, 'Cardiology', 20000);
insert into Departments (Building, Floor, Name, Financing) values (2, 2, 'Neurology', 40000);
insert into Departments (Building, Floor, Name, Financing) values (5, 3, 'Oncology', 30000);
insert into Departments (Building, Floor, Name, Financing) values (5, 4, 'Pediatrics', 20000);
insert into Departments (Building, Floor, Name, Financing) values (5, 5, 'Gynecology', 10000);
insert into Departments (Building, Floor, Name, Financing) values (3, 6, 'Urology', 14000);
insert into Departments (Building, Floor, Name, Financing) values (3, 7, 'Dermatology', 13000);
INSERT INTO Departments (Building, Floor, Name, Financing)
VALUES (3, 2, 'Radiology', 9000);
INSERT INTO Departments (Building, Floor, Name, Financing)
VALUES (5, 3, 'Orthopedics', 26000);
go
insert into Wards (Building, Floor, Name) values (1, 1, 'A1');
insert into Wards (Building, Floor, Name) values (1, 1, 'A2');
insert into Wards (Building, Floor, Name) values (1, 1, 'A3');
insert into Wards (Building, Floor, Name) values (5, 1, 'A4');
go

SELECT * FROM Wards;

insert into Diseases (Name, Severity) values ('Flu', 1);
insert into Diseases (Name, Severity) values ('Covid', 2);
insert into Diseases (Name, Severity) values ('Cancer', 3);
insert into Diseases (Name, Severity) values ('AIDS', 4);
go
insert into Doctors (Name, Phone, Premium, Salary, Surname) values ('John', '1234567890', 1000, 10000, 'Doe');
insert into Doctors (Name, Phone, Premium, Salary, Surname) values ('Jane', '1234567890', 1000, 10000, 'Doe');
insert into Doctors (Name, Phone, Premium, Salary, Surname) values ('Jack', '1234567890', 1000, 10000, 'Doe');
INSERT INTO Doctors (Name, Phone, Premium, Salary, Surname)
VALUES ('Nancy', '0987654321', 1500, 12000, 'Newton');
insert into Doctors (Name, Phone, Premium, Salary, Surname) values ('Jill', '1234567890', 1000, 10000, 'Doe');
go
INSERT INTO Examinations (DayOfWeek, StartTime, EndTime, Name)
VALUES (1, '12:30', '14:00', 'Blood Test');

INSERT INTO Examinations (DayOfWeek, StartTime, EndTime, Name)
VALUES (2, '13:00', '14:30', 'X-Ray');

INSERT INTO Examinations (DayOfWeek, StartTime, EndTime, Name)
VALUES (3, '12:15', '14:45', 'MRI');
go
select Surname, Phone from Doctors;
go
select distinct Floor from Wards;
go
select Name as "Name of Disease", Severity as "Severity of Disease" from Diseases;
go
select d.Name as DoctorName, w.Name as WardName, dis.Name as DiseaseName
from Doctors as d
         join Wards as w on d.Id = w.Id
         join Diseases as dis on d.Id = dis.Id;
go
select Name
from Departments
where Building = 5 and Financing < 30000;
go
SELECT Name
FROM Departments
WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000;

select Name
from Wards
where (Building = 4 or Building = 5) and Floor = 1;

select Name, Financing, Building
from Departments
where (Building = 3 or Building = 6) and (Financing < 11000 or Financing > 25000);

select Surname
from Doctors
where (Salary + Premium) > 1500;

select Surname
from Doctors
where (Salary/2) > (Premium * 3);

select distinct Name
from Examinations
where DayOfWeek IN (1, 2, 3) and StartTime > '12:00' and EndTime < '15:00';

SELECT Name, Building
FROM Departments
WHERE Building IN (1, 3, 8, 10);

SELECT Name
FROM Diseases
WHERE Severity NOT IN (1, 2);

SELECT Name
FROM Departments
WHERE Building NOT IN (1, 3);

SELECT Name
FROM Departments
WHERE Building IN (1, 3);

SELECT Surname
FROM Doctors
WHERE Surname LIKE 'N%';

use master;
drop database Hospital;