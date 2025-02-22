-- Types of subqueries:
-- Scalar subquery
-- Multiple row subquery
-- Correlated subquery


-- Scalar subquery
-- it always return 1 row and 1 col

-- Find employee whose salary is greater than average salary of employees
select * 
from employee
where salary > (select avg(salary) from employee);

-- equivalent to 
select e.*
from employee e
join (select avg(salary) sal from employee) avg_sal
on e.salary > avg_sal.sal;


-- Multiple subquery
-- subquery which returns multiple col and multiple rows
-- subquery which returns 1 col and multiple rows

-- subquery which returns multiple col and multiple rows
-- Find the employees who earn the highest salary in each department
select * 
from employee
where (dept_name, salary) in (select dept_name, max(salary)
                              from employee
                              group by dept_name);


-- subquery which returns 1 col and multiple rows
-- Find departments which do not have any employee
select *
from department
where dept_name not in (select distinct dept_name from employee);



-- Correlated subquery
-- subquery which is related to outer query

-- Find the employees in each department who earn more than the average salary in that department
select * 
from employee e1
where salary > (select avg(salary) 
                from employee e2 
                where e2.dept_name = e1.dept_name
                );
-- from every record of outer query result subquery runs
-- it runs for all outer results so it is slow.

-- Find department who dont have any employee
select *
from department d
where not exists (select 1 from employee e where e.dept_name = d.dept_name);


-- Nested subquery
-- subquery inside a subquery

-- Find stores which sales are greater than the average sales of all stores

select *
from (select store_name, sum(price) as total_sales
      from sales
      group by store_name) sales
join (select avg(total_sales) as sales
      from (select store_name, sum(price) as total_sales
      from sales
      group by store_name)) avg_sales
on sales.total_sales > avg_sales.sales;      

-- avoid repetitive code

-- above code equivalent to
with sales as
       (select store_name, sum(price) as total_sales
      from sales
      group by store_name)
select *
from sales
join (select avg(total_sales) as sales
      from sales) avg_sales
on sales.total_sales > avg_sales.sales;      





-- Differenct SQL clause where subquery is allowed
-- SELECT
-- FROM
-- WHERE
-- HAVING
-- INSERT 
-- UPDATE
-- DELETE


-- Fetch all employee details and add remarks to those employees who earn more than average pay
select * , 
       (case when salary > (select avg(salary) from employee)
             then 'Higher than average'
             else null
        end ) as remarks
from employee;

-- equivalent to
select * , 
       (case when salary > avg_sal.sal
             then 'Higher than average'
             else null
        end ) as remarks
from employee
cross join(select avg(salary) sal from employee) avg_sal;


-- Find the stores who have sold more units than the average units sold by all stores.
select store_name, sum(quantity)
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);


-- Insert data into employee history table. Make sure not insert duplicate records.
insert into employee_history
select e.emp_id, e.emp_name, d.dept_name, e.salary 
from employee e
join department d on d.dept_name = e.dept_name
where not exists (select 1 
                  from employee_history eh
                  where eh.emp_id = e.emp_id
                  );


-- Give 10% increment to all employees in Bangalore location based on the maximum salary earned 
-- by an emp in each dept. Only consider employees in employee_history table.
update employee e
set salary = (select max(salary) + (max(salary)*0.1) from employee_history eh where eh.dept_name = e.dept_name)
where e.dept_name in (select dept_name from department where location = 'Bangalore')
and e.emp_id in (select emp_id from employee_history);


-- Delete all departments who dont have any employee.
delete from department
where dept_name in (select dept_name
                    from department d
                    where not exists (select 1 
                                      from employee e 
                                      where e.dept_name = d.dept_name));
