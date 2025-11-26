
# 📚 Smart Library Management System

This project is a fully functional MySQL-based Library Management System designed for academic and practical learning purposes. It demonstrates how to create, manage, and query a relational database using SQL concepts such as CRUD operations, joins, constraints, aggregate functions, subqueries, procedures, and more.

---

## 🏗️ Features Included

✔ Database Creation  
✔ Table Schema with Primary & Foreign Keys  
✔ Sample Dataset Insertions  
✔ CRUD Operations (Create, Read, Update, Delete)  
✔ SQL Clauses (WHERE, HAVING, LIMIT, LIKE)  
✔ Sorting & Grouping (ORDER BY, GROUP BY)  
✔ Aggregate Functions (SUM, AVG, COUNT, MAX, MIN)  
✔ Joins (INNER, LEFT, RIGHT, FULL OUTER UNION)  
✔ Subqueries  
✔ Date & Time Functions  
✔ String Functions (UPPER, LOWER, TRIM, REPLACE)  
✔ Case Expressions  
✔ Window Functions  
✔ Output & Verification Queries  

---

## 📁 Database Details

**Database Name:** `smart_library`

### Tables Created:
| Table Name | Purpose |
|------------|---------|
| `Authors` | Stores author details |
| `Books` | Stores book metadata and availability |
| `Members` | Library member information |
| `Transactions` | Records borrowing history |

---

## 🔑 Key Relationships

| Parent Table | Child Table | Type |
|--------------|-------------|------|
| `Authors(author_id)` | `Books(author_id)` | Foreign Key |
| `Members(member_id)` | `Transactions(member_id)` | Foreign Key |
| `Books(book_id)` | `Transactions(book_id)` | Foreign Key |

---

## 📌 Sample Output Queries Included

The script also includes:

- `SHOW TABLES;` → To confirm table creation  
- `DESCRIBE <table>` → To view structure  
- `SELECT * FROM <table>` → To verify data  
- Summary query showing:
  - Total books  
  - Total authors  
  - Borrowed books  
  - Pending fines  

---

## 🚀 How to Run

1. Open **MySQL Workbench / XAMPP / phpMyAdmin**  
2. Import the SQL file: `Smart_Library_With_Output.sql`  
3. Run the script using the ⚡ **Execute All** button  
4. Scroll the result panel to view output tables

---

## 📊 Example Output Summary

| Metric | Example Value |
|--------|--------------|
| Total Books | 15 |
| Total Members | 10 |
| Most Borrowed Book | Harry Potter Series |

---

## 🧪 Testing & Validation Queries Included

Examples:

```sql
SELECT * FROM Books WHERE available_copies = 0;

SELECT m.name, COUNT(t.transaction_id) AS borrowed_count
FROM Members m
LEFT JOIN Transactions t ON m.member_id = t.member_id
GROUP BY m.member_id;
```

---

## 🏁 Conclusion

This SQL project provides a complete understanding of:

- Database design  
- SQL querying  
- Practical implementation of relationships  
- Real‑world library system logic  

It is suitable for:

🎓 Academic submission  
🧪 SQL practice  
📘 Mini-projects  
🏢 Foundation for DBMS Systems  

---

💡 If you want a **PDF copy**, **ER Diagram**, or **ZIP Submission Package**, just ask!

---

### 👨‍💻 Created by: _[Your Name]_
