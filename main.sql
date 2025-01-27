

CREATE TABLE Item (
	  ItemName VARCHAR (30) NOT NULL,
  ItemType CHAR(1) NOT NULL,
  ItemColour VARCHAR(10),
  PRIMARY KEY (ItemName));

CREATE TABLE Employee (
  EmployeeNumber SMALLINT UNSIGNED NOT NULL ,
  EmployeeName VARCHAR(10) NOT NULL ,
  EmployeeSalary INTEGER UNSIGNED NOT NULL ,
  DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
  BossNumber SMALLINT UNSIGNED NOT NULL REFERENCES Employee,
  PRIMARY KEY (EmployeeNumber));

CREATE TABLE Department (
  DepartmentName VARCHAR(10) NOT NULL,
  DepartmentFloor SMALLINT UNSIGNED NOT NULL,
  DepartmentPhone SMALLINT UNSIGNED NOT NULL,
  EmployeeNumber SMALLINT UNSIGNED NOT NULL REFERENCES 
    Employee,
  PRIMARY KEY (DepartmentName));

CREATE TABLE Sale (
  SaleNumber INTEGER UNSIGNED NOT NULL,
  SaleQuantity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  ItemName VARCHAR(30) NOT NULL REFERENCES Item,
  DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
  PRIMARY KEY (SaleNumber));

CREATE TABLE Supplier (
  SupplierNumber INTEGER UNSIGNED NOT NULL,
  SupplierName VARCHAR(30) NOT NULL,
  PRIMARY KEY (SupplierNumber));

CREATE TABLE Delivery (
  DeliveryNumber INTEGER UNSIGNED NOT NULL,
  DeliveryQuantity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  ItemName VARCHAR(30) NOT NULL REFERENCES Item,
  DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
  SupplierNumber INTEGER UNSIGNED NOT NULL REFERENCES  
     Supplier,
  PRIMARY KEY (DeliveryNumber));

-- using the data in the text files, insert into the tables this information

INSERT INTO Delivery (DeliveryNumber,DeliveryQuantity,ItemName,DepartmentName,SupplierNumber)
VALUES 
  (51,	50,	'Pocket knife-Nile',	'Navigation',	105),
  (52,	10,	'Pocket knife-Nile',	'Books',	105),
  (53,	10,	'Pocket knife-Nile',	'Clothes',	105),
  (54,	10,	'Pocket knife-Nile',	'Equipment',	105),
  (55,	10,	'Pocket knife-Nile',	'Furniture',	105),
  (56,	10,	'Pocket knife-Nile',	'Recreation',	105),
  (57,	50,	'Compass',	'Navigation',	101),
  (58,	10,	'Geo positioning system',	'Navigation',	101),
  (59,	10,	'Map measure',	'Navigation',	101),
  (60,	25,	'Map case',	'Navigation',	101),
  (61,	2,	'Sextant',	'Navigation',	101),
  (62,	1,	'Sextant',	'Equipment',	105),
  (63,	20,	'Compass',	'Equipment',	103),
  (64,	1,	'Geo positioning system',	'Books',	103),
  (65,	15,	'Map measure',	'Navigation',	103),
  (66,	1,	'Sextant',	'Books',	103),
  (67,	5,	'Sextant',	'Recreation',	102),
  (68,	3,	'Sextant',	'Navigation',	104),
  (69,	5,	'Boots-snakeproof',	'Clothes',	105),
  (70,	15,	'Pith Helmet',	'Clothes',	105),
  (71,	1,	'Pith Helmet',	'Clothes',	105),
  (72,	1,	'Pith Helmet',	'Clothes',	101),
  (73,	1,	'Pith Helmet',	'Clothes',	103),
  (74,	1,	'Pith Helmet',	'Clothes',	104),
  (75,	5,	'Pith Helmet',	'Navigation',	105),
  (76,	5,	'Pith Helmet',	'Books',	105),
  (77,	5,	'Pith Helmet',	'Equipment',	105),
  (78,	5,	'Pith Helmet',	'Furniture',	105),
  (79,	5,	'Pith Helmet',	'Recreation',	105),
  (80,	10,	'Pocket knife-Nile',	'Navigation',	102),
  (81,	1,	'Compass',	'Navigation',	102),
  (82,	1,	'Geo positioning system',	'Navigation',	102),
  (83,	10,	'Map measure',	'Navigation',	102),
  (84,	5,	'Map case',	'Navigation',	102),
  (85,	5,	'Compass',	'Books',	102),
  (86,	5,	'Pocket knife-Avon',	'Recreation',	102),
  (87,	5,	'Tent - 2 person',	'Recreation',	102),
  (88,	2,	'Tent - 8 person',	'Recreation',	102),
  (89,	5,	'Exploring in 10 Easy Lessons',	'Navigation',	102),
  (90,	5,	'How to Win Foreign Friends',	'Navigation',	102),
  (91,	10,	'Exploring in 10 Easy Lessons',	'Books',	102),
  (92,	10,	'How to Win Foreign Friends',	'Books',	102),
  (93,	2,	'Exploring in 10 Easy Lessons',	'Recreation',	102),
  (94,	2,	'How to Win Foreign Friends',	'Recreation',	102),
  (95,	5,	'Compass',	'Equipment',	105),
  (96,	2,	'Boots-snakeproof',	'Equipment',	105),
  (97,	20,	'Pith Helmet',	'Equipment',	106),
  (98,	20,	'Pocket knife-Nile',	'Equipment',	106),
  (99,	1,	'Sextant',	'Equipment',	106),
  (100,	3,	'Hat-Polar Explorer',	'Clothes',	105),
  (101,	3,	'Stetson',	'Clothes',	105);
