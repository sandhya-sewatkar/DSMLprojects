create database BANK;
USE BANK;

CREATE TABLE Account_Type(Account_no INT PRIMARY KEY,Type_Account VARCHAR(500),Manager_id INT,Department_name VARCHAR(500),Opening_Date VARCHAR(50));
SELECT * FROM Account_Type;

CREATE TABLE Departments(Department_id INT PRIMARY KEY,Department_name VARCHAR(500),Manager_id INT,Employee_id INT,Account_no INT,FOREIGN KEY (Account_no) REFERENCES Account_Type(Account_no));
SELECT * FROM Departments;

CREATE TABLE BankDetails(Branch_code INT PRIMARY KEY,Address VARCHAR(500),Department_id INT,Branch_name VARCHAR(500),State VARCHAR(500),FOREIGN KEY (Department_id) REFERENCES Departments(Department_id));
SELECT * FROM BankDetails;

CREATE TABLE Job_Details(Job_id VARCHAR(500) PRIMARY KEY,Department_id INT,Branch_code INT,FOREIGN KEY (Department_id) REFERENCES Departments(Department_id),FOREIGN KEY (Branch_code) REFERENCES BankDetails(Branch_code));
SELECT * FROM Job_Details;

CREATE TABLE Employees(Employee_id INT PRIMARY KEY,First_name VARCHAR(500),Department_id INT,Manager_id INT,Job_id VARCHAR(500),Email VARCHAR(500),Hire_Date VARCHAR(500),Phone_no VARCHAR(500), salary INT,FOREIGN KEY (Department_id) REFERENCES Departments(Department_id),FOREIGN KEY (Job_id) REFERENCES Job_Details(Job_id));
SELECT * FROM Employees;

CREATE TABLE Customer(Account_No INT PRIMARY KEY,First_Name VARCHAR(500),City VARCHAR(500),Branch_code INT,Employee_id INT,Phone_no VARCHAR(500),ATM_NO INT UNIQUE,Exp_date VARCHAR(500),Pin_No INT UNIQUE,FOREIGN KEY (Branch_code) REFERENCES BankDetails(Branch_code),FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id));
SELECT * FROM Customer;


/*
After inserting the data, solve these Queries.
● Find an employee’s whose id is 52 and branch name is icicp.
● Write a query to fetch all the details who doesn’t belong to
mumbai, pune, delhi . [table_name:Bank details]
● Find details department name, address, branch code, dept _id,
city of the account no 18190.
● Find department id, department name, job id whose only work in
Loan, HR, admin.
● Find the type_account, state account number whose atm no
422748663.
● Create a view with that show address, branch name, department
name, first name. phone no.
● Create view city, department name whose opening date is less
than 24 May 04
● Create view only job id for clerk, manager, an accountant with all
detail and name it employee job_deatils
● In the Customer table change the atm_no 423295535 with
42321992.
● In the Account_type table change all sales account into admin.

*/
-- ● Find an employee’s whose id is 52 and branch name is icic_p
SELECT * FROM EMPLOYEES,BankDetails WHERE Employee_id = 52 AND Branch_name = 'icic_p';
                            -- or
SELECT * FROM employees INNER JOIN bankdetails ON employees.Department_id = bankdetails.Department_id WHERE employees.Employee_id = 52 AND bankdetails.Branch_name = 'icic_p';

-- ● Write a query to fetch all the details who doesn’t belong to mumbai, pune, delhi . [table_name:Bank details]
SELECT * FROM BankDetails WHERE Address NOT IN ('mumbai', 'pune', 'delhi');

-- ● Find details department name, address, branch code, dept _id,city of the account no 18190.

SELECT d.department_name, b.address, b.branch_code, d.department_id, c.city
FROM departments d
JOIN bankdetails b ON d.department_id = b.department_id
JOIN customer c ON b.Branch_code = c.Branch_code
WHERE d.account_no = 18190;

-- ● Find department id, department name, job id whose only work in Loan, HR, admin.

SELECT d.department_id, d.department_name, j.job_id
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN Job_Details j ON e.job_id = j.job_id
WHERE d.department_name IN ('Loan', 'HR', 'Admin');

-- ● Find the type_account, state account number whose atm no 422748663.

SELECT c.first_name, A.type_account, A.account_no
FROM Account_Type A
JOIN customer c ON a.account_no = c.account_no
JOIN bankdetails BD ON C.Branch_code = BD.Branch_code
WHERE c. ATM_NO = 422748663;

-- OR

SELECT A.type_account, A.account_no
FROM Account_Type A
WHERE a.account_no = (
    SELECT c.account_no
    FROM customer c
    WHERE c.ATM_NO = 422748663
);




-- ● Create a view with that show address, branch name, department name, first name. phone no.
CREATE VIEW v1 AS
SELECT BD.address, BD.branch_name, d.department_name, c.first_name, c.phone_no
FROM BankDetails BD JOIN departments d ON BD.department_id = d.department_id JOIN customer c ON BD.Branch_code = c.Branch_code;

SELECT * FROM v1;



-- ● Create view city, department name whose opening date is less than 24 May 04


CREATE VIEW V2 AS
SELECT C.city, d.department_name
FROM DEPARTMENTS d
JOIN Account_Type A ON d.Account_no = A.Account_no
JOIN CUSTOMER C ON A.Account_no = C.Account_no
WHERE A.Opening_Date < '24 May 04';
SELECT * FROM V2;

-- ● Create view only job id for clerk, manager, an accountant with all detail and name it employee job_deatils

CREATE VIEW employee_job_details AS
SELECT *
FROM employees
WHERE job_id IN ('ST_CLERK', 'ST_MAN', 'FI_ACCOUNT');
SELECT * FROM employee_job_details;


-- ● In the Customer table change the atm_no 423295535 with 42321992.
UPDATE customer SET atm_nO = 42321992 WHERE atm_nO = 423295535;
SELECT * FROM CUSTOMER;

-- ● In the Account_type table change all sales account into admin.
UPDATE account_type SET type_account = 'ADMIN' WHERE type_account = 'SALES';
SELECT * FROM account_type;

desc account_type;
USE BANK;
show tables;
-- #######################################################################################################################

