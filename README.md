📚 Smart Library Management System

A SQL-Based Database Project

📌 Overview

This project is a complete Library Management System built using MySQL.
It demonstrates key database concepts including:

Database schema design

CRUD operations

SQL clauses (WHERE, HAVING, LIMIT)

Operators (AND, OR, NOT)

Sorting & Grouping

Aggregate Functions

Primary & Foreign Keys

Joins

Subqueries

Date & String functions

Window Functions

CASE expressions

This project fulfills the requirements defined in the given assignment.

🏗️ Database Schema

The system contains four main tables:

Table Name	Description
Authors	Stores author details
Books	Stores book information and links to authors
Members	Stores library member data
Transactions	Tracks borrowing activity, return dates, and fines
🔑 Relationships

Books → Authors: (author_id)

Transactions → Members: (member_id)

Transactions → Books: (book_id)

This ensures referential integrity using primary and foreign key constraints.

📂 Table Structure
Table	Primary Key	Foreign Keys	Contains
Authors	author_id	—	Author names & emails
Books	book_id	author_id → Authors.author_id	Titles, category, ISBN, price, availability
Members	member_id	—	Member details & membership date
Transactions	transaction_id	member_id, book_id	Borrow, return, fines
🧪 Features Implemented
✔️ CRUD Operations

Add new authors, books, and members

Update stock when books are borrowed or returned

Remove inactive members

Retrieve available books

✔️ SQL Clauses

Queries using WHERE, HAVING, and LIMIT

✔️ Operators

Filtering using AND, OR, and NOT

✔️ Sorting & Grouping

Alphabetical book listing

Borrowing statistics per member

Categorized book count

✔️ Aggregate Functions

SUM, COUNT, AVG, MIN, MAX

✔️ Keys & Relationships

Primary/foreign key constraints ensure data consistency

✔️ Joins

INNER, LEFT, RIGHT, and simulated FULL OUTER JOIN

✔️ Subqueries

Find most borrowed book

Members who never borrowed

Books borrowed by recent members

✔️ Date & Time Functions

Year extraction

Day difference calculation

Date formatting

✔️ String Manipulation

Uppercase conversion

Whitespace cleanup

Null replacement

✔️ Window Functions (MySQL 8+)

Ranking most borrowed books

Cumulative borrowing counts

Moving averages

✔️ CASE Expressions

Categorize books (Classic / Regular / New Arrival)

Active/Inactive membership status based on borrowing history

▶️ How to Run the Project

Open MySQL Workbench

Create a new SQL file

Copy and paste the library_management.sql file

Click Run (⚡)

Expand the smart_library schema to view tables

Execute queries individually for testing

📁 Files Included
File Name	Purpose
library_management.sql	Full database creation + queries
README.md	Project documentation
📊 Sample Output Screenshots (Optional for Viva)

You may include:

Table structures

Result of JOIN queries

Window function ranking

Membership status output

🚀 Future Enhancements

Stored procedures for automatic fine calculation

User roles (Admin/Librarian/Student)

Trigger for stock update on return

Web/App UI connected using backend (Python/PHP/Java)

👨‍💻 Author

Nandish Patel
📅 Academic Project — 2025
