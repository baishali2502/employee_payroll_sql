CREATE DATABASE `payroll_service`;
SHOW DATABASES;
USE `payroll_service`;
CREATE TABLE employee_payroll (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(255),
    salary DOUBLE,
    start_date DATE
);
