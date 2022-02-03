create table emp (
    empno int,
    empname varchar(20),
    deptno INT,
    salary INT,
    salany varchar(2),
    salall varchar(10),
    dept30 int);
    
insert INTO emp values(7369,'SMITH',20,800,'F',' ',950);
insert INTO emp values(7876,'ADAMS',20,1100,'T',' ',1250);
insert INTO emp values(7934,'MILLER',10,1300,'T',' ',1250);
insert INTO emp values(7782,'CLARK',10,2450,'T',' ',1500);
insert INTO emp values(7566,'JONES',20,2975,'T',' ',1600);
insert INTO emp values(7788,'SCOTT',20,3000,'T',' ',2850);
insert INTO emp values(7902,'FORD',20,3000,'T',' ',3000);

--QUERIES:
#########################
--Display all the information of the EMP table?
select * 
from emp;

############################
--Display unique Jobs from EMP table?
select 
distinct salall 
from emp;

##############################
--List the emps in the asc order of their Salaries? 
select * 
from emp 
order by salary asc;

################################
--List the details of the emps in asc order of the Dptnos and desc of Jobs?
select * 
from emp 
order by deptno asc,salany desc;

###############################
--Display all the unique job groups in the descending order? 
select 
distinct salany 
from emp 
order by salany desc;

##############################
--Display all the details of all ‘Mgrs’?
Select * 
from employees 
where empno in ( select mgr from employees) ;

##############################
--List the emps who joined before 1981?
select * 
from employees 
where hire_date < ('01-jan-81'); 

##############################
--List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.
select empno ,empname ,salary,salary/30,12*salary salany 
from emp 
order by salany asc;

##############################
--Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
select employee_id,first_name ,job_title,hire_date, months_between(sysdate,hiredate) 
from employees 
where employee_id in (select mgr from employees); 

##############################
--List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
select empno,empname,salary,salany 
from emp 
where empno = 7369; 

##############################
--Display all the details of the emps whose Comm. Is more than their Sal.
select * 
from emp 
where dept30 > salary;

##############################
--List the emps along with their Exp and Daily Sal is more than Rs.100. 
select * 
from emp 
where (salary/30) >100;

##############################
--List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select * 
from employees 
where job_title = 'CLERK' or job_title = 'ANALYST' 
order by job_title desc;

##############################
--List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority.
select * 
from employees 
where hire_date in ('01-may-81','03-dec-81','17-dec81','19-jan-80') 
order by hire_date asc;

##############################
--List the emp who are working for the Deptno 10 or20. 
select * 
from emp 
where deptno = 10 or deptno = 20 ; 

###############################
--List the emps who are joined in the year 81.
select * 
from employees 
where hire_date between '01-jan-81' and '31-dec-81';

###############################
--List the emps Who Annual sal ranging from 22000 and 45000.
 select * 
 from emp 
 where 12*salary between 2200 and 4500;
 
###############################
--List the Enames those are having five characters in their Names.
select empname 
from emp 
where length (empname) = 5;

################################
--List the Enames those are starting with ‘S’ and with five characters.
select empname 
from emp 
where empname like 'S%' and length (empname) = 5;

###############################
--List the emps those are having four chars and third character must be ‘r’.
select * 
from emp 
where length(empname) = 4 and empname like '__R%';

###############################
--List the Five character names starting with ‘S’ and ending with ‘H’.
select * 
from emp 
where length(empname) = 5 and empname like 'S%H';

################################
--List the emps who joined in January.
select * 
from employees 
where to_char (hire_date,'mon') = 'jan';

################################
--List the emps whose names having a character set ‘ll’ together.
select * 
from emp 
where empname like '%LL%'; 

#################################
--List the emps who does not belong to Deptno 20.
select * 
from emp 
where deptno <>20;

#################################
--List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries.
Select * 
from emp 
where job not in (‘PRESIDENT’,’MANAGER’) 
order by sal asc; 

##################################
--List the emps whose Empno not starting with digit78.
select * 
from emp w
here empno not like '78%';

##################################
--List the emps who are working under ‘MGR’.
select e.first_name || ' works for ' || m.first_name 
from employees e ,employees m 
where e.mgr = m.employee_id ;

###################################
--List the emps who joined in any year but not belongs to the month of March.
select * from employees 
where to_char (hire_date,'MON') not in ('MAR');

###################################
--List all the Clerks of Deptno 20.
select * 
from employees 
where job_title ='CLERK' and deptno = 20;

#####################################
--List the emps of Deptno 30 or 10 joined in the year 1981.
 select * 
 from employees 
 where to_char(hire_date,'YYYY') = '1981' and (deptno =30 or deptno =10) ; 

#####################################
--Display the details of SMITH.
select * 
from emp 
where empname = 'SMITH' ;

#####################################
--Display the location of SMITH.
select loc 
from employees e , dept d 
where e.ename = 'SMITH' and e.deptno = d.deptno ; 






