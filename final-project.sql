

--I will be given a database for the final project

--Name the database as you find more convenient

create database Miami_Spa;--We succesfully created the Miami_Spa database



use Miami_Spa;--Let us make sure that we are connected to the right database


--Now I will proceed to create the customers table. Let us first focus on the table design.

create table Customers (--The table customers has 5 columns
Customer_ID char(20) not null,
Customer_Fname char(50) not null,--Besides customer_ID I also included contact information 
--about every customer in the customers table
Customer_Lname Char(50) not null,
Customer_DOB date not null,
Customer_email char(50) not null,
constraint pk_customer primary key (Customer_ID));--Customer_ID is the primary and we are 
--in the presence of a table level constraint

--Let us proceed to populate the table customers

insert into Customers values
('1001','George','Hill','01.06.1985','ghill@customers.apa'),
('1002','Jorge','Hill','11.06.1995','jhill@customers.apa'),
('1003','Rebeca','Jones','11.16.1975','rjones@customers.apa'),
('1004','Monica','Gil','07.24.1992','mgil@customers.apa'),
('1005','Ryan','Stevens','09.06.1977','rstevens@customers.apa'),
('1006','Robert','Mills','02.16.1987','rmills@customers.apa'),
('1007','Tony','Jones','12.16.1989','tjones@customers.apa'),
('1008','Jessica','Sosa','01.27.1977','jsosa@customers.apa'),
('1009','Marie','Alberts','11.22.1969','malberts@customers.apa'),
('1010','Gissele','Cousins','09.07.1997','gcousins@customers.apa'),
('1011','Thomas','Philips','03.06.1955','tphilips@customers.apa'),
('1012','Lewis','Trovalto','05.16.1982','ltrovalto@customers.apa'),
('1013','Tina','Muller','04.07.1995','tmuller@customers.apa'),
('1014','Felix','Arevalo','04.26.1989','farevalo@customers.apa');

--Let us make sure that we succeeded addind records to the customers table
Select *from Customers;

--Let us now proceed to create the Membership table

Create table Membership (
Membership_ID char(20),
Membership_Name Char(30) not null,--Membership name(type) might be gold,premium, and bronze
Years_customer tinyint null,--The attribute Years_customer describes the amount of time that the customer has been a member
constraint pk_membership Primary Key(Membership_ID));--Membership_ID is the primary of this table. We are in presence of a table 
--level constraint.


--Let us populate the Membership table

insert into Membership values('201','Gold',6),
('202','Gold',4),
('203','Premium',3),
('204','Bronze',2),
('205','Bronze',11),
('206','Bronze',7),
('207','Gold',2),
('208','Bronze',3),
('209','Gold',6),
('210','Premium',4),
('211','Gold',5),
('212','Bronze',1),
('213','Premium',12),
('214','Gold',1);


--Let us test that the Membership table is populated.

Select *from Membership;

--Let us sort by Year_customer to determine the customer that has been in the
--organization the longest

Select *from Membership order by Years_customer desc;--We did not find the full name of the person
--but we know that the id is 213 (hint:inner-join).

Select * From Customers;
Select * From Membership;

--Answer Pending???

--Let us design the Transactions table now.

Create table Transactions(
Transaction_ID int,
Customer_ID char(20) foreign key references Customers(Customer_ID),--Customer_ID is a foreign key referencing 
--Customer_ID in the Customers table
Membership_ID char(20) foreign key references Membership(Membership_ID),--Membership_ID is a foereign key referencing
--Membership_ID in the Membership table
Transaction_amount smallmoney not null,
Transaction_date date not null,
constraint pk_transaction Primary Key(Transaction_ID));--Transaction_ID is the primary 
--key(Table level constraint)

--We will proceed to populate the Transactions table
insert into Transactions values (123456,'1001','201',123.45,'01.01.2019');
insert into Transactions values (123457,'1002','202',193.45,'01.09.2019');
insert into Transactions values (123458,'1003','203',223.45,'01.01.2019');


insert into Transactions values (123459,'1004','204',603.45,'06.01.2019');
insert into Transactions values (123451,'1005','205',523.25,'11.01.2019');
insert into Transactions values (123452,'1006','206',323.15,'11.01.2019');
insert into Transactions values (123453,'1007','207',263.75,'06.21.2019');
insert into Transactions values (123454,'1008','208',923.45,'07.21.2019');
insert into Transactions values (123455,'1009','209',923.45,'11.11.2019');
insert into Transactions values (123461,'1010','210',1023.45,'01.01.2019');



Select *from Transactions;

--First inspect the Miami_Spa database and make comments about your findings. Which name 
--you would find more appropriate for the database?

--Planet_workout because it membership and customers ID.

--Add a constraint to the transaction_date(Transaction_date>=01.01.2019)

alter table transactions
add constraint minimum_date check(Transaction_date >='01.01.2019');

--Let us test the constraint by inserting a new record that violates it.

insert into Transactions values (123471,'1014','214',1323.45,'11.01.2018');

--Select the first and last name for every customer who spent more than $500.00 dollars 
--in a single transaction.

Select Customer_Fname,Customer_LName,Transaction_amount
from Customers join Transactions
on Customers.Customer_ID=Transactions.Customer_ID
where Transaction_amount >500.00;

--Return full details about everyone that is being a customer for more than 5 years.
--Make comments about it.


Select Customer_Fname,Customer_Lname,Membership_Name,
Transaction_amount,Transaction_date,Customer_email,Years_Customer,Customer_dob
from Transactions join Customers
on Transactions.Customer_ID=Customers.Customer_ID
join Membership on Transactions.Membership_ID=Membership.Membership_ID
where Years_customer>5;

--Let us update the membership_name for every customer with more than five
--Years as a member

Update Membership
set Membership_Name='Gold'
where Years_customer>=5;

--Let us check that our update statement run succesfuly

Select *from Membership;

--Continue here
/*Let us now retrieve data with a query directly into a variable. In the query below the 
variables are initially declared. The first query retrieves the first and last transaction
dates and populates the variables with these values. The final query returns these variables
 to be displayed. Find out more information in Chapter 6.*/

--Declare two variables that return the oldest and most recent transactions from
--the transaction table in the Customers database.

DECLARE @OldestTransactionDate DATE,    	
@MostRecentTransactionDate DATE; 
SELECT @OldestTransactionDate = MIN(Transaction_Date),   	
@MostRecentTransactionDate = MAX(Transaction_date)
FROM	Transactions; 
SELECT @OldestTransactionDate AS Oldest_Date,   	
@MostRecentTransactionDate AS LastTransactionDate;--This query returned Jan01 and November 11th as the oldest 
--and latest dates for which a transaction was recorded.

/*Let us say we want to round the transactions value to a speciﬁc number of decimal places.*/

Select Transaction_amount,ROUND(Transaction_amount,0) AS whole_Dollar--We are rounding every transaction to the dollar
--In other words, no decimal places in the whole dollar column
FROM Transactions;

--Let us create a procedure that returns full details about every transaction
--worth more than $500.00

create procedure dbo.Significant_Transactions_list
as 
Select Customer_Fname,
   Customer_Lname,
   Customer_email,
   Transaction_Amount,
   Transaction_date
   from Customers join Transactions
   on Customers.Customer_ID=Transactions.Customer_ID
   where Transaction_amount>500.00;

Exec dbo.Significant_Transactions_list;

--We have 5 customers that meet the criteria.






















