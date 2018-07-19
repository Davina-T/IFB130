/* Davina Tan N9741127 */

/* Create the database */
CREATE DATABASE IF NOT EXISTS oktomook_bookstore;
SHOW DATABASES; 
USE oktomook_bookstore;

/* Create new tables */
/* Customers */
CREATE TABLE customers (
	customerNumber INT AUTO_INCREMENT,
    firstName VARCHAR(60),
    lastName VARCHAR(60),
    address VARCHAR(80),
    city VARCHAR(60),
    state ENUM('QLD', 'VIC', 'NSW', 'WA', 'TAS', 'NT', 'SA'),
    postcode VARCHAR(4), 
    region VARCHAR(150),
    email VARCHAR(150),
    PRIMARY KEY(customerNumber)
) CHARACTER SET utf8;

/* Publishers */
CREATE TABLE publishers (
	pubID INT AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL, /* name of publisher is mandatory*/
    contact VARCHAR(60), /* contact name */
    phone VARCHAR(20),
    PRIMARY KEY(pubID)
) CHARACTER SET utf8;

/* Author */
CREATE TABLE author (
	authorID INT AUTO_INCREMENT,
    firstName VARCHAR(60),
    lastName VARCHAR(60),
    PRIMARY KEY(authorID)
) CHARACTER SET utf8;

/* Books */
CREATE TABLE books (
	ISBN CHAR(13) UNIQUE, /* use CHAR so it may begin with a zero, every ISBN is unique */
    title VARCHAR(80) NOT NULL, /* is mandatory */
    pubDate DATE,
    pubID INT,
    cost DECIMAL(10,2), /* assuming monetary value of manufacturer cost */
    retail DECIMAL (10,2), /* assuming monetary value of retail cost */
    discount DECIMAL (10,2), /* assuming monetary value of the discount cost */
    category ENUM ('Fitness', 'Children', 'Computer', 'Cooking', 'Business', 'Literature'),
    PRIMARY KEY(ISBN),
    FOREIGN KEY(pubID) REFERENCES publishers(pubID)
) CHARACTER SET utf8;

/* OrdersItems */
CREATE TABLE ordersItems (
	orderNumber INT AUTO_INCREMENT,
    itemNumber INT,
    ISBN CHAR(13), /* use CHAR so it may begin with a zero */
    quantity INT DEFAULT 1, 
    paidEach DECIMAL (10,2), /* price paid for item */
    PRIMARY KEY(orderNumber)
) CHARACTER SET utf8;

/* Orders */
CREATE TABLE orders (
	orderNumber INT,
    customerNumber INT,
    orderDate DATE,
    shipDate DATE,
    street VARCHAR(60),
    city VARCHAR(60),
    state ENUM('QLD', 'VIC', 'NSW', 'WA', 'TAS', 'NT', 'SA'),
    postCode VARCHAR(5),
    shipCost DECIMAL(10,2),
    PRIMARY KEY(orderNumber),
    FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber),
    FOREIGN KEY(orderNumber) REFERENCES ordersItems(orderNumber)
) CHARACTER SET utf8;

/* Wrote */
CREATE TABLE wrote (
	ISBN CHAR(13), /* use CHAR so it may begin with a zero */
    authorID INT,
    PRIMARY KEY(ISBN, authorID),
    FOREIGN KEY(authorID) REFERENCES author(authorID),
    FOREIGN KEY(ISBN) REFERENCES books(ISBN)
) CHARACTER SET utf8;

/* showing purposes 

SHOW TABLES;

DESCRIBE author;
DESCRIBE books;
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE ordersItems;
DESCRIBE publishers;
DESCRIBE wrote;

*/ 