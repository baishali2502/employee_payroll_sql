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
