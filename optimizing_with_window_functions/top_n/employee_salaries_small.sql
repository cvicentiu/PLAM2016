drop table if exists employee_salaries;

create table employee_salaries (
    pk int,
    name varchar(20),
    dept varchar(20),
    salary int
);

insert into employee_salaries values
(1, 'John', 'Sales', 200),
(2, 'Tom',  'Sales', 300),
(3, 'Bill', 'Sales', 150),
(4, 'Jill', 'Sales', 400),
(5, 'Bob',  'Sales', 500),
(6, 'Axel', 'Sales', 250),
(7, 'Lucy', 'Sales', 300),
(8, 'Tim',      'Eng', 1000),
(9, 'Michael',  'Eng', 2000),
(10,'Andrew',   'Eng', 1500),
(11,'Scarlett', 'Eng', 2200),
(12,'Sergei',   'Eng', 3000),
(13,'Kristian', 'Eng', 3500),
(14,'Arnold',   'Eng', 2500),
(15,'Sami',     'Eng', 2800);

select dept, name, salary
from employee_salaries;

with salary_ranks as (
    select 
        rank() over (partition by dept order by salary desc) as ranking,
        dept, name, salary
    from employee_salaries
)
select *
from salary_ranks
where ranking <= 5
order by dept, ranking;



select (select count(*) + 1
       from employee_salaries as t2
       where t1.name != t2.name and
             t1.dept = t2.dept and
             t2.salary > t1.salary) as ranking, dept, name, salary
from employee_salaries as t1
where (select count(*)
       from employee_salaries as t2
       where t1.name != t2.name and
             t1.dept = t2.dept and
             t2.salary > t1.salary) < 5
order by dept, salary desc;

with counts as (
    select dept, count(pk) as counts
    from employee_salaries
    group by dept
), nth_values as (
    select es.dept, nth_value(salary, counts div 2) over (partition by dept order by salary
                                                          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
                                                    as nth_2,
                    nth_value(salary, (counts div 2) + 1) over (w
                          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) as nth_21
    from employee_salaries as es, counts
    where es.dept = counts.dept
    window w as (partition by dept order by salary)
    order by dept, salary
), median_values as (
    select distinct counts, nth_values.dept, case when counts mod 2 = 0
                                             then nth_21
                                             else (nth_2 + nth_21) / 2 end as median_value
    from nth_values, counts
    where counts.dept = nth_values.dept
)
select * from median_values;

select * from employee_salaries


