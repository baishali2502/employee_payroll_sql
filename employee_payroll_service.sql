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

SELECT * FROM employee_payroll;