USE HR;

/* *************************************************************** 
***************************CREATING TABLES************************
**************************************************************** */
CREATE TABLE regions (
	region_id INT NOT NULL,
	region_name VARCHAR(25),
	PRIMARY KEY (region_id)
);

CREATE TABLE countries (
	country_id CHAR(2) NOT NULL,
	country_name VARCHAR(40),
	region_id INT NOT NULL,
	PRIMARY KEY (country_id)
);

CREATE TABLE locations (
	location_id INT NOT NULL IDENTITY(1,1),
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25),
	country_id CHAR(2) NOT NULL,
	PRIMARY KEY (location_id)
);

CREATE TABLE departments (
	department_id INT NOT NULL,
	department_name VARCHAR(30) NOT NULL,
	manager_id INT,
	location_id INT,
	PRIMARY KEY (department_id)
);

CREATE TABLE jobs (
	job_id VARCHAR(10) NOT NULL,
	job_title VARCHAR(35) NOT NULL,
	min_salary DECIMAL(8, 0),
	max_salary DECIMAL(8, 0),
	PRIMARY KEY (job_id)
);

CREATE TABLE employees (
	employee_id INT NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(20),
	hire_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary DECIMAL(8, 2) NOT NULL,
	commission_pct DECIMAL(2, 2),
	manager_id INT,
	department_id INT,
	PRIMARY KEY (employee_id)
);

CREATE TABLE job_history (
	employee_id INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	department_id INT NOT NULL,
	UNIQUE (employee_id, start_date)
);

CREATE VIEW emp_details_view
AS
SELECT e.employee_id,
	e.job_id,
	e.manager_id,
	e.department_id,
	d.location_id,
	l.country_id,
	e.first_name,
	e.last_name,
	e.salary,
	e.commission_pct,
	d.department_name,
	j.job_title,
	l.city,
	l.state_province,
	c.country_name,
	r.region_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id;

/* *************************************************************** 
***************************INSERTING DATA*************************
**************************************************************** */

-- Insert data into regions table
INSERT INTO regions (region_id, region_name) VALUES 
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

-- Insert data into countries table
INSERT INTO countries (country_id, country_name, region_id) VALUES 
('IT', 'Italy', 1),
('JP', 'Japan', 3),
('US', 'United States of America', 2),
('CA', 'Canada', 2),
('CN', 'China', 3),
('IN', 'India', 3),
('AU', 'Australia', 3),
('ZW', 'Zimbabwe', 4),
('SG', 'Singapore', 3),
('UK', 'United Kingdom', 1),
('FR', 'France', 1),
('DE', 'Germany', 1),
('ZM', 'Zambia', 4),
('EG', 'Egypt', 4),
('BR', 'Brazil', 2),
('CH', 'Switzerland', 1),
('NL', 'Netherlands', 1),
('MX', 'Mexico', 2),
('KW', 'Kuwait', 4),
('IL', 'Israel', 4),
('DK', 'Denmark', 1),
('HK', 'HongKong', 3),
('NG', 'Nigeria', 4),
('AR', 'Argentina', 2),
('BE', 'Belgium', 1);
-- Start a transaction
BEGIN TRANSACTION;

-- Enable IDENTITY_INSERT for locations table
SET IDENTITY_INSERT locations ON;

-- Insert data into locations table
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES 
(1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
(2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
(2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK'),
(2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
(2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
(2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
(3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
(3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', 'MX');

-- Disable IDENTITY_INSERT for locations table
SET IDENTITY_INSERT locations OFF;

-- Commit the transaction
COMMIT;

-- Start a transaction
BEGIN TRANSACTION;

-- Insert data into departments table
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES 
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2700),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120, 'Treasury', NULL, 1700),
(130, 'Corporate Tax', NULL, 1700),
(140, 'Control And Credit', NULL, 1700),
(150, 'Shareholder Services', NULL, 1700),
(160, 'Benefits', NULL, 1700),
(170, 'Manufacturing', NULL, 1700),
(180, 'Construction', NULL, 1700),
(190, 'Contracting', NULL, 1700),
(200, 'Operations', NULL, 1700),
(210, 'IT Support', NULL, 1700),
(220, 'NOC', NULL, 1700),
(230, 'IT Helpdesk', NULL, 1700),
(240, 'Government Sales', NULL, 1700),
(250, 'Retail Sales', NULL, 1700),
(260, 'Recruiting', NULL, 1700),
(270, 'Payroll', NULL, 1700);

-- Commit the transaction
COMMIT;
-- Start a transaction
BEGIN TRANSACTION;

-- Insert data into jobs table
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES 
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('AC_MGR', 'Accounting Manager', 8200, 16000),
('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('PU_MAN', 'Purchasing Manager', 8000, 15000),
('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('SH_CLERK', 'Shipping Clerk', 2500, 5500),
('IT_PROG', 'Programmer', 4000, 10000),
('MK_MAN', 'Marketing Manager', 9000, 15000),
('MK_REP', 'Marketing Representative', 4000, 9000),
('HR_REP', 'Human Resources Representative', 4000, 9000),
('PR_REP', 'Public Relations Representative', 4500, 10500);

-- Commit the transaction
COMMIT;

-- Insert employee records into the employees table
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP', 17000, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 'IT_PROG', 9000, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 'IT_PROG', 6000, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1997-06-25', 'IT_PROG', 4800, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1998-02-05', 'IT_PROG', 4800, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 'IT_PROG', 4200, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1994-08-17', 'FI_MGR', 12000, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1994-08-16', 'FI_ACCOUNT', 9000, NULL, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '515.124.4269', '1997-09-28', 'FI_ACCOUNT', 8200, NULL, 108, 100),
(111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1997-09-30', 'FI_ACCOUNT', 7700, NULL, 108, 100),
(112, 'Jose Manuel', 'Urman', 'JURMAN', '515.124.4469', '1998-03-07', 'FI_ACCOUNT', 7800, NULL, 108, 100),
(113, 'Luis', 'Popp', 'LPOPP', '515.124.4568', '1997-12-31', 'FI_ACCOUNT', 6900, NULL, 108, 100),
(114, 'Den', 'Oliv', 'DOLIV', '515.124.4569', '1997-12-31', 'FI_ACCOUNT', 5400, NULL, 108, 100),
(115, 'Lia', 'Paulson', 'LPAULSON', '515.124.4570', '1998-01-05', 'FI_ACCOUNT', 5700, NULL, 108, 100),
(116, 'Bill', 'Smith', 'BSMITH', '515.124.4571', '1999-07-01', 'FI_ACCOUNT', 5200, NULL, 108, 100);

-- Insert employee records into the employees table

-- Insert employee records into the employees table

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES 
(117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', CONVERT(date, '1997-07-24', 120), 'PU_CLERK', 2800, NULL, 114, 30),
(118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', CONVERT(date, '1996-11-15', 120), 'PU_CLERK', 2600, NULL, 114, 30),
(119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', CONVERT(date, '1997-07-05', 120), 'PU_CLERK', 2500, NULL, 114, 30),
(120, 'John', 'Russell', 'JRUSSELL', '515.127.4567', CONVERT(date, '1998-01-22', 120), 'ST_CLERK', 2400, NULL, 116, 50),
(121, 'Laura', 'Benson', 'LBENSON', '515.127.4568', CONVERT(date, '1999-03-15', 120), 'ST_CLERK', 2300, NULL, 116, 50),
(122, 'Mat', 'Hicks', 'MHICKS', '515.127.4569', CONVERT(date, '2000-04-10', 120), 'ST_CLERK', 2200, NULL, 116, 50),
(123, 'David', 'Austin', 'DAUSTIN', '515.127.4570', CONVERT(date, '2001-06-08', 120), 'ST_CLERK', 2100, NULL, 116, 50),
(124, 'Rebecca', 'Warren', 'RWARREN', '515.127.4571', CONVERT(date, '2002-07-22', 120), 'ST_CLERK', 2000, NULL, 116, 50),
(125, 'Brian', 'Fisher', 'BFISHER', '515.127.4572', CONVERT(date, '2003-08-19', 120), 'ST_CLERK', 1900, NULL, 116, 50),
(126, 'Jane', 'Sweeney', 'JSWEENEY', '515.127.4573', CONVERT(date, '2004-09-28', 120), 'ST_CLERK', 1800, NULL, 116, 50),
(127, 'Steve', 'Lee', 'SLEE', '515.127.4574', CONVERT(date, '2005-10-11', 120), 'ST_CLERK', 1700, NULL, 116, 50),
(128, 'Nancy', 'Davis', 'NDAVIS', '515.127.4575', CONVERT(date, '2006-11-14', 120), 'ST_CLERK', 1600, NULL, 116, 50),
(129, 'Matthew', 'Johnson', 'MJOHNSON', '515.127.4576', CONVERT(date, '2007-12-13', 120), 'ST_CLERK', 1500, NULL, 116, 50),
(130, 'Maria', 'Smith', 'MSMITH', '515.127.4577', CONVERT(date, '2008-01-29', 120), 'ST_CLERK', 1400, NULL, 116, 50),
(131, 'Patricia', 'Moore', 'PMOORE', '515.127.4578', CONVERT(date, '2009-02-15', 120), 'ST_CLERK', 1300, NULL, 116, 50),
(132, 'Charles', 'Brown', 'CBROWN', '515.127.4579', CONVERT(date, '2010-03-12', 120), 'ST_CLERK', 1200, NULL, 116, 50),
(133, 'James', 'Williams', 'JWILLIAMS', '515.127.4580', CONVERT(date, '2011-04-10', 120), 'ST_CLERK', 1100, NULL, 116, 50),
(134, 'Robert', 'Jones', 'RJOHNSON', '515.127.4581', CONVERT(date, '2012-05-14', 120), 'ST_CLERK', 1000, NULL, 116, 50),
(135, 'Michael', 'Taylor', 'MTAYLOR', '515.127.4582', CONVERT(date, '2013-06-22', 120), 'ST_CLERK', 900, NULL, 116, 50),
(136, 'William', 'Anderson', 'WANDERSON', '515.127.4583', CONVERT(date, '2014-07-15', 120), 'ST_CLERK', 800, NULL, 116, 50),
(137, 'Richard', 'Thomas', 'RTHOMAS', '515.127.4584', CONVERT(date, '2015-08-20', 120), 'ST_CLERK', 700, NULL, 116, 50),
(138, 'Daniel', 'Jackson', 'DJACKSON', '515.127.4585', CONVERT(date, '2016-09-18', 120), 'ST_CLERK', 600, NULL, 116, 50),
(139, 'Christopher', 'White', 'CWHITE', '515.127.4586', CONVERT(date, '2017-10-05', 120), 'ST_CLERK', 500, NULL, 116, 50),
(140, 'Matthew', 'Harris', 'MHARRIS', '515.127.4587', CONVERT(date, '2018-11-09', 120), 'ST_CLERK', 400, NULL, 116, 50),
(141, 'Anthony', 'Martin', 'AMARTIN', '515.127.4588', CONVERT(date, '2019-12-23', 120), 'ST_CLERK', 300, NULL, 116, 50),
(142, 'Paul', 'Thompson', 'PTHOMPSON', '515.127.4589', CONVERT(date, '2020-01-15', 120), 'ST_CLERK', 200, NULL, 116, 50),
(143, 'John', 'Garcia', 'JGARCI', '515.127.4590', CONVERT(date, '2021-02-11', 120), 'ST_CLERK', 100, NULL, 116, 50),
(144, 'James', 'Martinez', 'JMARTINEZ', '515.127.4591', CONVERT(date, '2022-03-09', 120), 'ST_CLERK', 90, NULL, 116, 50),
(145, 'Robert', 'Lopez', 'RLOPEZ', '515.127.4592', CONVERT(date, '2023-04-25', 120), 'ST_CLERK', 80, NULL, 116, 50),
(146, 'Michael', 'Miller', 'MMILLER', '515.127.4593', CONVERT(date, '2024-05-14', 120), 'ST_CLERK', 70, NULL, 116, 50),
(147, 'William', 'Wilson', 'WWILSON', '515.127.4594', CONVERT(date, '2024-06-17', 120), 'ST_CLERK', 60, NULL, 116, 50),
(148, 'David', 'Moore', 'DMOORE', '515.127.4595', CONVERT(date, '2024-07-20', 120), 'ST_CLERK', 50, NULL, 116, 50),
(149, 'Richard', 'Taylor', 'RTAYLOR', '515.127.4596', CONVERT(date, '2024-08-30', 120), 'ST_CLERK', 40, NULL, 116, 50),
(150, 'Charles', 'Anderson', 'CANDERSON', '515.127.4597', CONVERT(date, '2024-09-15', 120), 'ST_CLERK', 30, NULL, 116, 50),
(151, 'Joseph', 'Thomas', 'JTHOMAS', '515.127.4598', CONVERT(date, '2024-10-12', 120), 'ST_CLERK', 20, NULL, 116, 50),
(152, 'James', 'Harris', 'JHARRIS', '515.127.4599', CONVERT(date, '2024-11-11', 120), 'ST_CLERK', 10, NULL, 116, 50),
(153, 'John', 'Clark', 'JCLARK', '515.127.4600', CONVERT(date, '2024-12-08', 120), 'ST_CLERK', 5, NULL, 116, 50),
(154, 'Richard', 'Lewis', 'RLEWIS', '515.127.4601', CONVERT(date, '2024-12-20', 120), 'ST_CLERK', 4, NULL, 116, 50),
(155, 'Charles', 'Roberts', 'CROBERTS', '515.127.4602', CONVERT(date, '2024-12-25', 120), 'ST_CLERK', 3, NULL, 116, 50),
(156, 'Michael', 'Walker', 'MWALKER', '515.127.4603', CONVERT(date, '2024-12-30', 120), 'ST_CLERK', 2, NULL, 116, 50),
(157, 'Joseph', 'Young', 'JYOUNG', '515.127.4604', CONVERT(date, '2024-12-31', 120), 'ST_CLERK', 1, NULL, 116, 50),
(158, 'James', 'King', 'JKING', '515.127.4605', CONVERT(date, '2024-12-15', 120), 'ST_CLERK', 0, NULL, 116, 50),
(159, 'Robert', 'Scott', 'RSCOTT', '515.127.4606', CONVERT(date, '2024-12-10', 120), 'ST_CLERK', -10, NULL, 116, 50),
(160, 'John', 'Green', 'JGREEN', '515.127.4607', CONVERT(date, '2024-12-05', 120), 'ST_CLERK', -20, NULL, 116, 50),
(161, 'David', 'Adams', 'DADAMS', '515.127.4608', CONVERT(date, '2024-12-01', 120), 'ST_CLERK', -30, NULL, 116, 50),
(162, 'Michael', 'Baker', 'MBAKER', '515.127.4609', CONVERT(date, '2024-11-28', 120), 'ST_CLERK', -40, NULL, 116, 50),
(163, 'James', 'Gonzalez', 'JGONZALEZ', '515.127.4610', CONVERT(date, '2024-11-25', 120), 'ST_CLERK', -50, NULL, 116, 50),
(164, 'John', 'Nelson', 'JNELSON', '515.127.4611', CONVERT(date, '2024-11-20', 120), 'ST_CLERK', -60, NULL, 116, 50),
(165, 'Michael', 'Carter', 'MCARTER', '515.127.4612', CONVERT(date, '2024-11-10', 120), 'ST_CLERK', -70, NULL, 116, 50),
(166, 'Robert', 'Mitchell', 'RMITCHELL', '515.127.4613', CONVERT(date, '2024-11-05', 120), 'ST_CLERK', -80, NULL, 116, 50),
(167, 'David', 'Perez', 'DPEREZ', '515.127.4614', CONVERT(date, '2024-10-25', 120), 'ST_CLERK', -90, NULL, 116, 50),
(168, 'James', 'Roberts', 'JROBERTS', '515.127.4615', CONVERT(date, '2024-10-15', 120), 'ST_CLERK', -100, NULL, 116, 50),
(169, 'Michael', 'Turner', 'MTURNER', '515.127.4616', CONVERT(date, '2024-10-05', 120), 'ST_CLERK', -110, NULL, 116, 50),
(170, 'Robert', 'Phillips', 'RPHILLIPS', '515.127.4617', CONVERT(date, '2024-09-28', 120), 'ST_CLERK', -120, NULL, 116, 50),
(171, 'David', 'Campbell', 'DCAMPBELL', '515.127.4618', CONVERT(date, '2024-09-20', 120), 'ST_CLERK', -130, NULL, 116, 50),
(172, 'Michael', 'Parker', 'MPARKER', '515.127.4619', CONVERT(date, '2024-09-10', 120), 'ST_CLERK', -140, NULL, 116, 50),
(173, 'Robert', 'Evans', 'REvANS', '515.127.4620', CONVERT(date, '2024-08-30', 120), 'ST_CLERK', -150, NULL, 116, 50),
(174, 'David', 'Edwards', 'DEDWARDS', '515.127.4621', CONVERT(date, '2024-08-20', 120), 'ST_CLERK', -160, NULL, 116, 50),
(175, 'Michael', 'Morris', 'MMORRIS', '515.127.4622', CONVERT(date, '2024-08-15', 120), 'ST_CLERK', -170, NULL, 116, 50),
(176, 'Robert', 'Murphy', 'RMURPHY', '515.127.4623', CONVERT(date, '2024-08-10', 120), 'ST_CLERK', -180, NULL, 116, 50),
(177, 'David', 'Rogers', 'DROGERS', '515.127.4624', CONVERT(date, '2024-08-05', 120), 'ST_CLERK', -190, NULL, 116, 50),
(178, 'Michael', 'Reed', 'MREED', '515.127.4625', CONVERT(date, '2024-07-30', 120), 'ST_CLERK', -200, NULL, 116, 50),
(179, 'Robert', 'Cook', 'RCOOK', '515.127.4626', CONVERT(date, '2024-07-25', 120), 'ST_CLERK', -210, NULL, 116, 50),
(180, 'David', 'Morgan', 'DMORGAN', '515.127.4627', CONVERT(date, '2024-07-20', 120), 'ST_CLERK', -220, NULL, 116, 50),
(181, 'Michael', 'Bell', 'MBELL', '515.127.4628', CONVERT(date, '2024-07-15', 120), 'ST_CLERK', -230, NULL, 116, 50),
(182, 'Robert', 'Hughes', 'RHUGHES', '515.127.4629', CONVERT(date, '2024-07-10', 120), 'ST_CLERK', -240, NULL, 116, 50),
(183, 'David', 'Bailey', 'DBAILEY', '515.127.4630', CONVERT(date, '2024-07-05', 120), 'ST_CLERK', -250, NULL, 116, 50),
(184, 'Michael', 'Bell', 'MBELL', '515.127.4631', CONVERT(date, '2024-06-30', 120), 'ST_CLERK', -260, NULL, 116, 50),
(185, 'Robert', 'Alexander', 'RALEXANDER', '515.127.4632', CONVERT(date, '2024-06-25', 120), 'ST_CLERK', -270, NULL, 116, 50),
(186, 'David', 'Wright', 'DWright', '515.127.4633', CONVERT(date, '2024-06-20', 120), 'ST_CLERK', -280, NULL, 116, 50),
(187, 'Michael', 'Collins', 'MCOLLINS', '515.127.4634', CONVERT(date, '2024-06-15', 120), 'ST_CLERK', -290, NULL, 116, 50),
(188, 'Robert', 'Turner', 'RTURNER', '515.127.4635', CONVERT(date, '2024-06-10', 120), 'ST_CLERK', -300, NULL, 116, 50),
(189, 'David', 'Cook', 'DCOOK', '515.127.4636', CONVERT(date, '2024-06-05', 120), 'ST_CLERK', -310, NULL, 116, 50),
(190, 'Michael', 'Brooks', 'MBROOKS', '515.127.4637', CONVERT(date, '2024-05-30', 120), 'ST_CLERK', -320, NULL, 116, 50),
(191, 'Robert', 'Howard', 'RHOWARD', '515.127.4638', CONVERT(date, '2024-05-25', 120), 'ST_CLERK', -330, NULL, 116, 50),
(192, 'David', 'Ward', 'DWARD', '515.127.4639', CONVERT(date, '2024-05-20', 120), 'ST_CLERK', -340, NULL, 116, 50),
(193, 'Michael', 'Watson', 'MWATSON', '515.127.4640', CONVERT(date, '2024-05-15', 120), 'ST_CLERK', -350, NULL, 116, 50),
(194, 'Robert', 'Bennett', 'RBENNETT', '515.127.4641', CONVERT(date, '2024-05-10', 120), 'ST_CLERK', -360, NULL, 116, 50),
(195, 'David', 'Gray', 'DGRAY', '515.127.4642', CONVERT(date, '2024-05-05', 120), 'ST_CLERK', -370, NULL, 116, 50),
(196, 'Michael', 'Kelly', 'MKELLY', '515.127.4643', CONVERT(date, '2024-04-30', 120), 'ST_CLERK', -380, NULL, 116, 50),
(197, 'Robert', 'James', 'RJAMES', '515.127.4644', CONVERT(date, '2024-04-25', 120), 'ST_CLERK', -390, NULL, 116, 50),
(198, 'David', 'Miller', 'DMILLER', '515.127.4645', CONVERT(date, '2024-04-20', 120), 'ST_CLERK', -400, NULL, 116, 50),
(199, 'Michael', 'Lee', 'MLEE', '515.127.4646', CONVERT(date, '2024-04-15', 120), 'ST_CLERK', -410, NULL, 116, 50),
(200, 'Robert', 'Moore', 'RMOORE', '515.127.4647', CONVERT(date, '2024-04-10', 120), 'ST_CLERK', -420, NULL, 116, 50);

-- Use the CONVERT function for date conversion in SQL Server

INSERT INTO job_history
VALUES (
	102,
	CONVERT(date, '1993-01-13', 120),
	CONVERT(date, '1998-07-24', 120),
	'IT_PROG',
	60
);

INSERT INTO job_history
VALUES (
	101,
	CONVERT(date, '1989-09-21', 120),
	CONVERT(date, '1993-10-27', 120),
	'AC_ACCOUNT',
	110
);

INSERT INTO job_history
VALUES (
	101,
	CONVERT(date, '1993-10-28', 120),
	CONVERT(date, '1997-03-15', 120),
	'AC_MGR',
	110
);

INSERT INTO job_history
VALUES (
	201,
	CONVERT(date, '1996-02-27', 120),
	CONVERT(date, '1999-12-19', 120),
	'MK_REP',
	20
);

INSERT INTO job_history
VALUES (
	114,
	CONVERT(date, '1998-03-24', 120),
	CONVERT(date, '1999-12-31', 120),
	'ST_CLERK',
	50
);

INSERT INTO job_history
VALUES (
	122,
	CONVERT(date, '1999-01-01', 120),
	CONVERT(date, '1999-12-31', 120),
	'ST_CLERK',
	50
);

INSERT INTO job_history
VALUES (
	200,
	CONVERT(date, '1987-09-17', 120),
	CONVERT(date, '1993-06-17', 120),
	'AD_ASST',
	90
);

INSERT INTO job_history
VALUES (
	176,
	CONVERT(date, '1998-03-24', 120),
	CONVERT(date, '1998-12-31', 120),
	'SA_REP',
	80
);

INSERT INTO job_history
VALUES (
	176,
	CONVERT(date, '1999-01-01', 120),
	CONVERT(date, '1999-12-31', 120),
	'SA_MAN',
	80
);

INSERT INTO job_history
VALUES (
	200,
	CONVERT(date, '1994-07-01', 120),
	CONVERT(date, '1998-12-31', 120),
	'AC_ACCOUNT',
	90
);

-- Commit is not needed in SQL Server for individual statements but used in transaction blocks
-- COMMIT; -- Uncomment if you're using explicit transactions

/* *************************************************************** 
***************************FOREIGN KEYS***************************
**************************************************************** */
-- Adding foreign key constraints in SQL Server

-- Ensure the referenced tables and columns exist before adding constraints

-- Adding foreign key constraint to countries table
ALTER TABLE countries 
ADD CONSTRAINT FK_countries_regions 
FOREIGN KEY (region_id) REFERENCES regions(region_id);

-- Adding foreign key constraint to locations table
ALTER TABLE locations 
ADD CONSTRAINT FK_locations_countries 
FOREIGN KEY (country_id) REFERENCES countries(country_id);

-- Adding foreign key constraint to departments table
ALTER TABLE departments 
ADD CONSTRAINT FK_departments_locations 
FOREIGN KEY (location_id) REFERENCES locations(location_id);

-- Adding foreign key constraint to employees table
ALTER TABLE employees 
ADD CONSTRAINT FK_employees_jobs 
FOREIGN KEY (job_id) REFERENCES jobs(job_id);

ALTER TABLE employees 
ADD CONSTRAINT FK_employees_departments 
FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Adding foreign key constraint for employee manager relationship
ALTER TABLE employees 
ADD CONSTRAINT FK_employees_manager 
FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

-- Adding foreign key constraint for department manager relationship
ALTER TABLE departments 
ADD CONSTRAINT FK_departments_manager 
FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

-- Adding foreign key constraints to job_history table
ALTER TABLE job_history 
ADD CONSTRAINT FK_job_history_employees 
FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE job_history 
ADD CONSTRAINT FK_job_history_jobs 
FOREIGN KEY (job_id) REFERENCES jobs(job_id);

ALTER TABLE job_history 
ADD CONSTRAINT FK_job_history_departments 
FOREIGN KEY (department_id) REFERENCES departments(department_id);
