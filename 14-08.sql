create database joinExDb

use JoinExDb
create table Depts
(DId int primary key,
DName nvarchar(50) not null unique)
insert into Depts values (1, 'App-Development'),
(2,'HR'),
(3, 'Account'),
(4, 'Agile-Scrum')
select * from Depts order by DId

create table Emps
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
Designation nvarchar(50),
Salary float,
DId int)
insert into Emps values(1,'Ajay','Kiran','Developer',87000.90,2)
insert into Emps values(2,'Vijay','Bhaskar','Developer',87000.90,1)
insert into Emps values(3,'Kiran','Kumar','Developer',87000.90,1)
insert into Emps values(9,'Rajiv','Kishan','Developer',87000.90,2)

insert into Emps(Id,Fname,Lname,Salary) values (5, 'Raj','Kiran',88000.50)
insert into Emps values (12, 'Deep', 'Goyal','Developer',88000.30,2)
insert into Emps(Id,Fname,Lname,Designation,Salary) values (13,'Naina','Singh','Manager','67000.90')
insert into Emps values(15, 'Arsh','K.','HR',76000.90,3)

select *from Emps
select *from Depts


select e.Id, e.Fname,e.Lname, d.DId, e.Salary,e.Designation,d.Dname 'Department'
from Emps e left outer join Depts d on e.DId=d.DId


select e.Id, e.Fname,e.Lname, d.DId, e.Salary,e.Designation,d.Dname 'Department'
from Emps e right outer join Depts d on e.DId=d.DId


select e.Id, e.Fname,e.Lname, d.DId, e.Salary,e.Designation,d.Dname 'Department'
from Emps e full outer join Depts d on e.DId=d.DId



create table Sizes
(SID int primary key,
Size nvarchar(50) not null unique)

create table Colors
(CId int primary key,
Color nvarchar(50) not null unique)

insert into Sizes values (1,'s'),(2,'m'),(3,'l')
insert into Colors values(1,'Blue'),(2,'Green'),(3,'White')


select Size,Color from Sizes cross join Colors
insert into Sizes values (4,'xl')

select Size,Color from Sizes cross join Colors


--self join

create table Employee (Id int primary key,
Fname nvarchar (50) not null,
Lname nvarchar (50) not null,
ManagerId int)
insert into Employee (Id,Fname,Lname) values (1, 'Sam', 'Dicosta')
insert into Employee values (3, 'Niraj', 'Kumar',5)
insert into Employee values (4, 'varun', 'sharma',1)
insert into Employee values (6, 'vippin', 'singh',1)
insert into Employee values (8, 'gagan', 'Kumar',2)
insert into Employee values (9, 'gaurav', 'Kumar',1)
insert into Employee values (10, 'rohit', 'sharma',2)
insert into Employee (Id,Fname,Lname) values (5, 'ravi', 'm')
insert into Employee (Id,Fname,Lname) values (2, 'raju', 'k')
select * from Employee

select e1.Fname+'   '+e1.Lname as 'EmployeeName',e2.Fname+'   '+e2.Lname as 'Manager name'
from Employee e1 join Employee e2
on e1.ManagerId=e2.Id


select * from Emps
select sum(Salary) as 'Total Salray' from Emps
select avg(Salary) as 'Average Salary' from Emps
select max(Salary) as 'Max Salary' from Emps
select min(Salary) as 'Minimum Salary' from Emps

select UPPER('india')
select lower('indiA')
select left('india',2)
select right('india',3)
select ltrim('      india           ')
select rtrim('         india    ')
select trim('         india     ')
select upper(fname),upper(lname) from  Employee



select upper(left(fname,1))+'.'+ upper(left(lname,1)) from  Employee



select UPPER ( left(fname,1)) +'.'+ UPPER (left(lname,1))'.'from Employee


create table Customer
(Id int primary key,
Name nvarchar(50) not null,
ODLimit float not null,
SStarDate date not null,
SEndDate date not null)
insert into Customer values (1,'sam',594564,'12/12/2019','12/12/2024'), (2,'ram',894564,'12/12/2019','12/12/2022'), (3,'jyo',595246,'12/12/2023','12/12/2025')

select GETDATE()
SELECT DATEPART(day,getDate())
SELECT DATEPART(month,getDate())

SELECT DATEPART(year,getDate())

select DATEDIFF(YEAR,'12/12/2000',GETDATE())

select Datepart(month,SStarDate) from Customer
select datepart(month,SEndDate) as 'End Month',DatePart(year,SEndDate) as 'End Year' from Customer
-------------------------------------------------------------------------------

create function fnFullName
(
@fn nvarchar(50),
@ln nvarchar(50)
)
returns nvarchar(101)
as
begin
return (select @fn+' '+@ln)
end

select dbo.fnFullName('Raj','kumar')as 'Full Name'
select Fname,Lname, dbo.fnFullName(fname,lname) as 'Full Employee Name'from Emps
-----------------------------------------------------------------------------------
create function BonousCalc
(@sal float)
returns float
as
begin
return (select @sal*0.15)
end
select dbo.BonousCalc(50000)

select Fname,Lname,Salary,dbo.BonousCalc(Salary) as 'Bonous' from Emps



-------------------------------------------------------------------------------------------
create table Products
(PId int primary key,
PName nvarchar (50) not null,
Pprice float )

create schema samsung

create table samsung.Products
(PId int primary key,
PName nvarchar (50) not null , 
Pprice float)
insert into samsung.Products values (1,'ac',42000)

create schema lg;

create table lg.Products 
(PId int primary key,
PName nvarchar (50) not null,
Pprice float)
insert into lg.Products values (1,'Washing Machine ',23000)
insert into lg.Products values (2,'TV',45000)
insert into lg.Products values (12,'Mobile',34000)

create function lg.fnTax

(
@price float
)
returns float
as 
begin
declare @tax float;
if(@price >=25000)
begin 
select @tax = @price*0.18
end
else
begin
select @tax = @price*0.10
end 
return @tax;
end
select lg.fnTax(42000) as 'Tax'

select PId,PName,Pprice, lg.fnTax(PPrice) as 'GST' from lg.Products
select PId,PName,Pprice, lg.fnTax(PPrice) as 'GST' from samsung.Products

drop table Products
create table Products
(PId int primary key,
PName nvarchar(50) not null,
Pprice float,
PCategory nvarchar(50) not null check (PCategory in('Clothing','Grooming','Electronic','Other')))
insert into Products values (1,'Facewash',230,'Grooming'),(2,'TV',45000,'Electronic'),(12,'Mobile',34000,'Electronic'),(5,'Face Cream',250,'Grooming')
select * from Products
select sum(Pprice) as 'Total Products Values' from Products
select sum(Pprice) as 'Sub Total',PCategory from Products group by PCategory




--------------------------

create table Expenses
(ExpId int primary key identity,
ExpAmount float,
ExpCat nvarchar(50) not null check (ExpCat in ('Stationary','Electronic','Other')),
ExpDate date default getdate())
insert into Expenses values (1200.50,'Sataionary','12/12/2022')
insert into Expenses(ExpAmount,ExpCat) values (72000.50,'Electronic')
insert into Expenses values (52400.50,'Electronic','12/12/2022')
insert into Expenses values (2300.50,'Sataionary','12/12/2022')
insert into Expenses values (1500.50,'Sataionary','12/12/2022')
insert into Expenses values (1500.50,'Other','12/12/2022')
insert into Expenses(ExpAmount,ExpCat) values (1300.50,'Stationary')
insert into Expenses values (1400.50,'Other','12/12/2022')

select * from Expenses
select sum (ExpAmount) as 'Total Exp' from expenses
select sum (ExpAmount) as 'Category wise Total',ExpCat from Expenses group by ExpCat
select sum (ExpAmount) as 'Category wise Total',ExpCat from Expenses group by ExpCat
select sum (ExpAmount) as 'Category wise Total',ExpCat from Expenses where
ExpAmount>=(select avg (ExpAmount) from Expenses)
group by ExpCat having ExpCat='Electronic'
-------------------------------------------------------------------------------------------------
create database exercise1408db
create table CompanyInfo
(CId int primary key,
CName nvarchar(50) not null
)
insert into CompanyInfo values (1,'SamSung'),(2,'HP'),(3,'Apple'),(4,'Dell'),(5,'Toshiba'),(6,'Redmi')

use exercise1408db
create table ProductInfo
( PId int primary key not null,
PName nvarchar(50),
PPrice float,
PMDate date,
CId int foreign key references CompanyInfo) 


insert into ProductInfo values (101,'Laptop','55000.90','12/12/23',1),(102,'Laptop','35000.90','12/12/12',2),(103,'Mobile','15000.90','12/03/12',2),(104,'Laptop','135000.90','12/12/12',3),(105,'Mobile','65000.90','12/12/23',3),(106,'Laptop','35000.90','12/12/23',5),(107,'Mobile','35000.90','12/01/23',5),(108,'Earpod','1000.90','12/01/23',3),(109,'Laptop','85000.90','12/12/21',6),(110,'Mobile','55000.70','12/12/20',1)

select * from CompanyInfo join ProductInfo on ProductInfo.CId=CompanyInfo.CId order by CName;


SELECT PName, CName
FROM ProductInfo
JOIN CompanyInfo ON ProductInfo.CId = CompanyInfo.CId
ORDER BY PName;




SELECT CName, PName
FROM CompanyInfo
CROSS JOIN ProductInfo
ORDER BY CName, PName;



--------------------------------

create table Products
(PId int ,PQ int, PPrice int,Discount float)
insert into Products values (1,1,10,'5'),(2,1,15,'6'),(3,2,30,'10')

select PPrice ,Discount,PQ,
PPrice * PQ AS TotalPrice,
PPrice * PQ - (PPrice * PQ * Discount / 100) AS PriceAfterDiscount
from Products