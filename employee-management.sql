--Create the employee database
CREATE DATABASE EmployeeManagementDB;
USE EmployeeManagementDB;

--Create the Department table
CREATE TABLE Department
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

--Insert department data
INSERT INTO Department
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Operations');
SELECT * FROM Department;

--Create the Employee table
CREATE TABLE Employee
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Age INT,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    JobRole VARCHAR(50),
    JoiningDate DATE,
    Email VARCHAR(100),
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

--Insert employee records
INSERT INTO Employee
VALUES
(101, 'Arun Kumar', 'Male', 25, 35000, 1, 'Software Engineer', '2024-06-10', 'arun@gmail.com'),
(102, 'Priya Raj', 'Female', 27, 42000, 2, 'HR Executive', '2023-04-15', 'priya@gmail.com'),
(103, 'Rahul Das', 'Male', 29, 55000, 1, 'Senior Developer', '2022-08-20', 'rahul@gmail.com'),
(104, 'Anjali S', 'Female', 24, 32000, 3, 'Accountant', '2024-01-12', 'anjali@gmail.com'),
(105, 'Vishnu P', 'Male', 31, 60000, 1, 'Team Lead', '2021-03-18', 'vishnu@gmail.com'),
(106, 'Meena K', 'Female', 26, 38000, 4, 'Marketing Executive', '2023-07-05', 'meena@gmail.com'),
(107, 'Sanjay R', 'Male', 28, 45000, 5, 'Operations Executive', '2022-11-10', 'sanjay@gmail.com'),
(108, 'Divya M', 'Female', 30, 52000, 2, 'HR Manager', '2020-09-25', 'divya@gmail.com'),
(109, 'Karthik V', 'Male', 23, 30000, 1, 'Junior Developer', '2025-01-20', 'karthik@gmail.com'),
(110, 'Swetha P', 'Female', 27, 48000, 3, 'Financial Analyst', '2022-05-16', 'swetha@gmail.com'),
(111, 'Ajay Kumar', 'Male', 26, 36000, 4, 'Marketing Analyst', '2023-10-02', 'ajay@gmail.com'),
(112, 'Nisha R', 'Female', 29, 50000, 5, 'Operations Manager', '2021-12-08', 'nisha@gmail.com'),
(113, 'Manoj T', 'Male', 32, 65000, 1, 'Project Manager', '2019-06-24', 'manoj@gmail.com'),
(114, 'Keerthi S', 'Female', 25, 34000, 2, 'HR Executive', '2024-08-14', 'keerthi@gmail.com'),
(115, 'Hari Prasad', 'Male', 30, 47000, 3, 'Senior Accountant', '2021-07-30', 'hari@gmail.com');
SELECT * FROM Employee;

--Display only names and salaries
SELECT EmployeeName, Salary
FROM Employee;

--Employees whose salary is greater than 40,000
SELECT *
FROM Employee
WHERE Salary > 40000;

--Employees from IT
SELECT *
FROM Employee
WHERE DepartmentID = 1;

--Employee with max to min salary
SELECT *
FROM Employee
ORDER BY Salary DESC;

--Employee with min to max salary
SELECT *
FROM Employee
ORDER BY Salary ASC;

--Oldest employee
SELECT *
FROM Employee
ORDER BY Age DESC;

--top 5 highest-paid employees
SELECT TOP 5 *
FROM Employee
ORDER BY Salary DESC;

--Number of employees
SELECT COUNT(*) AS TotalEmployees
FROM Employee;

--Highest salary
SELECT MAX(Salary) AS HighestSalary
FROM Employee;

--Lowest salary
SELECT MIN(Salary) AS LowestSalary
FROM Employee;

--Average salary
SELECT AVG(Salary) AS AverageSalary
FROM Employee;

--Total salary expenditure
SELECT SUM(Salary) AS TotalSalary
FROM Employee;

--employees are in each department
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DepartmentID;

--JOIN
SELECT
    Employee.EmployeeID,
    Employee.EmployeeName,
    Employee.JobRole,
    Employee.Salary,
    Department.DepartmentName
FROM Employee
INNER JOIN Department
ON Employee.DepartmentID = Department.DepartmentID;

--Employees earning above average salary
SELECT *
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);

--Number of employees in each job role
SELECT JobRole, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY JobRole;

--Female employees
SELECT *
FROM Employee
WHERE Gender = 'Female';

---Employees who joined after 2023
SELECT *
FROM Employee
WHERE JoiningDate > '2023-01-01';

--CASE
SELECT
    EmployeeName,
    Salary,
    CASE
        WHEN Salary >= 50000 THEN 'High Salary'
        WHEN Salary >= 35000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory
FROM Employee;

--Employee name + department + salary + category
SELECT
    Employee.EmployeeName,
    Department.DepartmentName,
    Employee.Salary,
    CASE
        WHEN Employee.Salary >= 50000 THEN 'High Salary'
        WHEN Employee.Salary >= 35000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory
FROM Employee
INNER JOIN Department
ON Employee.DepartmentID = Department.DepartmentID;

--categorize employees based on their joining year
SELECT
    EmployeeName,
    JoiningDate,
    CASE
        WHEN JoiningDate < '2022-01-01' THEN 'Experienced'
        WHEN JoiningDate < '2024-01-01' THEN 'Mid-Level'
        ELSE 'Recent Joiner'
    END AS ExperienceCategory
FROM Employee;

--employee gets a salary increase
UPDATE Employee
SET Salary = 40000
WHERE EmployeeID = 101;

SELECT *
FROM Employee
WHERE EmployeeID = 101;

--Delete a record
INSERT INTO Employee
VALUES
(116, 'Test Employee', 'Male', 25, 30000, 1, 'Trainee', '2026-01-01', 'test@gmail.com');

DELETE FROM Employee
WHERE EmployeeID = 116;

--Create a view containing useful employee information--
CREATE VIEW EmployeeDepartmentView AS
SELECT
    Employee.EmployeeID,
    Employee.EmployeeName,
    Employee.JobRole,
    Employee.Salary,
    Department.DepartmentName
FROM Employee
INNER JOIN Department
ON Employee.DepartmentID = Department.DepartmentID;

SELECT *
FROM EmployeeDepartmentView;

