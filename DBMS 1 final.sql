Drop Database dbms_practicals;
SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE dbms_practicals;
USE dbms_practicals;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS address_details;
DROP TABLE IF EXISTS customer_master;

CREATE TABLE customer_master (
  cust_no INT PRIMARY KEY,
  fname VARCHAR(30),
  lname VARCHAR(30)
);

CREATE TABLE address_details (
  cust_no INT,
  add1 VARCHAR(50),
  add2 VARCHAR(50),
  state VARCHAR(30),
  city VARCHAR(30),
  pincode VARCHAR(10),
  FOREIGN KEY (cust_no) REFERENCES customer_master(cust_no)
);

INSERT INTO customer_master VALUES
(1, 'xyz', 'pqr'),
(2, 'John', 'Doe');

INSERT INTO address_details VALUES
(1, 'Plot No. 12', 'MG Road', 'Maharashtra', 'Pune', '411001'),
(2, 'Sector 4', 'Nerul', 'Maharashtra', 'Navi Mumbai', '410210');

SELECT c.cust_no, fname, lname, add1, add2, city, state, pincode
FROM customer_master c
JOIN address_details a ON c.cust_no = a.cust_no
WHERE fname = 'xyz' AND lname = 'pqr';

DROP TABLE IF EXISTS fixdeposite_dets;
DROP TABLE IF EXISTS acc_fixdeposite_cust_details;
DROP TABLE IF EXISTS customer_master;

CREATE TABLE customer_master (
  cust_no INT PRIMARY KEY,
  fname VARCHAR(30),
  lname VARCHAR(30)
);

CREATE TABLE acc_fixdeposite_cust_details (
  custno INT,
  acc_fd_no INT,
  FOREIGN KEY (custno) REFERENCES customer_master(cust_no)
);

CREATE TABLE fixdeposite_dets (
  fd_sr_no INT PRIMARY KEY,
  amt DECIMAL(10,2)
);

INSERT INTO customer_master VALUES
(1, 'Raj', 'Patil'),
(2, 'Neha', 'Sharma');

INSERT INTO acc_fixdeposite_cust_details VALUES
(1, 101),
(2, 102);

INSERT INTO fixdeposite_dets VALUES
(101, 8000),
(102, 4000);

SELECT c.fname, c.lname, f.amt
FROM customer_master c
JOIN acc_fixdeposite_cust_details a ON c.cust_no = a.custno
JOIN fixdeposite_dets f ON a.acc_fd_no = f.fd_sr_no
WHERE f.amt > 5000;

DROP TABLE IF EXISTS emp_mstr;
DROP TABLE IF EXISTS branch_master;

CREATE TABLE branch_master (
  branch_no INT PRIMARY KEY,
  branch_name VARCHAR(40)
);

CREATE TABLE emp_mstr (
  e_mpno INT PRIMARY KEY,
  f_name VARCHAR(30),
  l_name VARCHAR(30),
  m_name VARCHAR(30),
  dept VARCHAR(30),
  desg VARCHAR(30),
  branch_no INT,
  FOREIGN KEY (branch_no) REFERENCES branch_master(branch_no)
);

INSERT INTO branch_master VALUES
(1, 'Pune Main'),
(2, 'Mumbai West');

INSERT INTO emp_mstr VALUES
(101, 'Amit', 'Kumar', 'R', 'IT', 'Manager', 1),
(102, 'Sneha', 'Joshi', 'M', 'HR', 'Executive', 2);

SELECT e.e_mpno, e.f_name, e.l_name, e.dept, e.desg, b.branch_name
FROM emp_mstr e
JOIN branch_master b ON e.branch_no = b.branch_no;

DROP TABLE IF EXISTS contact_details;
DROP TABLE IF EXISTS emp_master;

CREATE TABLE emp_master (
  emp_no INT PRIMARY KEY,
  f_name VARCHAR(30),
  l_name VARCHAR(30),
  dept VARCHAR(30)
);

CREATE TABLE contact_details (
  emp_no INT,
  cntc_type VARCHAR(20),
  cntc_data VARCHAR(50),
  FOREIGN KEY (emp_no) REFERENCES emp_master(emp_no)
);

INSERT INTO emp_master VALUES
(1, 'Amit', 'Sharma', 'IT'),
(2, 'Priya', 'Mehta', 'HR');

INSERT INTO contact_details VALUES
(1, 'Email', 'amit@gmail.com');

SELECT e.emp_no, f_name, l_name, dept, cntc_type, cntc_data
FROM emp_master e
LEFT JOIN contact_details c ON e.emp_no = c.emp_no;

SELECT e.emp_no, f_name, l_name, dept, cntc_type, cntc_data
FROM emp_master e
RIGHT JOIN contact_details c ON e.emp_no = c.emp_no;

DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS address_details;
DROP TABLE IF EXISTS customer_master;

CREATE TABLE customer_master (
  cust_no INT PRIMARY KEY,
  fname VARCHAR(30),
  lname VARCHAR(30),
  branch_no INT
);

CREATE TABLE address_details (
  cust_no INT,
  pincode VARCHAR(10),
  FOREIGN KEY (cust_no) REFERENCES customer_master(cust_no)
);

CREATE TABLE branch (
  branch_no INT PRIMARY KEY,
  branch_name VARCHAR(40),
  pincode VARCHAR(10)
);

INSERT INTO customer_master VALUES
(1, 'Ravi', 'Patil', 1),
(2, 'Neha', 'Kulkarni', 2),
(3, 'Aarav', 'Shinde', 3);

INSERT INTO address_details VALUES
(1, '411001'),
(2, '411045'),
(3, '411020');

INSERT INTO branch VALUES
(1, 'Pune Main', '411001'),
(2, 'Mumbai West', '400050');

SELECT fname, lname
FROM customer_master c
JOIN address_details a ON c.cust_no = a.cust_no
WHERE a.pincode NOT IN (SELECT pincode FROM branch);

DROP VIEW IF EXISTS borrower_view;
DROP TABLE IF EXISTS borrower;

CREATE TABLE borrower (
  cust_name VARCHAR(30),
  loan_no INT,
  branch_name VARCHAR(30),
  amount DECIMAL(10,2)
);

INSERT INTO borrower VALUES
('Amit', 101, 'Pune Main', 5000),
('Neha', 102, 'Mumbai West', 7000);

CREATE VIEW borrower_view AS
SELECT cust_name, amount FROM borrower;

SELECT * FROM borrower_view;

INSERT INTO borrower_view VALUES ('Raj', 8000);

UPDATE borrower_view SET amount = 9000 WHERE cust_name = 'Raj';

DELETE FROM borrower_view WHERE cust_name = 'Raj';

DROP VIEW IF EXISTS cust_summary;
DROP TABLE IF EXISTS depositor;

CREATE TABLE depositor (
  cust_name VARCHAR(30),
  acc_no INT
);

INSERT INTO depositor VALUES
('Amit', 501),
('Neha', 502);

CREATE VIEW cust_summary AS
SELECT b.cust_name, d.acc_no
FROM borrower b
JOIN depositor d ON b.cust_name = d.cust_name;

SELECT * FROM cust_summary;

SET FOREIGN_KEY_CHECKS = 1;
