-- Part 2: Logical and physical design 

-- 1.	Create the corresponding database using DDL 
CREATE DATABASE Allbirds;

-- 2.	Create all the necessary tables identified above using DDL
CREATE TABLE adress (
    Zipcode int NOT NULL,
    Apt_Number INT,
    Street VARCHAR(100),
    County VARCHAR(100),
    Country VARCHAR(100),
    Customer_ID INT,
   PRIMARY KEY (ZIPCODE)
   );
   
  CREATE TABLE Department (
    Department_ID int NOT NULL,
    Department_name VARCHAR(100),
    PRIMARY KEY (Department_ID)
   );
   
   CREATE TABLE Employees (
    Employee_ID  int NOT NULL,
    Employee_name VARCHAR(100),
    PPS INT,
    Employee_type VARCHAR(100),
    Salary INT,
   PRIMARY KEY (Employee_ID)
   );
   
   CREATE TABLE Customer (
    Customer_ID int NOT NULL,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Phone_number INT,
    Email_adress VARCHAR(100),
   PRIMARY KEY (Customer_ID)
   );
   
   CREATE TABLE Order_store  (
    Order_ID int NOT NULL,
    Order_date DATE,
    Amount_paid INT,
    Payment_ID INT,
    Customer_ID INT,
    Quantity INT,
    Product_ID INT,
   PRIMARY KEY (Order_ID)
   );
   
   CREATE TABLE Product (
    Product_ID int NOT NULL,
    Product_name VARCHAR(100),
    Supplier_ID INT,
    Price INT,
   PRIMARY KEY (Product_ID)
   );
   
   CREATE TABLE Category (
    Category_ID  int NOT NULL,
    Category_name VARCHAR(100),
    PRIMARY KEY (Category_ID)
   );
   
   CREATE TABLE Payment (
    Payment_ID int NOT NULL,
    Payment_mode VARCHAR(100),
    Card_number INT,
    Customer_ID INT,
    Employee_ID INT,
   PRIMARY KEY (Payment_ID)
   );
   
   CREATE TABLE Supplier (
    Supplier_ID  int NOT NULL,
    Apt_Number INT,
    Supplier_name VARCHAR(100),
    Quantity_supplied INT,
   PRIMARY KEY (Supplier_ID)
   );
   
   CREATE TABLE Credit_card  (
    Card_number  int NOT NULL,
    Card_type VARCHAR(100),
    CVV INT,
    Card_name VARCHAR(100),
   PRIMARY KEY (Card_number)
   );

    CREATE TABLE Inventory  (
    Quantity_inv  int,
    Customer_ID int
      );


-- 3.	Populate at least three of your tables with some data using DML (insert into statement)
insert into category (Category_ID , Category_name) values (2000, 'Wool shoes');
insert into category (Category_ID , Category_name) values (2001, 'Pine shoes');
insert into category (Category_ID , Category_name) values (2002, 'Slipups');
insert into Department (Department_ID, Department_name) values (2000, 'Production');
insert into Department (Department_ID, Department_name) values (2001, 'Accountance');
insert into Department (Department_ID, Department_name) values (2002, 'Engineering');
insert into Supplier (Supplier_ID , Supplier_name) values (2000, 'Phynespines');
insert into Supplier (Supplier_ID , Supplier_name) values (2001, 'Wowwools');
insert into Supplier (Supplier_ID , Supplier_name) values (2002, 'Plasticall');


-- Part 3: Write SQL Statements to answer the following queries 

-- 1.	Show all the details of the products that have a price greater than 100.
CREATE 
VIEW price100 AS
    SELECT 
        Product_ID,
        Product_name,
        Price
    FROM
        product
    WHERE
        Price > 100;
        

-- 2.	Show all the products along with the supplier detail who supplied the products.
CREATE 
VIEW supplier1 AS
    SELECT 
        Product_ID
        Product_name,
        Supplier_ID,
        Supplier_name
    FROM
        product
	ORDER BY Supplier_ID;


-- 3.	Create a stored procedure that takes the start and end dates of the sales and display all the sales transactions between the start and the end dates.
DELIMITER //
CREATE PROCEDURE PROCID()
BEGIN
	SELECT *
    FROM ORDER_STORE
    WHERE ORDER_DATE >= `2020/01/01`  AND ORDER_DATE <= `2020/12/31`;
END
 DELIMITER // ;


-- 4.	Create a view that shows the total number of items a customer buys from the business in October 2020 along with the total price (use group by)
CREATE 
	VIEW october AS
    SELECT 
        Customer_ID,
        Order_date,
        Amount_paid
    FROM
        order_store
    WHERE
        Order_date BETWEEN 2020/10/01 AND 2020/10/31
    ORDER BY Customer_ID;
    
    
-- 5.	Create a trigger that adjusts the stock level every time a product is sold.
CREATE TRIGGER INVENTORYUPD
AFTER INSERT ON ORDER_STORE 
FOR EACH ROW
  UPDATE INVENTORY 
     SET quantity_INV = quantity - NEW.quantity_INV
   WHERE product_ID = NEW.product_ID;
   

-- 6.	Create a report of the annual sales (2020) of the business showing the total number of
--  products sold and the total price sold every month (use A group by with roll-up)


-- 7.	Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. 
select month, quantity, 
       if(@last_entry = 0, 0, round(((quantity - @last_entry) / @last_entry) * 100,2)) "growth rate %",
       @last_entry := quantity                  
from
      (select @last_entry := 0) x,
      (select month, sum(quantity) quantity
       from   (select month(order_date) as month,sum(quantity) as quantity 
               from order_store 
	where month(order_date) < 12
	group by month(order_date)) monthly_order_store
	group by month) y;

-- 8.	Delete all customers who never buy a product from the business.
WHERE column-name IS NULL


































CREATE TRIGGER INVENTORYUPD
AFTER INSERT ON Order_store 
FOR EACH ROW
  UPDATE inventory 
     SET quantity_inv = quantity_inv - NEW.quantity
   WHERE product_ID = NEW.product_ID;
   
   
 --  5.	Create a trigger that adjusts the stock level every time a product is sold.


--6.	Create a report of the annual sales (2020) of the business showing the total number of products sold and the total price sold every month (use A group by with roll-up)

--7.	Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. 


--8.	Delete all customers who never buy a product from the business.
