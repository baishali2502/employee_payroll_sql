CREATE DATABASE `payroll_service`;
SHOW DATABASES;
USE `payroll_service`;

CREATE TABLE employee_payroll (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255),
    salary DOUBLE,
    start_date DATE
);

INSERT INTO employee_payroll (NAME, salary, start_date) VALUES
('John Doe', 50000.00, '2023-01-01'),
('Jane Smith', 60000.00, '2023-02-15'),
('Bob Johnson', 70000.00, '2023-03-30');
INSERT INTO employee_payroll (NAME, salary, start_date) VALUES
('Bill', 55000.00, '2023-04-10');

SELECT * FROM employee_payroll;

SELECT salary FROM employee_payroll WHERE NAME = 'Bill';
SELECT * FROM employee_payroll WHERE start_date BETWEEN CAST('2018-01-01' AS DATE) AND DATE(NOW());

ALTER TABLE employee_payroll
ADD gender CHAR(1);

UPDATE employee_payroll
SET gender = 'M'
WHERE NAME = 'Bill' OR NAME = 'Charlie';

SELECT * FROM employee_payroll;


INSERT INTO employee_payroll (NAME, salary, start_date, gender)
VALUES
('John Doe', 50000.00, '2023-01-01', 'M'),
('Jane Smith', 60000.00, '2023-02-15', 'F'),
('Bob Johnson', 70000.00, '2023-03-30', 'M'),
('Alice Brown', 55000.00, '2023-04-10', 'F'),
('Charlie Green', 75000.00, '2023-05-20', 'M'),
('Eva White', 65000.00, '2023-06-05', 'F');


-- Sum of salary for Male employees
SELECT SUM(salary) AS total_salary_male
FROM employee_payroll
WHERE gender = 'M';

-- Average salary for Female employees
SELECT AVG(salary) AS avg_salary_female
FROM employee_payroll
WHERE gender = 'F';

-- Minimum salary for Male employees
SELECT MIN(salary) AS min_salary_male
FROM employee_payroll
WHERE gender = 'M';

-- Maximum salary for Female employees
SELECT MAX(salary) AS max_salary_female
FROM employee_payroll
WHERE gender = 'F';

-- Number of Male employees
SELECT COUNT(*) AS count_male
FROM employee_payroll
WHERE gender = 'M';

-- Number of Female employees
SELECT COUNT(*) AS count_female
FROM employee_payroll
WHERE gender = 'F';

ALTER TABLE employee_payroll
ADD COLUMN phone VARCHAR(15),  -- Adjust the length as needed
ADD COLUMN address VARCHAR(255) DEFAULT 'Not Available',  -- Set a default value
ADD COLUMN department VARCHAR(50) NOT NULL;
    
-- Add columns for Basic Pay, Deductions, Taxable Pay, Income Tax, and Net Pay
ALTER TABLE employee_payroll
ADD COLUMN basic_pay DECIMAL(10, 2),
ADD COLUMN deductions DECIMAL(10, 2),
ADD COLUMN taxable_pay DECIMAL(10, 2),
ADD COLUMN income_tax DECIMAL(10, 2),
ADD COLUMN net_pay DECIMAL(10, 2);

-- Insert Terissa into Sales and Marketing Department
INSERT INTO employee_payroll (NAME, salary, start_date, gender, phone, address, department, basic_pay, deductions, taxable_pay, income_tax, net_pay)
VALUES
('Terissa', 60000.00, '2023-07-01', 'F', '123-456-7890', '123 Main St', 'Sales and Marketing', 50000.00, 10000.00, 40000.00, 5000.00, 35000.00);

-- Update Terissa's department to Sales and Marketing
UPDATE employee_payroll
SET department = 'Sales and Marketing'
WHERE NAME = 'Terissa';

DESCRIBE employee_payroll;
-- ----------------------------------------------------------- UC-10 ----------------------------------------------------------------
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(255),
    Location VARCHAR(255)
);
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    NAME VARCHAR(255),
    Gender CHAR(1),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    StartDate DATE,
    CompanyID INT,
    DepartmentID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
DESC Employee;
CREATE TABLE EmployeeDepartment (
    EmployeeID INT,
    DepartmentID INT,
    PRIMARY KEY (EmployeeID, DepartmentID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    BasicPay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    TaxablePay DECIMAL(10, 2),
    IncomeTax DECIMAL(10, 2),
    NetPay DECIMAL(10, 2),
    EmployeeID INT UNIQUE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Populate Company Table
INSERT INTO Company (CompanyID, CompanyName, Location)
VALUES
(1, 'ABC Corp', 'City A'),
(2, 'XYZ Ltd', 'City B');
-- Populate Department Table
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT');
-- Populate Employee Table
INSERT INTO Employee (EmployeeID, NAME, Gender, Phone, Address, StartDate, CompanyID, DepartmentID)
VALUES
(1, 'John', 'M', '123-456-7890', '123 Main St', '2020-01-01', 1, 1),
(2, 'Jane', 'F', '987-654-3210', '456 Oak St', '2019-02-15', 1, 2),
(3, 'Bob', 'M', '111-222-3333', '789 Pine St', '2023-03-30', 2, 3);
-- Additional rows in Employee Table
INSERT INTO Employee (EmployeeID, NAME, Gender, Phone, Address, StartDate, CompanyID, DepartmentID)
VALUES
(4, 'Bill', 'M', '555-1234', '789 Elm St', '2018-01-01', 2, 3),
(5, 'Charlie', 'M', '555-5678', '321 Birch St', '2021-05-20', 1, 1),
(6, 'Alice', 'F', '555-4321', '654 Maple St', '2020-06-05', 2, 2),
(7, 'David', 'M', '555-8765', '987 Pine St', '2019-07-15', 1, 3),
(8, 'Eva', 'F', '555-9876', '159 Oak St', '2017-08-25', 2, 1),
(9, 'Frank', 'M', '555-6543', '753 Cedar St', '2020-09-10', 1, 2),
(10, 'Terissa', 'F', '555-2345', '852 Walnut St', '2023-10-15', 2, 3);
SELECT*FROM Employee;
-- Populate EmployeeDepartment Table (Many-to-Many Relationship)
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID)
VALUES
(1, 1),  -- John in Sales
(2, 2),  -- Jane in Marketing
(3, 3),  -- Bob in IT
(4, 3),  -- Bill in IT
(5, 1),  -- Charlie in Sales
(6, 2),  -- Alice in Marketing
(7, 3),  -- David in IT
(8, 1),  -- Eva in Sales
(9, 2),  -- Frank in Marketing
(10, 3);  -- Terissa in IT

-- Populate Payroll Table
INSERT INTO Payroll (PayrollID, BasicPay, Deductions, TaxablePay, IncomeTax, NetPay, EmployeeID)
VALUES
(1, 50000.00, 10000.00, 40000.00, 5000.00, 35000.00, 1),
(2, 60000.00, 12000.00, 48000.00, 6000.00, 42000.00, 2),
(3, 70000.00, 15000.00, 55000.00, 7000.00, 48000.00, 3),
(4, 45000.00, 9000.00, 36000.00, 4500.00, 31500.00, 4),
(5, 55000.00, 11000.00, 44000.00, 5500.00, 38500.00, 5),
(6, 65000.00, 13000.00, 52000.00, 6500.00, 45500.00, 6),
(7, 75000.00, 16000.00, 59000.00, 7500.00, 51500.00, 7),
(8, 50000.00, 10000.00, 40000.00, 5000.00, 35000.00, 8),
(9, 60000.00, 12000.00, 48000.00, 6000.00, 42000.00, 9),
(10, 70000.00, 15000.00, 55000.00, 7000.00, 48000.00, 10);

-- --------------------------------------------------- UC-11 ------------------------------------------------------------

-- Sum of male and female salaries
SELECT
    SUM(p.BasicPay) AS TotalSalary,
    SUM(CASE WHEN e.Gender = 'M' THEN p.BasicPay ELSE 0 END) AS TotalMaleSalary,
    SUM(CASE WHEN e.Gender = 'F' THEN p.BasicPay ELSE 0 END) AS TotalFemaleSalary
FROM Payroll p
JOIN Employee e ON p.EmployeeID = e.EmployeeID;

-- Average salary of male and female
SELECT
    AVG(p.BasicPay) AS AverageSalary,
    AVG(CASE WHEN e.Gender = 'M' THEN p.BasicPay ELSE NULL END) AS AverageMaleSalary,
    AVG(CASE WHEN e.Gender = 'F' THEN p.BasicPay ELSE NULL END) AS AverageFemaleSalary
FROM Payroll p
JOIN Employee e ON p.EmployeeID = e.EmployeeID;
-- Min. & Max salary for male & female
SELECT
    MIN(p.BasicPay) AS MinSalary,
    MAX(p.BasicPay) AS MaxSalary,
    MIN(CASE WHEN e.Gender = 'M' THEN p.BasicPay ELSE NULL END) AS MinMaleSalary,
    MAX(CASE WHEN e.Gender = 'M' THEN p.BasicPay ELSE NULL END) AS MaxMaleSalary,
    MIN(CASE WHEN e.Gender = 'F' THEN p.BasicPay ELSE NULL END) AS MinFemaleSalary,
    MAX(CASE WHEN e.Gender = 'F' THEN p.BasicPay ELSE NULL END) AS MaxFemaleSalary
FROM Payroll p
JOIN Employee e ON p.EmployeeID = e.EmployeeID;

-- No. of male and female employees
SELECT
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN e.Gender = 'M' THEN 1 END) AS MaleEmployees,
    COUNT(CASE WHEN e.Gender = 'F' THEN 1 END) AS FemaleEmployees
FROM Employee e;

-- ---------------------------------------------- UC-12(Redo UC-4 , 5)  -------------------------------------------------------

-- UC -4 :- 

-- Retrieve all the employee payroll data

SELECT * FROM Payroll;


-- UC-5 :-

-- View Bill's salary .
-- This query involves joining the Employee and Payroll tables based on the common EmployeeID:
SELECT
    e.Name AS EmployeeName,
    p.BasicPay AS Salary
FROM Employee e
JOIN Payroll p ON e.EmployeeID = p.EmployeeID
WHERE e.Name = 'Bill';

-- View the salaries of employees who have joined within the date range from '2018-01-01' until the current date
SELECT
    e.Name AS EmployeeName,
    e.StartDate AS EmployeeStartDate,
    p.BasicPay AS Salary
FROM Employee e
JOIN Payroll p ON e.EmployeeID = p.EmployeeID
WHERE e.StartDate BETWEEN '2018-01-01' AND CURRENT_DATE;