/*Create a database named library and following TABLES in the database: 

1. Branch 
2. Employee 
3. Books
4. Customer
5. IssueStatus
6. ReturnStatus 
*/

/* 
Attributes for the tables: 

1. Branch

• Branch_no
Set as PRIMARY KEY  
• Manager_Id  
• Branch_address  
• Contact_no */
create database library;
use library;
create table Branch(
Branch_no int primary key,
Manager_Id int,
Branch_address varchar(200),
Contact_no int(10)
);

/*2. Employee  

• Emp_Id – Set as PRIMARY KEY  
• Emp_name  
• Position  
• Salary
• Branch_no
Set as FOREIGN KEY and it refer Branch_no in Branch table*/
create table Employee(
Emp_Id int primary key,
Emp_name varchar(100),
Position varchar(100),
Salary int,
Branch_no int,
foreign key(Branch_no) references Branch(Branch_no) on delete cascade
);

/*3. Books  

• ISBN
Set as PRIMARY KEY  
• Book_title  
• Category  
• Rental_Price  
• Status [Give yes if book available and no if book not available]  
• Author  
• Publisher*/
create table Books(
ISBN varchar(16) primary key,
Book_title varchar(150),
Category varchar(100),
Rental_Price decimal(10,2),
Status varchar(5),
Author varchar(100),
Publisher varchar(100)
);


/*4. Customer  

• Customer_Id
Set as PRIMARY KEY  
• Customer_name  
• Customer_address  
• Reg_date */
create table Customer(
Customer_Id int primary key,
Customer_name varchar(100),
Customer_address varchar(200),
Reg_date date
);

/*5. IssueStatus  

• Issue_Id
Set as PRIMARY KEY  
• Issued_cust – Set as FOREIGN KEY and it refer customer_id in CUSTOMER table  Issued_book_name 
• Issue_date 
• Isbn_book – Set as FOREIGN KEY and it should refer isbn in BOOKS table */

create table IssueStatus (
Issue_Id int primary key,
Issued_cust int,
Issue_date date,
Isbn_book varchar(15),
foreign key(Issued_cust) references Customer(Customer_Id),
foreign key(Isbn_book) references Books(ISBN)
);

/*6. ReturnStatus  

• Return_Id
Set as PRIMARY KEY  
• Return_cust  
• Return_book_name  
• Return_date  
• Isbn_book2
Set as FOREIGN KEY and it should refer isbn in BOOKS table */

create table ReturnStatus (
Return_Id int primary key,
Return_cust int,
Return_book_name varchar(200),
Return_date date,
Isbn_book2 varchar(15),
foreign key(Isbn_book2) references Books(Isbn),
foreign key (Return_cust) references Customer(Customer_Id)
);
insert into branch  values
(1,100,'Address1',1234567890);
insert into branch  values
(2,101,'Address2',1234567891),
(3,102,'Address3',1234567892),
(4,103,'Address4',1234567893),
(5,104,'Address5',1234567894);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1,'Seth','Manager',75000,1),
(2,'Amanda','Librarian',45000,1),
(3,'Chris','Head Librarian',60000,2),
(4,'David','Librarian',45000,2),
(5,'Manuel','Head Librarian',60000,3);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('1111','Book A','Category 1',50,'Yes','Author A','Publisher A'),
('1222','Book B','Category 2',100,'Yes','Author B','Publisher B'),
('3333','Book C','Category 1',30,'No','Author C','Publisher C'),
('4444','Book D','Category 3',40,'Yes','Author D','Publisher A'),
('4441','Book E','Category 4',50,'No','Author E','Publisher D');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1,'Godwin','Address 6','2024-02-03'),
(2,'Hughes','Address 7','2023-12-22'),
(3,'Alexa','Address 8','2024-01-25'),
(4,'Mia','Address 9','2023-08-15'),
(5,'Martin','Address 10','2023-05-29');
INSERT INTO IssueStatus (Issue_Id ,Issued_cust ,Issue_date ,Isbn_book) VALUES
(1,1,'2024-02-23','1111'),
(2,3,'2024-03-02','4444'),
(3,4,'2023-09-20','4444'),
(4,2,'2024-01-19','1222'),
(5,5,'2023-07-03','1111');
INSERT INTO ReturnStatus (Return_Id,Return_cust,Return_book_name ,Return_date,Isbn_book2) VALUES
(1,1,'Book A','2024-03-24','1111'),
(2,3,'Book D','2024-04-04','4444'),
(3,4,'Book D','2023-10-12','4444'),
(4,2,'Book B','2024-01-19','1222'),
(5,5,'Book A','2023-09-01','1111');

/*Display all the tables and Write the queries for the following :

1. Retrieve the book title, category, and rental price of all available books. */
select Book_title,Category,Rental_price from Books where status='yes';
# 2. List the employee names and their respective salaries in descending order of salary. 
select Emp_name,Salary from Employee order by Salary desc;
# 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT Books.Book_title, Customer.Customer_name 
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;
#4. Display the total count of books in each category. 
select category,count(*) totalbooks from books group by category; 
#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
select Emp_name,position from employee where salary>50000;
#6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
#7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;
#8. Display the names of customers who have issued books in the month of June 2023.
SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';
#9. Retrieve book_title from book table containing history. 
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';
#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;
#11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address 
FROM Employee E 
JOIN Branch B ON E.Emp_Id = B.Manager_Id;
#12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT Customer.Customer_name 
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
WHERE Books.Rental_Price > 25;
