-- Create and select the database for the library system
CREATE DATABASE smart_library;
USE smart_library;

-- Table to store author details
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Table to store book details and link each book to an author
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category VARCHAR(50),
    isbn VARCHAR(20) UNIQUE,
    published_date DATE,
    price DECIMAL(10, 2),
    available_copies INT DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Table to store library member details
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    membership_date DATE NOT NULL
);

-- Table to record each borrowing transaction
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert sample authors
INSERT INTO Authors (name, email) VALUES
('J.K. Rowling', 'jk.rowling@email.com'),
('George Orwell', 'g.orwell@email.com'),
('Jane Austen', 'j.austen@email.com'),
('Mark Twain', 'mark.twain@email.com'),
('Agatha Christie', 'a.christie@email.com'),
('Stephen King', 'stephen.king@email.com'),
('Isaac Asimov', 'i.asimov@email.com'),
('Arthur Conan Doyle', NULL),
('Ernest Hemingway', 'e.hemingway@email.com'),
('Virginia Woolf', 'v.woolf@email.com');

-- Insert sample books with author reference and availability
INSERT INTO Books (title, author_id, category, isbn, published_date, price, available_copies) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 'Fantasy', '978-0-7475-3269-9', '1997-06-26', 599.00, 5),
('Harry Potter and the Chamber of Secrets', 1, 'Fantasy', '978-0-7475-3849-3', '1998-07-02', 549.00, 3),
('1984', 2, 'Science Fiction', '978-0-452-28423-4', '1949-06-08', 450.00, 4),
('Animal Farm', 2, 'Fiction', '978-0-452-28424-1', '1945-08-17', 350.00, 0),
('Pride and Prejudice', 3, 'Classic', '978-0-14-143951-8', '1813-01-28', 299.00, 6),
('Adventures of Huckleberry Finn', 4, 'Classic', '978-0-486-28061-5', '1884-12-10', 399.00, 2),
('Murder on the Orient Express', 5, 'Mystery', '978-0-06-207348-8', '1934-01-01', 499.00, 4),
('The Shining', 6, 'Horror', '978-0-385-12167-5', '1977-01-28', 650.00, 3),
('Foundation', 7, 'Science Fiction', '978-0-553-29335-0', '1951-06-01', 550.00, 0),
('The Adventures of Sherlock Holmes', 8, 'Mystery', '978-0-14-062406-3', '1892-10-14', 425.00, 5),
('The Old Man and the Sea', 9, 'Regular', '978-0-684-80122-3', '1952-09-01', 375.00, 4),
('To the Lighthouse', 10, 'Regular', '978-0-15-690739-6', '1927-05-05', 425.00, 3),
('Emma', 3, 'Classic', '978-0-14-143977-8', '1815-12-23', 325.00, 2),
('It', 6, 'Horror', '978-0-450-41165-9', '1986-09-15', 699.00, 1),
('The Hobbit', 1, 'Fantasy', '978-0-547-92822-7', '2012-09-18', 599.00, 4);

-- Insert sample members
INSERT INTO Members (name, email, phone_number, membership_date) VALUES
('Alice Johnson', 'alice.j@email.com', '9876543210', '2020-05-15'),
('Bob Smith', 'bob.smith@email.com', '9876543211', '2021-08-20'),
('Charlie Brown', 'charlie.b@email.com', '9876543212', '2022-03-10'),
('Diana Prince', 'diana.p@email.com', '9876543213', '2019-11-25');

-- Insert sample borrowing transactions
INSERT INTO Transactions (member_id, book_id, borrow_date, return_date, fine_amount) VALUES
(1, 1, '2024-10-01', '2024-10-15', 0.00),
(1, 3, '2024-11-01', NULL, 0.00),
(2, 2, '2024-09-15', '2024-09-29', 0.00),
(2, 7, '2024-11-10', NULL, 0.00),
(3, 5, '2024-08-20', '2024-09-05', 50.00),
(3, 10, '2024-11-15', NULL, 0.00),
(4, 1, '2024-07-10', '2024-07-24', 0.00);

-- View all data from each table
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Transactions;

-- Simple summary of record counts in each table
SELECT 'Total Authors' AS metric, COUNT(*) AS value FROM Authors
UNION ALL
SELECT 'Total Books', COUNT(*) FROM Books
UNION ALL
SELECT 'Total Members', COUNT(*) FROM Members
UNION ALL
SELECT 'Total Transactions', COUNT(*) FROM Transactions;
