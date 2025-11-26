-- Campus Library Management Mini Project (MySQL)
-- This script creates a sample library database with tables,
-- sample data, and various SQL queries for practice.

-- 0. CREATE DATABASE & USE IT
DROP DATABASE IF EXISTS CampusLibraryDB;
CREATE DATABASE CampusLibraryDB;
USE CampusLibraryDB;

-- 1. CREATE MASTER TABLES
-- 1.1 Authors
CREATE TABLE authors (
    author_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(120)
);

-- 1.2 Members
CREATE TABLE members (
    member_id        INT AUTO_INCREMENT PRIMARY KEY,
    full_name        VARCHAR(100) NOT NULL,
    email            VARCHAR(120),
    phone            VARCHAR(15) NOT NULL,
    membership_date  DATE NOT NULL
);

-- 1.3 Books (foreign key will be added later)
CREATE TABLE books (
    book_id          INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(80) NOT NULL,
    author_id        INT,
    category         VARCHAR(50) NOT NULL,
    isbn             VARCHAR(30) NOT NULL UNIQUE,
    published_on     DATE NOT NULL,
    price            DECIMAL(10,2) NOT NULL,
    available_copies INT NOT NULL DEFAULT 0
);

-- 1.4 Transactions (foreign keys will be added later)
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id      INT NOT NULL,
    book_id        INT NOT NULL,
    borrow_date    DATE NOT NULL,
    return_date    DATE,
    fine_amount    DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- 2. INSERT SAMPLE DATA
-- 2.1 Authors
INSERT INTO authors (full_name, email) VALUES
('R.K. Narayan',      'rknarayan@example.com'),
('Sudha Murty',       'sudhamurty@example.com'),
('Amish Tripathi',    'amish.t@example.com'),
('Ruskin Bond',       'ruskin.bond@example.com'),
('Kiran Desai',       'kiran.desai@example.com'),
('Vikram Chandra',    'vikram.chandra@example.com');

-- 2.2 Books
INSERT INTO books (title, author_id, category, isbn, published_on, price, available_copies) VALUES
('Malgudi Days',                1, 'Fiction',     'ISBN-1001', '1980-01-01', 350.00, 10),
('Wise and Otherwise',          2, 'Non-Fiction', 'ISBN-1002', '2002-05-15', 275.00, 5),
('The Immortals of Meluha',     3, 'Mythology',   'ISBN-1003', '2010-02-01', 320.00, 6),
('The Blue Umbrella',           4, 'Children',    'ISBN-1004', '1980-07-10', 150.00, 15),
('The Inheritance of Loss',     5, 'Fiction',     'ISBN-1005', '2005-01-01', 400.00, 4),
('Red Earth and Pouring Rain',  6, 'Fiction',     'ISBN-1006', '1995-01-01', 520.00, 3),
('Quantum Basics',              2, 'Science',     'ISBN-1007', '2018-06-01', 480.00, 2),
('Intro to Data Science',       3, 'Science',     'ISBN-1008', '2021-08-20', 650.00, 0);

-- 2.3 Members
INSERT INTO members (full_name, email, phone, membership_date) VALUES
('Aarav Mehta',   'aarav.mehta@example.com',   '9876500010', '2019-01-15'),
('Diya Shah',     'diya.shah@example.com',     '9876500011', '2013-02-20'),
('Nandini Rao',   'nandini.rao@example.com',   '9876500012', '2012-03-10'),
('Kabir Singh',   'kabir.singh@example.com',   '9876500013', '2021-11-08'),
('Sneha Iyer',    'sneha.iyer@example.com',    '9876500014', '2023-04-05'),
('Vikrant Jain',  NULL,                        '9876500015', '2023-02-28');

-- 2.4 Transactions
INSERT INTO transactions (member_id, book_id, borrow_date, return_date, fine_amount) VALUES
(1, 1, '2024-01-10', '2024-01-24',  0.00),
(2, 3, '2024-01-15', '2024-02-01', 35.00),
(3, 5, '2024-01-12', '2024-01-26',  0.00),
(4, 2, '2024-01-18', '2024-02-05', 52.50),
(5, 6, '2024-01-20', '2024-02-03',  0.00),
(6, 4, '2024-01-22', '2024-02-08', 27.50);

-- 3. BASIC INSERT / UPDATE / DELETE / SELECT

-- 3.1 Insert a new book, author and member
INSERT INTO authors (full_name, email)
VALUES ('New Age Author', 'new.author@example.com');

INSERT INTO books (title, author_id, category, isbn, published_on, price, available_copies)
VALUES ('AI for Everyone', 7, 'Science', 'ISBN-2001', '2022-01-01', 550.00, 3);

INSERT INTO members (full_name, email, phone, membership_date)
VALUES ('New Member', 'new.member@example.com', '9999999999', '2024-08-01');

-- 3.2 View all books
SELECT * FROM books;

-- 3.3 UPDATE book availability after borrow
UPDATE books
SET available_copies = available_copies - 1
WHERE book_id = 3;

-- 3.4 UPDATE book availability after return
UPDATE books
SET available_copies = available_copies + 1
WHERE book_id = 3;

-- 3.5 View members and transactions
SELECT * FROM members;
SELECT * FROM transactions;

-- 3.6 DELETE members who haven’t borrowed in the last 1 year
DELETE FROM members
WHERE member_id NOT IN (
    SELECT DISTINCT member_id
    FROM transactions
    WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

-- 3.7 RETRIEVE all books with available copies
SELECT *
FROM books
WHERE available_copies > 0;

-- 4. FILTERING & SORTING QUERIES

-- 4.1 Books published AFTER 2015
SELECT *
FROM books
WHERE published_on > '2015-12-31';

-- 4.2 Top 5 most expensive books
SELECT *
FROM books
ORDER BY price DESC
LIMIT 5;

-- 4.3 Members who joined BEFORE 2022
SELECT *
FROM members
WHERE membership_date < '2022-01-01';

-- 4.4 Science books with price < 500
SELECT *
FROM books
WHERE category = 'Science'
  AND price < 500;

-- 4.5 Books NOT available for borrowing
SELECT *
FROM books
WHERE available_copies = 0;

-- 4.6 Members who joined after 2020 OR have borrowed > 3 books
SELECT
    m.member_id,
    m.full_name,
    COUNT(t.transaction_id) AS total_borrowed
FROM members m
LEFT JOIN transactions t
       ON t.member_id = m.member_id
GROUP BY m.member_id, m.full_name, m.membership_date
HAVING m.membership_date > '2020-12-31'
    OR COUNT(t.transaction_id) > 3;

-- 4.7 Books sorted alphabetically
SELECT *
FROM books
ORDER BY title ASC;

-- 5. AGGREGATION QUERIES

-- 5.1 Number of books borrowed by each member
SELECT
    m.member_id,
    m.full_name,
    COUNT(t.transaction_id) AS total_borrowed
FROM members m
LEFT JOIN transactions t
       ON m.member_id = t.member_id
GROUP BY m.member_id, m.full_name;

-- 5.2 Group books by category and show total count
SELECT
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category;

-- 5.3 Total number of books in each category (same as 5.2, kept for clarity)
SELECT
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category;

-- 5.4 Average price of books
SELECT AVG(price) AS avg_price
FROM books;

-- 5.5 Most borrowed book
SELECT
    b.book_id,
    b.title,
    COUNT(t.transaction_id) AS borrow_count
FROM books b
JOIN transactions t
     ON b.book_id = t.book_id
GROUP BY b.book_id, b.title
ORDER BY borrow_count DESC
LIMIT 1;

-- 5.6 Total fines collected
SELECT SUM(fine_amount) AS total_fines
FROM transactions;

-- 6. ADD FOREIGN KEYS USING ALTER TABLE

ALTER TABLE books
ADD CONSTRAINT fk_books_authors
FOREIGN KEY (author_id) REFERENCES authors(author_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_members
FOREIGN KEY (member_id) REFERENCES members(member_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_books
FOREIGN KEY (book_id) REFERENCES books(book_id);

-- 7. JOINS

-- 7.1 INNER JOIN: books with their author names
SELECT
    b.book_id,
    b.title,
    a.full_name AS author_name
FROM books b
INNER JOIN authors a
        ON b.author_id = a.author_id;

-- 7.2 LEFT JOIN: members and any books they borrowed
SELECT
    m.member_id,
    m.full_name,
    t.transaction_id,
    t.book_id
FROM members m
LEFT JOIN transactions t
       ON m.member_id = t.member_id;

-- 7.3 RIGHT JOIN: books that haven’t been borrowed
SELECT
    b.book_id,
    b.title
FROM transactions t
RIGHT JOIN books b
        ON t.book_id = b.book_id
WHERE t.transaction_id IS NULL;

-- 7.4 Members who NEVER borrowed (FULL OUTER JOIN equivalent style)
SELECT
    m.*
FROM members m
LEFT JOIN transactions t
       ON m.member_id = t.member_id
WHERE t.transaction_id IS NULL;

-- 8. SUBQUERIES

-- 8.1 Books borrowed by members who registered AFTER 2022
SELECT DISTINCT b.*
FROM books b
JOIN transactions t
     ON b.book_id = t.book_id
WHERE t.member_id IN (
    SELECT member_id
    FROM members
    WHERE membership_date > '2022-12-31'
);

-- 8.2 Most borrowed book using a subquery
SELECT *
FROM (
    SELECT
        b.book_id,
        b.title,
        COUNT(t.transaction_id) AS borrow_count
    FROM books b
    JOIN transactions t
         ON b.book_id = t.book_id
    GROUP BY b.book_id, b.title
) AS x
ORDER BY borrow_count DESC
LIMIT 1;

-- 8.3 Members who have never borrowed a book (subquery style)
SELECT *
FROM members
WHERE member_id NOT IN (
    SELECT DISTINCT member_id
    FROM transactions
);

-- 9. DATE & STRING FUNCTIONS

-- 9.1 Count books by publication YEAR
SELECT
    YEAR(published_on) AS pub_year,
    COUNT(*) AS total_books
FROM books
GROUP BY YEAR(published_on);

-- 9.2 Difference in days between borrow and return
SELECT
    transaction_id,
    member_id,
    book_id,
    borrow_date,
    return_date,
    DATEDIFF(return_date, borrow_date) AS days_taken
FROM transactions
WHERE return_date IS NOT NULL;

-- 9.3 Borrow date formatted as DD-MM-YYYY
SELECT
    transaction_id,
    DATE_FORMAT(borrow_date, '%d-%m-%Y') AS borrow_date_formatted
FROM transactions;

-- 9.4 Book titles in UPPERCASE
SELECT UPPER(title) AS upper_title
FROM books;

-- 9.5 Trim whitespace from author names
SELECT TRIM(full_name) AS trimmed_name
FROM authors;

-- 9.6 Replace missing member email with 'Not Provided'
SELECT
    full_name,
    IFNULL(email, 'Not Provided') AS email_display
FROM members;

-- 10. WINDOW FUNCTIONS

-- 10.1 Rank books by number of times borrowed
SELECT
    book_id,
    title,
    borrow_count,
    RANK() OVER (ORDER BY borrow_count DESC) AS borrow_rank
FROM (
    SELECT
        b.book_id,
        b.title,
        COUNT(t.transaction_id) AS borrow_count
    FROM books b
    LEFT JOIN transactions t
           ON b.book_id = t.book_id
    GROUP BY b.book_id, b.title
) AS ranked_books;

-- 10.2 Cumulative number of books borrowed per member (over time)
SELECT
    member_id,
    borrow_date,
    daily_count,
    SUM(daily_count) OVER (
        PARTITION BY member_id
        ORDER BY borrow_date
    ) AS cumulative_borrowed
FROM (
    SELECT
        member_id,
        borrow_date,
        COUNT(*) AS daily_count
    FROM transactions
    GROUP BY member_id, borrow_date
) AS t
ORDER BY member_id, borrow_date;

-- 10.3 Moving 3-month average of books borrowed
SELECT
    borrow_month,
    total_borrowed,
    AVG(total_borrowed) OVER (
        ORDER BY borrow_month
        RANGE INTERVAL 2 MONTH PRECEDING
    ) AS moving_avg_3_months
FROM (
    SELECT
        DATE_FORMAT(borrow_date, '%Y-%m-01') AS borrow_month,
        COUNT(*) AS total_borrowed
    FROM transactions
    GROUP BY DATE_FORMAT(borrow_date, '%Y-%m-01')
) AS monthly_stats
ORDER BY borrow_month;

-- 11. CASE EXPRESSIONS

-- 11.1 Membership_Status: Active if borrowed in last 6 months, else Inactive
SELECT
    m.member_id,
    m.full_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM transactions t
            WHERE t.member_id = m.member_id
              AND t.borrow_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    ) THEN 'Active'
        ELSE 'Inactive'
    END AS membership_status
FROM members m;

-- 11.2 Categorize books by publication year
SELECT
    b.book_id,
    b.title,
    b.published_on,
    CASE
        WHEN YEAR(published_on) > 2020 THEN 'New Arrival'
        WHEN YEAR(published_on) < 2000 THEN 'Classic'
        ELSE 'Regular'
    END AS book_category
FROM books b;
