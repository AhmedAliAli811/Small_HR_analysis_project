use HR;
go


-- department of each employee
select e.employee_id ,
	   e.first_name + ' ' + e.last_name as Employee_Name ,
	   d.department_id ,
	   d.department_name
from employees e join departments d 
on e.department_id = d.department_id



-- All managers and employees they manage
select mgr.employee_id as manager_id ,
	   mgr.first_name + ' ' + mgr.last_name as Manager_Name ,
	   e.employee_id , e.first_name + ' ' + e.last_name as Employee_Name
from employees e join employees mgr 
on e.manager_id = mgr.employee_id
order by mgr.employee_id

-- Number of employees managed by each manager
select mgr.employee_id as manager_id ,
	   mgr.first_name + ' ' + mgr.last_name as Manager_Name ,
	   count(e.employee_id) as count
from employees e join employees mgr 
on e.manager_id = mgr.employee_id
group by mgr.employee_id , mgr.first_name , mgr.last_name
order by count desc



-- Number of employee at each job title
select j.job_id ,
	   j.job_title  ,
	   count(employee_id) num_of_employees
from employees e join jobs j
on e.job_id = j.job_id
group by j.job_id , j.job_title 


-- Compare employee salaries with the salaries set by the company.
select j.job_id ,
	   j.job_title ,
	   j.min_salary as Company_min_Salary ,
	   j.max_salary as Company_max_Salary ,
	   min(e.salary) as min_acutal_salary ,
	   max(e.salary) as max_acutal_salary,
	   avg(e.salary) as avg_actual_salary
from employees e join jobs j
on e.job_id = j.job_id
group by j.job_id , j.job_title ,j.min_salary , j.max_salary


-- Promoted employees
select e.employee_id , e.first_name + ' ' + e.last_name as Employee_Name ,
	   jh.start_date , jh.end_date ,
	   j1.job_id , j1.job_title , 
	   d.department_name
from job_history jh join employees e
on jh.employee_id = e.employee_id join jobs j1 
on jh.job_id = j1.job_id join departments d 
on jh.department_id = d.department_id
where jh.employee_id IN (
        select employee_id 
        from job_history 
        group by employee_id 
        having count(*) > 1
    )
order by e.employee_id , jh.start_date




-- number of employee and salary information at each department
select d.department_id ,
	   d.department_name ,
	   count(e.employee_id) as number_of_employees ,
	   avg(e.salary) as avg_salary , sum(e.salary) as total_salary
from departments d join employees e 
on d.department_id = e.department_id
group by d.department_id , d.department_name
order by number_of_employees desc


-- number of employees at each city and avg salary
select c.country_name ,
	   c.country_id ,
	   l.city ,
	   count(*) num_empolyees ,
	   avg(e.salary) as avg_salary
from departments d join employees e 
on d.department_id = e.department_id join locations l
on d.location_id = l.location_id join countries c
on l.country_id = c.country_id
group by c.country_name , c.country_id , l.city
order by num_empolyees desc

-- turn over rate for each manager 
select m.employee_id as manager_id,
    m.first_name + ' ' + m.last_name as manager_Name ,
    count(distinct e.employee_id) as total_employees,
    count(distinct jh.employee_id) as employees_left,
    round(count(distinct jh.employee_id) * 1.0 / count(distinct e.employee_id), 2) as turnover_rate
from employees m 
join employees e on m.employee_id = e.manager_id
left join job_history jh on e.employee_id = jh.employee_id 
group by m.employee_id, m.first_name, m.last_name
order by turnover_rate desc







