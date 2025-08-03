/*Project*/
/*create database p_company_db*/
create database p_company_db;
use p_company_db;

create table dept
(
	deptno int(2) primary key NOT NULL,
    Dname varchar(14),
    Loc varchar(13)
);

create table emp
(
	Empno int(4) primary key,
    Ename varchar(10),
    Job varchar(9),
    Mgr int (4),
    Hiredate date,
    Sal decimal(7,2),
    Comm decimal(7,2),
    deptno int(2) references dept(deptno)
);


create table log_table
(
	Empno int(5) not null,
    Log_date datetime not null default current_timestamp,
    New_salary int(10) default null,
    Action_l varchar(20) default null
);

drop table log_table;
create table student
(
	 Rno int(2) not null primary key default 0,
     Sname varchar(14) default null,
     City varchar(20) default null,
     State varchar(20) default null
);
-- insert Recode table
insert into dept values(10,'ACCOUNTING','NEW YORK'),
					   (20,'RESEARCH','DALLAS'),
                       (30,'SALES','CHICAGO'),
                       (40,'OPERATIONS','BOSTON');
insert into emp values(7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
					  (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
                      (7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
                      (7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
                      (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
                      (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
                      (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
                      (7788,'SCOTT','ANALYST',7566,'1987-06-11',3000.00,NULL,20),
                      (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
                      (7844,'TURNER','SALESMAN',7698,'1981-08-09',1500.00,0.00,30),
                      (7876,'ADAMS','CLERK',7788,'1987-07-13',1100.00,NULL,20),
                      (7900,'JAMES','CLERK',7698,'1981-03-12',950.00,NULL,30),
                      (7902,'FORD','ANALYST',7566,'1981-03-12',3000.00,NULL,20),
                      (7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);
-- insert Recode student
insert into student values(1,'sai','Mumbai','Maharashtra'),
						  (2,'Ram','Bangalore','Karnataka'),
                          (3,'Nehal','Mumbai','Maharashtra'),
                          (4,'Vibhuti','Surat','Gujarat'),
                          (5,'Dhruti','Chennai','Tamil Nadu');
                          
select * from dept;
select * from emp;
select * from student;

-- query
#1. Select unique job from EMP table. 
select distinct job from emp;

#2. List the details of the emps in asc order of the Dptnos and desc of Jobs? 
select * from emp
order by deptno asc , job desc;

#3. Display all the unique job groups in the descending order?
select distinct job from emp 
order by job desc;

#4. List the emps who joined before 1981.

select * from emp 
where Hiredate < '1981-01-01';

#5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal. 

select 
	Empno,
    Ename,
    Sal as 'Month_salary',
    Sal /30 as 'Daily Sal',
    Sal * 12 as Annual_Salary
from
	emp
order by Annual_Salary desc;

#6. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369. 

select 
		Empno,
		Ename,
        Sal,
        timestampdiff(year,Hiredate,CURRENT_DATE()) as 'Exp_all_emps'
from 
		emp 
where
		Mgr = 7369
order by
		Exp_all_emps;

#7. Display all the details of the emps who’s Comm. Is more than their Sal?

select * from emp
where Comm > Sal;

#8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.

select * from emp
where Job in ('CLERK' ,'ANALYST');

#9. List the emps Who Annual sal ranging from 22000 and 45000. 

select * from emp
where 
	Sal * 12 between 22000 and 45000;
#10. List the Enames those are starting with ‘S’ and with five characters. 

select 	* from emp
where Ename like 's____%';

#or 
select * from emp
where Ename like 's____%' and length(Ename) = 5;

#11. List the emps whose Empno not starting with digit78.

select * from emp
where Empno not like '78%';

#12. List all the Clerks of Deptno 20.

select * from emp
where deptno = 20 and Job ='CLERK';

#13. List the Emps who are senior to their own MGRS.

select 
		e.Empno as emp_empno,
        e.Ename as emp_name,
        e.Hiredate as emp_hiredate,
        m.Empno as mgr_empno,
        m.Ename as mgr_name,
        m.Hiredate as mgr_hiredate
from
		emp as e
join 
		emp as m
on  
		e.Mgr = m.Empno
where
		e.Hiredate < m.Hiredate;
        
#14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10. 

select 
	*
 from 
		emp
where
		deptno = 20 
and
	job in(select distinct job from emp where deptno =10);
    
#15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.

select * from emp
where 
		Sal
in(
	select Sal from emp where Ename in ('FORD','SMITH')
  )
order by 
	Sal desc;

#16. List the emps whose jobs same as SMITH or ALLEN. (Baki)

select * from emp
where 
	Job 
in(select Job from emp where Ename in ('SMITH','ALLEN'));

#17. Any jobs of deptno 10 those that are not found in deptno 20. 

select distinct Job 
from
	emp
where 
	deptno = 10
And 
job 
not in (select distinct job from emp where deptno = 20);

#18. Find the highest sal of EMP table. 

select 
		Empno,
		Ename,
		max(Sal) as highest_salary 
from
		emp
group by 
		Empno
order by
		highest_salary desc limit 1;
        
#19. Find details of highest paid employee.
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

#20. Find the total sal given to the MGR. 

select 
		ename,
		sum(Sal) as total_mgr_salary
from
		emp
where
		Job = 'MANAGER'
group by 
	ename;
    
#21. List the emps whose names contains ‘A’.
select * from emp
where
Ename like '%A%';

#22. Find all the emps who earn the minimum Salary for each job wise in ascending order.     

select * from emp as e
where Sal = (select min(Sal) from emp where Job = e.Job)
order by 
	Job asc ,Sal desc;
    
#23. List the emps whose sal greater than Blake’s sal.

select * from emp
where Sal > (select Sal from emp where Ename = 'Blake');

#24. Create view v1 to select ename, job, dname, loc whose deptno are same. 

create view v1 as
select 
		e.Ename,
        e.Job,
        d.dname,
        d.loc
from
		emp as e
join 
	dept as d
on 
	e.deptno = d.deptno;
		
select * from v1;

#25. Create a procedure with dno as input parameter to fetch ename and dname.
DELIMITER $$
create procedure  Get_emp_by_Deptno(in dno int)
begin
		select 
				e.Ename,
                d.Dname
		from
				emp as e
		join 
			dept as d
        on 
			e.deptno = d.deptno
		where
			e.deptno = dno;
end $$
DELIMITER ;
	call Get_emp_by_Deptno(10);
    
#26. Add column Pin with bigint data type in table student.
alter table student add column Pin bigint not null;
select * from student;

/*27. Modify the student table to change the sname length from 14 to 40. 
Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.*/

/*Modify the student table to change the sname length from 14 to 40. */

alter table student modify column Sname varchar(40);
show columns from student; 

/*------------------------*/
 /*Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.*/       

delimiter $$
create trigger after_salary_update
after update on emp
for each row
begin
		if old.Sal != new.Sal then
			insert	into log_table(Empno,new_salary,Action_l)
            values(old.Empno,new.Sal,'New Salary');
		end if;
end $$
delimiter ;
/* Update Recode */
update emp 
set Sal = 900
where Empno = 7369;
/*Display Recode update*/
select * from emp;
select * from log_table;







        

	

















