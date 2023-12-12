CREATE DATABASE OnlineBookstore;

Use Onlinebookstore;

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Birthdate DATE,
    Nationality VARCHAR(50)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Date_of_order DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);



CREATE TABLE OrderDetails (
    OrderID INT,
    ISBN VARCHAR(13),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ISBN),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ISBN VARCHAR(13),
    QuantityInStock INT
    /*FOREIGN KEY (ISBN) REFERENCES Book(ISBN)*/ 
);

CREATE TABLE Book (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(255),
    Genre VARCHAR(50),
    AuthorID INT,
    Price DECIMAL(10, 2),
    PublicationDate DATE,
    InventoryID INT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);

-- Sample data for Author table
INSERT INTO Author (AuthorID, Name, Birthdate, Nationality) VALUES
(1, 'Jane Doe', '1980-05-15', 'American'),
(2, 'John Smith', '1975-08-22', 'British'),
(3, 'Alice Johnson', '1990-03-10', 'Canadian');

-- Sample data for Customer table
INSERT INTO Customer (CustomerID, Name, Email, Phone) VALUES
(1, 'Bob Anderson', 'bob@email.com', '+1-555-123-4567'),
(2, 'Emily Wilson', 'emily@email.com', '+1-555-987-6543'),
(3, 'Charlie Brown', 'charlie@email.com', '+1-555-321-0987');

-- Sample data for Book table
INSERT INTO Book (ISBN, Title, Genre, AuthorID, Price, PublicationDate, InventoryID) VALUES
('9781234567890', 'The Book Title 1', 'Fiction', 1, 19.99, '2022-01-15', 1),
('9782345678901', 'The Book Title 2', 'Non-Fiction', 2, 29.99, '2022-02-20', 2),
('9783456789012', 'The Book Title 3', 'Mystery', 3, 24.99, '2022-03-25', 3);


INSERT INTO Book (ISBN, Title, Genre, AuthorID, Price, PublicationDate, InventoryID) VALUES
('9783456789013', 'The Book Title 4', 'Non-Fiction',2,25,'2022-04-20',4);
-- Sample data for Inventory table
INSERT INTO Inventory (InventoryID, ISBN, QuantityInStock) VALUES
(1, '9781234567890', 100),
(2, '9782345678901', 75),
(3, '9783456789012', 50);

INSERT INTO Inventory (InventoryID, ISBN, QuantityInStock) VALUES
(4, '9783456789013', 50);
-- Sample data for Order table
INSERT INTO Orders (OrderID, CustomerID, Date_of_order, TotalAmount) VALUES
(1, 1, '2022-04-01', 59.97),
(2, 2, '2022-04-02', 89.98),
(3, 3, '2022-04-03', 49.99);

-- Sample data for OrderDetails table
INSERT INTO OrderDetails (OrderID, ISBN, Quantity, UnitPrice) VALUES
(1, '9781234567890', 2, 19.99),
(1, '9782345678901', 1, 29.99),
(2, '9783456789012', 3, 24.99),
(3, '9781234567890', 1, 19.99);

-- Finding all books by a specific author
select book.title, author.Name
from book 
join author
on book.AuthorID = author.AuthorID;

-- List all customers who made purchases.
select customer.name, orders.Date_of_order, orders.TotalAmount
from customer
right join orders
on customer.CustomerID = customer.CustomerID;

-- Calculate the total sales for a given period.
select sum(orders.TotalAmount)
from orders;

-- Identify books that are out of stock.
Select Inventory.QuantityInStock, Book.Title
from Inventory
join book
where  Inventory.QuantityInStock <= 0 ;

-- Retrieve details of a specific order.
select * 
from orderdetails
where orderid = 1;

-- Finding the top-selling books.
select book.title, (orderdetails.unitprice * orderdetails.quantity) as tot
from book
join orderdetails
on orderdetails.ISBN = book.ISBN
order by tot DESC;

-- Calculate the average order value.
SELECT round(avg(orderdetails.unitprice * orderdetails.quantity), 2)
FROM orderdetails;

-- Identify customers with the highest total spending.
select customer.name, max(orders.totalamount)
from customer
join orders
on customer.customerID = orders.customerID;