-- checking the inserted data
select * from delivery;
select * from department;
select * from item;
select * from employee;
select * from sale;
select * from supplier;

-- test queries

-- 1. What are the names of employees in the Marketing Department?
select EmployeeName from Employee 
where DepartmentName = 'Marketing';

-- Answer: 

-- Ned, Andrew, Clare

-- 2. Find the items sold by the departments on the second floor.
select distinct ItemName from Sale, Department 
where Sale.DepartmentName = Department.DepartmentName AND Department.DepartmentFloor = 2;

-- Answer: 

-- Boots-snakeproof, Pith Helmet, Hat-Polar Explorer, Pocket knife-Nile, Sextant, Elephant polo stick, Camel Saddle

select distinct ItemName from (Sale NATURAL JOIN Department)
where Department.DepartmentFloor = 2;

-- Answer: Boots-snakeproof, Pith Helmet, Hat-Polar Explorer, Pocket knife-Nile, Sextant, Elephant polo stick, Camel Saddle

select distinct ItemName from (Sale JOIN Department)
where Department.DepartmentFloor = 2;

-- Answer: 

-- Boots-snakeproof, Pith Helmet, Sextant, Hat-Polar Explorer, Pocket knife-Nile, Compass,
-- Geo positioning system, Map measure, Exploring in 10 Easy Lessons, How to Win Foreign Friends, Elephant polo stick, Camel Saddle

-- 3. Identify by floor the items available on floors other than the second floor
select distinct ItemName, Department.DepartmentFloor as 'On Floor'
from Delivery, Department
where Delivery.DepartmentName = Department.DepartmentName and Department.DepartmentFloor <> 2
order by Department.DepartmentFloor, ItemName;

-- Answer:

-- ItemName	On Floor
-- Compass	1
-- Exploring in 10 Easy Lessons	1
-- Geo positioning system	1
-- How to Win Foreign Friends	1
-- Map case	1
-- Map measure	1
-- Pith Helmet	1
-- Pocket knife-Nile	1
-- Sextant	1
-- Boots-snakeproof	3
-- Compass	3
-- Pith Helmet	3
-- Pocket knife-Nile	3
-- Sextant	3
-- Pith Helmet	4
-- Pocket knife-Nile	4

-- 4. Find the average salary of the employees in the Clothes department
select AVG(EmployeeSalary) from Employee where DepartmentName = 'Clothes';

-- Answer:

-- AVG(EmployeeSalary)
-- 16000.0

-- 5. Find, for each department, the average salary of the employees in that department and report by descending salary.
select DepartmentName, AVG(EmployeeSalary) as 'Average Salary' from Employee
group by DepartmentName order by 'Average Salary' desc;

-- Answer:

-- DepartmentName	Average Salary
-- Recreation	15000.0
-- Purchasing	49500.0
-- Personnel	35000.0
-- Navigation	15000.0
-- Marketing	30666.6666666667
-- Management	75000.0
-- Furniture	15000.0
-- Equipment	13000.0
-- Clothes	16000.0
-- Books	15000.0
-- Accounting	30000.0

-- 6. List the items delivered by exactly one supplier (i.e. the items always delivered by the same supplier).
select ItemName from Delivery 
Group By ItemName HAVING COUNT(Distinct SupplierNumber) = 1;

-- Answer:

-- ItemName
-- Boots-snakeproof
-- Exploring in 10 Easy Lessons
-- Hat-Polar Explorer
-- How to Win Foreign Friends
-- Pocket knife-Avon
-- Stetson
-- Tent - 2 person
-- Tent - 8 person

-- 7. List the suppliers that deliver at least 10 items.
select Supplier.SupplierNumber, Supplier.SupplierName 
from (Supplier NATURAL JOIN Delivery)
group by Supplier.SupplierNumber, Supplier.SupplierName
HAVING COUNT (DISTINCT Delivery.ItemName) >= 10;

-- Answer:

-- SupplierNumber	SupplierName
-- 102	Nepalese Corp.

select Supplier.SupplierNumber, Supplier.SupplierName 
from Delivery, Supplier
where Delivery.SupplierNumber = Supplier.SupplierNumber 
group by Supplier.SupplierNumber, Supplier.SupplierName 
HAVING COUNT(DISTINCT Delivery.ItemName) >= 10;

-- Answer:

-- SupplierNumber	SupplierName
-- 102	Nepalese Corp.

-- 8. Count the number of direct employees of each manager
select Boss.EmployeeNumber, Boss.EmployeeName, COUNT(*) AS 'Employees'
from Employee as Worker, Employee as Boss
where Worker.BossNumber = Boss.EmployeeNumber
group by Boss.EmployeeNumber, Boss.EmployeeName;

-- Answer:

-- EmployeeNumber	EmployeeName	Employees
-- 1	Alice	4
-- 2	Ned	2
-- 3	Andrew	5
-- 4	Clare	3
-- 5	Todd	1
-- 7	Brier	1

-- 9. Find, for each department that sells items of type 'E' the average salary of the employees.
select Department.DepartmentName, AVG(EmployeeSalary) as 'Average Salary'
from Employee, Department, Sale, Item 
where 
    Employee.DepartmentName = Department.DepartmentName and 
    Department.DepartmentName = Sale.DepartmentName and 
    Sale.ItemName = Item.ItemName and 
    ItemType = 'E'
group by Department.DepartmentName;

-- Answer:

-- DepartmentName	Average Salary
-- Books	15000.0
-- Clothes	16000.0
-- Equipment	13000.0
-- Furniture	15000.0
-- Navigation	15000.0
-- Recreation	15000.0

-- 10. Find the total number of items of type 'E' sold by departments on the second floor
select SUM(SaleQuantity) as 'Number of Items' 
from Department, Sale, Item
where
     Department.DepartmentName = Sale.DepartmentName and
     Sale.ItemName = Item.ItemName and 
     ItemType = 'E' and
     DepartmentFloor = '2';

-- Answer:

-- Number of Items
-- 2

select SUM(SaleQuantity) as 'Number of Items' 
from Sale NATURAL JOIN Item, Department
where
    Department.DepartmentName = Sale.DepartmentName and
    ItemType = 'E' and
    Department.DepartmentFloor = '2';

-- Answer:

-- Number of Items
-- 2

select SUM(SaleQuantity) as 'Number of Items' 
from ((Sale NATURAL JOIN Item) NATURAL JOIN Department)
where
    --Department.DepartmentName = Sale.DepartmentName and
    ItemType = 'E' and
    Department.DepartmentFloor = '2';

-- Answer:

-- Number of Items
-- 2

-- 11. What is the average delivery quantity of items of type 'N' delivered by each company?
select Delivery.SupplierNumber, SupplierName, Delivery.ItemName, AVG(Delivery.DeliveryQuantity) as 'Average Quantity'
from ((Delivery NATURAL JOIN Supplier) NATURAL JOIN Item) 
where Item.ItemType = 'N'
group by 
    Delivery.SupplierNumber,
    SupplierName, 
    Delivery.ItemName 
order by 
    Delivery.SupplierNumber, 
    SupplierName,
    'Average Quantity' DESC, 
    Delivery.ItemName;

-- Answer:

-- SupplierNumber	SupplierName	ItemName	Average Quantity
-- 101	Global Maps and Books	Compass	50.0
-- 101	Global Maps and Books	Geo positioning system	10.0
-- 101	Global Maps and Books	Map measure	10.0
-- 101	Global Maps and Books	Sextant	2.0
-- 102	Nepalese Corp.	Compass	3.0
-- 102	Nepalese Corp.	Geo positioning system	1.0
-- 102	Nepalese Corp.	Map measure	10.0
-- 102	Nepalese Corp.	Sextant	5.0
-- 103	All Sports Manufacturing	Compass	20.0
-- 103	All Sports Manufacturing	Geo positioning system	1.0
-- 103	All Sports Manufacturing	Map measure	15.0
-- 103	All Sports Manufacturing	Sextant	1.0
-- 104	Sweatshops Unlimited	Sextant	3.0
-- 105	All Points inc.	Compass	5.0
-- 105	All Points inc.	Sextant	1.0
-- 106	Sao Paulo Manufacturing	Sextant	1.0

