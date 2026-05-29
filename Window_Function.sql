/* CREATE TABLE Employees_Rank (
    Emp_ID INT,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
)


INSERT INTO Employees_Rank VALUES
(101, 'Amit', 'HR', 45000),
(102, 'Neha', 'HR', 52000),
(103, 'Rohit', 'HR', 52000),
(104, 'Priya', 'IT', 70000),
(105, 'Karan', 'IT', 65000),
(106, 'Simran', 'IT', 70000),
(107, 'Vikas', 'Sales', 40000),
(108, 'Pooja', 'Sales', 48000),
(109, 'Arjun', 'Sales', 48000),
(110, 'Meera', 'Finance', 75000)

*/

/* CREATE TABLE Employee_Data (
    Emp_ID INT,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    City VARCHAR(50),
    Joining_Year INT,
    Salary INT
); */

/* INSERT INTO Employee_Data VALUES
(101, 'Amit', 'HR', 'Delhi', 2020, 45000),
(102, 'Neha', 'HR', 'Mumbai', 2019, 52000),
(103, 'Rohit', 'HR', 'Delhi', 2021, 52000),
(104, 'Priya', 'IT', 'Bangalore', 2018, 70000),
(105, 'Karan', 'IT', 'Pune', 2020, 65000),
(106, 'Simran', 'IT', 'Bangalore', 2019, 70000),
(107, 'Vikas', 'Sales', 'Delhi', 2021, 40000),
(108, 'Pooja', 'Sales', 'Mumbai', 2020, 48000),
(109, 'Arjun', 'Sales', 'Pune', 2022, 48000),
(110, 'Meera', 'Finance', 'Delhi', 2017, 75000),
(111, 'Riya', 'Finance', 'Mumbai', 2018, 68000),
(112, 'Kabir', 'Finance', 'Pune', 2021, 68000),
(113, 'Sneha', 'Marketing', 'Delhi', 2020, 55000),
(114, 'Rahul', 'Marketing', 'Mumbai', 2019, 60000),
(115, 'Anjali', 'Marketing', 'Bangalore', 2022, 55000); */

/* Beginner Level */

/* 1. Display all employee records. */
Select * from Employees_rank


/* 2. Show only employee names and salaries. */
select EMp_name , Salary from Employees_rank


/* 3. Find employees whose salary is greater than 50,000. */
select emp_name , salary from Employees_Rank where salary > 50000 


/* 4. Display employees from the IT department. */
select * from Employees_rank where Department = 'IT'


/* 5. Find employees whose salary is between 45,000 and 70,000. */
select * from Employees_rank where salary between 45000 and 70000


/* 6. Sort employees by salary in descending order. */
select * from Employees_rank order by salary desc


/* 7. Count total number of employees. */
select COUNT(*) Total_Employee from Employees_rank


/* 8. Find the highest salary in the company. */
select * from Employees_rank where salary = (select MAX(salary) from Employees_rank)


/* 9. Find the lowest salary in the company. */
select * from Employees_rank where salary = (select min(salary) from Employees_rank)


/* 10. Find average salary of employees. */
select AVG(salary) Average_Salary from Employees_rank


/* Intermediate Level */

/* 11. Find total salary department-wise. */
select department , sum(salary) "Total Salary" from employees_rank group by department


/* 12. Find average salary in each department. */
select department , avg(salary) "Average Salary" from employees_rank group by department


/* 13. Count employees in each department. */
select department , count(*) "Total Employees" from employees_rank group by department


/* 14. Show employees whose salary is equal to 52,000. */
select * from employees_rank where salary = 52000


/* 15. Find the second highest salary. */
select * from ( select * , rank() over(order by salary desc) as rnk from employees_rank)t where rnk = 2


/* 16. Display employees whose name starts with 'P'. */
select * from Employees_rank where emp_name like 'p%'


/* 17. Find employees having duplicate salaries. */
select * from Employees_rank where salary in ( select salary from Employees_rank group by salary having COUNT(*) > 1)


/* 18. Display departments having more than 2 employees. */
select Department , COUNT(emp_ID) "Total Employees" from Employees_Rank group by Department having COUNT(emp_id) > 2


/* 19. Find top 3 highest paid employees. */
select top 3 * from Employees_Rank order by Salary desc


/* 20. Find employees earning more than department average salary. */
select Emp_Name , Department , Salary from Employees_Rank e where salary > ( select AVG(salary) from Employees_Rank where Department = e.Department)


/* 21. Find employees just below Rank 1 (Rank = 2). */
select * from ( select * , RANK() over(order by salary desc) rnk from Employees_Rank )rnk  where rnk = 2


/* 22. Find all employees after Rank 3. */
select * from ( select * , RANK() over(order by salary desc) rnk from Employees_Rank )rnk  where rnk >3


/* 23. Find rank gaps caused by duplicate salaries. */
with cte as ( select RANK() over ( order by salary desc ) rnk from Employees_Rank)
select rnk+1 "Missing Rank" from cte where rnk+1 not in ( select rnk from cte);


/* 24. Count how many employees are present in each rank. */
with cte as ( select Emp_name , salary , RANK() over(order by salary desc) "Salary Rank" from Employees_Rank)
select "Salary Rank" , COUNT(*) "Total Employees" from cte group by "Salary Rank" order by "Salary Rank" 


/* 25. Find the employee having maximum rank. */
with cte as (select * , RANK() over(order by salary desc) rnk from Employees_Rank) 
select * from cte where RNK = (select MAX(rnk) from cte);


/* 26. Display only duplicate ranks. */
with cte as ( select * , RANK() over( order by salary desc) rnk from Employees_Rank	)
select * from cte where rnk in (select rnk from cte group by rnk having COUNT(*)>1)


/* 27. Find employees whose rank is skipped due to ties. */
select emp_name , salary,RANK() over(order by salary desc) Rank from Employees_Rank;


/* 28. Find third highest salary using RANK(). */
SELECT *
FROM (
    SELECT 
        Emp_Name,
        Department,
        Salary,
        dense_rank() OVER(
            ORDER BY Salary DESC
        ) AS rnk
    FROM Employees_Rank
) t
WHERE rnk = 3;


/* 29. Company wants to reward top 3 salaried employees. Write query using RANK(). */
select top(3) * , RANK() over(order by salary desc) Rank from Employees_Rank 


/* 30. HR wants department toppers only. */
select * from (select Emp_Name, Department ,Salary, RANK() over(Partition by department order by salary desc) rank from Employees_Rank )t where rank = 1;


/* 31. Find employees eligible for promotion:
Rank <= 2 */
select * from (select Emp_Name, Department ,Salary, RANK() over(order by salary desc) rank from Employees_Rank )t where rank >= 2;


/* 32. Find employees whose salary rank is below average rank. */
with RankedEmployees as ( select * , RANK() over(order by salary desc) SalaryRank from Employees_Rank)
select * from RankedEmployees where SalaryRank > (select AVG(SalaryRank) from RankedEmployees);


/* 33. Find bottom 3 salaried employees using RANK(). */
select * from (select *,rank() over( order by salary asc) rank from employees_rank)t where rank<= 3;


/* 34. Generate salary leaderboard. */
select *,RANK() over(order by salary desc) "Leaderboard Rank" from employees_rank;


/* 35. Find employees tied at Rank 1. */
select * from (select * , RANK() over( order by salary desc ) rnk from employees_rank)t where rnk = 1;


/* 36. Find employees sharing same salary but different departments. */
select e1.* from Employees_Rank as e1 join Employees_Rank e2 on e1.Emp_ID = e2.Emp_ID where e1.Salary = e2.Salary and e1.Department <> e2.Department;

select * from Employees_Rank

/* 37. Display rank without skipping duplicate salaries and compare results. 
(Hint: Compare with DENSE_RANK()) */
select *,RANK() over( order by salary desc ) rnk from Employees_Rank;
select *,dense_rank() over( order by salary desc ) rnk from Employees_Rank;

/* 38. Create a query to show:
Employee Name
Salary
Department
Company Rank
Department Rank

using multiple RANK() functions together. */

select * , DENSE_RANK() over(partition by department order by salary desc) rnk from Employees_Rank;



/* Rank*/
select * from Employee_data;


/* 39. Rank employees based on salary. */
select * , RANK() over( order by salary desc ) rnk from Employee_data;


/* 40. Rank employees department-wise. */
select *,RANK() over( partition by department order by salary desc ) rnk from Employee_data;


/* 41. Find top 3 salaries. */
select top(3) * from employee_Data order by salary desc;


/* 42. Find second highest salary in each department. */

select * from ( select *,row_number() over( partition by department order by salary desc ) rnk from Employee_data) t where rnk = 2;


select * from employee_data;

/* DENSE_RANK() */
/* 43. Use DENSE_RANK() on salaries. */
select *,dense_rank() over( order by salary desc) Rank from employee_Data;


/* 44. Compare RANK() vs DENSE_RANK(). */
select *,rank() over(order by salary desc) Rank ,dense_rank() over( order by salary desc) DenseRank from employee_Data;


/* ROW_NUMBER() */
/* 45. Assign row numbers to employees. */
select *,Row_number() over( order by salary desc) Rank from employee_Data;


/* 46. Assign row numbers department-wise. */
select *,ROW_NUMBER() over(partition by department order by salary desc) DeptWiseRank from Employee_Data;


/* LAG() */
/* 47. Show previous employee salary. */
select *,LAG(salary) over(order by salary) LAG from Employee_Data;


/* 48. Find salary difference from previous employee. */
select *,LAG(salary) over(order by salary) LAG , Salary - LAG(salary) over(order by salary) "Salary Diff" from Employee_Data;



/* LEAD() */
/* 49. Show next employee salary. */
select *,Lead(salary) over(order by salary) from Employee_Data;


/* 50. Find next higher salary. */
select Emp_ID,Emp_Name,Salary,Lead(salary) over(order by salary) "Next Salary" from Employee_Data;

/* Aggregate Window Functions */
/* 51. Show total company salary beside each row. */
select  *, SUM(salary) over() "Total Company Salary" from Employee_Data;

/* 52. Show department-wise total salary. */
select * , SUM(salary) over(partition by department) "DeptWiseSalary" from Employee_Data

/* 53. Show average salary by department. */
select * , avg(salary) over(partition by department) "DeptWiseAvgSalary" from Employee_Data


/* 54. Show running total of salaries. */
select * , SUM(salary) over(order by salary) "Running Total Sum" From Employee_Data;


/* 55. Find cumulative salary. */
select * , SUM(salary) over(order by salary) "Running Total Sum" From Employee_Data;


/* 56. Find highest salary in each department using window functions. */
select *,MAX(salary) over(partition by department) "Highest Salary" from Employee_Data;


/* 57. Find lowest salary in each city. */
select *,Min(salary) over(partition by city) "Lowest Salary" from Employee_Data;


/* 58. Find percentage contribution of each employee salary to total salary. */
select *,SUM(salary) over() "Total Salary" , CAST(ROUND((Salary * 100.0) / SUM(Salary) OVER(),2) AS DECIMAL(10,2)) "Salary Percentage" from Employee_Data;



































































































































































































































































































































































































































































































































































































































































































