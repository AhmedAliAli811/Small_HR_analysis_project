use hr;
Go
-- Data Cleaning --
-- remove commisiion_pct from emplyees table "All values are nulls"

alter table employees
drop column commission_pct

select * from countries
select * from departments
select * from employees
select * from job_history
select * from jobs
select * from locations
select * from regions

-- Delete update employees where department_id in non-existent countries 

update employees
set department_id = NULL
where department_id in (
select d.department_id
from departments d
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
where c.country_name = 'Israel')

-- Delete departments in non-existent countries 
delete from departments
where department_id in (
select d.department_id
from departments d
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
where c.country_name = 'Israel'
)

-- remove rubbish counteries
delete from countries
where country_name = 'Israel'

-- update salaries that less than 0 by multiply it by -1

update employees
set salary *= -1 
where salary < 0


-- Update employees with a salary of zero with the average salary in the job ID
update employees
set salary = avg_salaries.avg_salary
from employees JOIN (
    select job_id, avg(salary) as avg_salary
    from employees
    where salary > 0
    group by job_id
) as avg_salaries
on employees.job_id = avg_salaries.job_id
where employees.salary = 0;
