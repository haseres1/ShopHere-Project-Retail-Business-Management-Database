--_______________________________________________________
--create database [ShopHere Project]
use [ShopHere Project]
go

create table Employee ----------------------------------------------------------------------------Table one
		(EmployeeID int identity(1,1),
		FirstName varchar(40) Not Null,
		LastName varchar(40) Not Null,
		City varchar(20) Not Null,
		Phone varchar(20)  
		check(phone like '[0-9][0-9][0-9][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'
		 ) Not Null);
alter table Employee
add primary key(EmployeeId)
Go
insert into employee values('yitbark', 'aseres', 'Silverspring', '301-670-2450'),
('david', 'getachew', 'virgina', '240-679-8510'),
('tariku', 'setegn', 'rochester', '585-349-2321'),
('martha', 'henok', 'denmark', '740-124-5465'),
('temesegen', 'alex', 'sewden', '301-430-1923')

select * from employee  
--____________________________________________________________________________________________________
create table ProductCategory ----------------------------------------------------------------------------Table two
		(CategoryID  int primary key identity(1,1), 
		categoryName varchar(50) Not Null check(CategoryName in ('Household','Sports','Accessories','Clothing')),
		CategoryDescription varchar(100) Not Null);
		--CategoryName varchar(40) check (CategoryName='Household' or categoryName='Sports'or categoryName='Accessories'or 
		--categoryName='Clothing') Not Null,
		--truncate table ProductCategory
		--set IDENTITY_INSERT ProductCategory on
		--DBCC Checkident(ProductCategory,reseed, 0)

insert into ProductCategory values('Household', 'you can buy the house' ),
('sports','The schudule for GIM sport is monday to friday'),
( 'Accessories', 'The part for you car is shipped'),
('Clothing', 'your cloth is shipped')

select * from ProductCategory
--____________________________________________________________________________________________________

create table SupplierDetails----------------------------------------------------------------------------Table three
		(SupplierID int primary key identity(1,1),
		FirstName varchar(40) Not Null,
		LastName varchar(40) Not Null,
		[Address] varchar(50) Not Null,
		Phone varchar(20) check(phone like '[0-9][0-9][0-9][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'
		 ) Not Null ,Country varchar(30) Not Null);
		go		
ALTER TABLE [dbo].SupplierDetails  WITH CHECK ADD CONSTRAINT CK_phone_SupplierDetails
CHECK  (([phone] like '[0-9][0-9][0-9][-][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'))

select * from sys.check_constraints

insert into SupplierDetails values
('Bruk','getachew', '1245 georgia ave', '301-432-4364', 'USA'),
('yitbark','aseres', '2321 randolph ave', '240-432-4364', 'Canada'),
('bereket','adane', '4598 texas ave', '301-123-4364', 'Ethiopia'),
('Alex','david', '1345 alexa ave', '301-432-1242', 'USA'),
('Elizabeth','bekalu', '1345 georgia ave', '230-123-4364', 'USA'),
('david','getachew', '2132 virgnia ave', '230-432-4364', 'USA')

select * from SupplierDetails
--____________________________________________________________________________________________________
		create table ItemDetails(ItemID int identity(1,1),---------------------------------------------------------------Table four
		 ItemName varchar(30) Not Null,
		ItemDescription varchar(100) Not Null,
		UnitPrice money check(UnitPrice>0),
		QuantityInHand int check(QuantityInHand>0),
		--The record should not be inserted or modified manually if QuantityInHand is 0.
		ReorderLevel varchar(20) check(ReorderLevel>0),
		ReorderQuantity int check(ReorderQuantity>0),
		CategoryID int foreign key references ProductCategory(CategoryId) on delete set null,
		SupplierID int foreign key references SupplierDetails(SupplierID));
		Go

alter table ItemDetails
add primary key(ItemID)

--set IDENTITY_INSERT ItemDetails off
--(ItemID,ItemName,ItemDescription,UnitPrice, QuantityInHand, ReorderLevel, ReorderQuantity, CategoryID, SupplierID)
--values('men shoes', 'new realese adidas',12,2, 5, 6, 4, 4)

--set IDENTITY_INSERT ItemDetails off
insert into ItemDetails values
('women dress', 'long sleve',20,3, 5, 6, 4, 5),
('men jacket', 'large size',10,3, 3, 4, 1, 4),
('women socks', 'medium size',30,1, 6, 8, 2, 1),
('men socks', 'small',12,2, 5, 4, 3, 6),
('men tishrt', 'adidas',11,8, 3, 12, 2, 1)

--(ItemName,ItemDescription,UnitPrice, QuantityInHand, ReorderLevel, ReorderQuantity, CategoryID, SupplierID)
--values('women dress', 'long sleve',20,3, 5, 6, 4, 5)
--sp_help itemdetails
select * from ItemDetails
--____________________________________________________________________________________________________
 create table OrderDetails(PurchaseOrderID INT identity(1,1),-------------------------------------------------------Table five
		EmployeeID int,
		OrderDate datetime default cast(getdate()as varchar(20))
		check(OrderDate<=cast(Getdate()as varchar(20))),
		ReceivingDate datetime ,
		ItemID int,
		QuantityOrdered int check(Quantityordered>0),
		QuantityReceived int check(QuantityReceived>0)  Null,
		UnitPrice money check(UnitPrice>0),
		ShipMethod varchar(20),
		OrderStatus varchar(50) check(orderstatus='InTransit' or
		orderstatus='Received'or orderstatus='Cancelled'));
		Go
ALTER TABLE OrderDetails
ADD CONSTRAINT CK_ORDERDETAILS CHECK(QuantityReceived<QUANTITYORDERED);
GO	
alter table OrderDetails
add primary key(PurchaseOrderID)
--------------------------------
alter table OrderDetails
add foreign key(Itemid) references ItemDetails(itemid)
--------------------------------
insert into OrderDetails values
--(1, '01-23-2020','02-20-2020',1,20,18,25.99,'free shipping', 'InTransit'),
(3, '04-12-2021','06-2-2021',2,26,23,30.99,'paid shipping', 'Received'),
(2, '04-12-2020','08-2-2020',1,24,23,22.99,'prime shipping', 'Received')

INSERT INTO [dbo].[OrderDetails] ([EmployeeID],[OrderDate],[ItemID],[QuantityOrdered],[QuantityReceived],[UnitPrice]
,[ShipMethod],[OrderStatus]) values (1, '01-23-2022' ,1,20,18,25.99,'free shipping', 'Cancelled')

select * from OrderDetails 
----_________________________________________________________________________________
 
alter Trigger Tri_OrderDetails_QuantityinHand
on OrderDetails after insert 
as
begin
UPDATE ii
SET QuantityInHand = QuantityInHand + i.QuantityReceived
FROM OrderDetails AS od
INNER JOIN Inserted AS i ON i.PurchaseOrderID = od.PurchaseOrderID
INNER JOIN ItemDetails AS ii ON ii.ItemID = i.ItemID
END


--_________________________________________________________________________________
/*
1. QuantityReceived should be added to QuantityInHand in the Items table. 
2. When a record is inserted into the table, QuantityInHand in the Items table should be updated automatically
3. ReceivingDate should allow NULL and should be greater than OrderDate.
5. Create the appropriate indexes to speed up the execution of the following tasks:
Extract the order details for all the purchase orders in the--current month
6. Extract the details of all the orders placed more than two years back.
7. Extract the details of the top five suppliers to whom the maximum number of orders have been placed in the current month.
8.create index CIX_OrderDetails_OrderDate ON OrderDetails orderdate asc;
*/

select * from OrderDetails
select * from employee
select * from ProductCategory
select * from SupplierDetails
select * from ItemDetails

/*DBCC Checkident(ProductCategory,reseed, 0)
DBCC Checkident(employee,reseed, 0)
DBCC Checkident(OrderDetails,reseed, 0)
DBCC Checkident(SupplierDetails,reseed, 0)
DBCC Checkident(ItemDetails,reseed, 0)
*/
/*
1. Extract the order details for all the purchase orders in the current month.
2. Extract the details of all the orders placed more than two years back.
3. Extract the details of the top five suppliers to whom the maximum number of orders have been placed in the current month.
*/
--1
SELECT * from OrderDetails
where OrderDate between '04/01/2022' and '04/30/2022'



select * from OrderDetails
select * from ItemDetails




