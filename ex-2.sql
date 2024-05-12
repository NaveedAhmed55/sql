-- Build the Schema
-----------------------------------------

CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);

CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


-- 2.1 Select the last name of all employees.
Select LastName From Employees;
-- 2.2 Select the last name of all employees, without duplicates.
Select DISTINCT LastName From Employees;
-- 2.3 Select all the data of employees whose last name is "Smith".
Select * From Employees
Where lastName="smith";
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
Select * From Employees
Where lastName="smith" or lastName="Doe" ;
-- 2.5 Select all the data of employees that work in department 14.
Select * From Employees as e
where e.Department=14;
-- 2.6 Select all the data of employees that work in department 37 or department 77.
Select * From Employees as e
Where e.Department=37 or e.Department=77;
-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT *
FROM Employees
WHERE lastName LIKE 'S%';

-- 2.8 Select the sum of all the departments' budgets.

Select Sum(budget) From Departments
group by name;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
Select count(*), department from Employees as e
left join Departments as d
on  e.department=d.code
group by e.department;
-- 2.10 Select all the data of employees, including each employee's department's data.
select a.name, a.lastname, b.name as Department_name, b.Budget
from employees a join departments b
on a.department = b.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
Select e.name,e.lastname From Employees as e
Left Join Departments  as d
On e.department=d.code
Where d.budget>60000;
-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
Select * From Departments as d
having d.budget>(Select AVG(BUDGET) FROM Departments);
-- 2.14 Select the names of departments with more than two employees.
SELECT d.name 
FROM Departments as d
WHERE (
    SELECT COUNT(*) 
    FROM Employees 
    WHERE Employees.Department = d.code
    GROUP BY Department
) > 2;
-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT e.Name, e.LastName
FROM Employees e 
WHERE e.Department = (
       SELECT sub.Code 
       FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub 
       ORDER BY budget DESC LIMIT 1);
-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO Departments values(11, 'Quality Assurance', 40000);
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO employees values(847219811, 'Mary', 'Moore', 11);
-- 2.17 Reduce the budget of all departments by 10%.
update Departments
set budget=budget*0.9;
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE Employees
SET department=14
WHERE department=77; 
-- 2.19 Delete from the table all employees in the IT department (code 14).
delete from employees
where department=14;
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees as e
where department in (Select code from departments where budget >60000);
-- 2.21 Delete from the table all employees.
delete from employees;