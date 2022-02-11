SELECT 
    *
FROM
    BRANCH;
SELECT 
    *
FROM
    dept;
SELECT
    *
FROM
    EMP;
    
--###### inner query #####################################################
--Get the deptname (dept(dname) for every employee(empno,ename)
-- emp == deptno == dept
--###########################################################
SELECT
    empno,ename,dname
FROM    
    emp JOIN dept ON emp.deptno=dept.deptno;

--###### inner query #####################################################
--Get the branchname( branch) for every department (deptno,dname)
-- branch == branchno == dept
--###########################################################
SELECT
    deptno,dname,branchname
FROM
    branch JOIN dept ON branch.branchno=dept.branchno;
--###### outer query #####################################################    
--Get the deptname (dept(dname) for every employee(empno,ename)
--including employees not working in any department
-- emp == deptno == dept
--###########################################################
SELECT
    e.empno,e.ename,d.dname
FROM
    emp e LEFT OUTER JOIN dept d
    ON e.deptno=d.deptno;
--###### outer query #####################################################    
--Get the deptname (dept(dname) for every employee(empno,ename)
--including deptno having no employees
-- emp == deptno == dept
--###########################################################
SELECT
    e.empno,e.ename,d.dname
FROM
    emp e RIGHT OUTER JOIN dept d
    ON e.deptno=d.deptno;    
--###### outer query #####################################################    
--Get the deptname (dept(dname) for every employee(empno,ename)
--including NULL VALUES for employee in department as well as dept with no employee
-- emp == deptno == dept
--###########################################################    
SELECT
    e.empno,e.ename,d.dname
FROM
    emp e FULL OUTER JOIN dept d
    ON e.deptno=d.deptno;        
--###########################################################
--Get the manager names of every employee
-- manager name== employee name
-- emp(mgr)==empno == emp 
-- emp join emp ==> self join
--empno,ename managename
--###########################################################
SELECT 
    e.empno,e.ename,m.ename as managername
FROM
    emp e JOIN emp m on e.mgr=m.empno
ORDER BY e.empno;

--###########################################################
-- its better to use Join and on instead of , where 
SELECT
    empno,ename,dname
FROM    
     emp,dept WHERE emp.deptno=dept.deptno;
--    emp JOIN dept ON emp.deptno=dept.deptno;

-- in hypothetical situation if you forgot to write where caluse 
-- on above query      emp cross join dept ;
SELECT
    empno,ename,dname
FROM    
     emp,dept ;

SELECT
    empno,ename,dname
FROM    
     emp cross join dept ;
--###########################################################
--	d. Display empno,ename,dname,branchname for employee working in deptno=10
--		EMP   = empno,ename
--		DEPT  = dname
--		BRANCH= branchname
--###########################################################
SELECT
    empno,ename,
    dname,
    branchname
FROM
        emp e 
    join 
        dept d 
    on 
        e.deptno=d.deptno
    join
        branch b
    on
        b.branchno=d.branchno
    order by b.branchno;
======================

SELECT
    name
FROM
    sys.customers c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    )
ORDER BY
    name;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####08-FEB-22
1. Views
--#################################################################################
-- vw_EMP			: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW vw_emp
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM
				emp;

SELECT * FROM vw_emp;	
--#################################################################################
--vw_hr		: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW VW_HR
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM 
				EMP;  
--#################################################################################
--vw_other_emp: empno,ename,job,mgr,deptno 	  
--#################################################################################
CREATE VIEW vw_other_emp
	AS
			SELECT
				empno,ename,job,mgr,deptno
			FROM 
				emp;

SELECT * FROM vw_emp;
SELECT * FROM VW_HR;
SELECT * FROM vw_other_emp;
--#################################################################################
--When to use the Oracle view
--You can use views in many cases for different purposes. The most common uses of views are as follows:

--Simplifying data retrieval.
--Maintaining logical data independence.
--Implementing data security.
--#################################################################################

--#################################################################################
-- vw_EMP			: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW vw_emp
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM
				emp;

SELECT * FROM vw_emp;	
--#################################################################################
--vw_hr		: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW vw_hr
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM 
				emp;
--#################################################################################
--vw_other_emp: empno,ename,job,mgr,deptno 	  
--#################################################################################
CREATE VIEW vw_other_emp
	AS
			SELECT
				empno,ename,job,mgr,deptno
			FROM 
				emp;

SELECT * FROM vw_emp;
SELECT * FROM vw_hr;
SELECT * FROM vw_other_emp;
--#################################################################################
--1. IF YOUR VIEW WORKS ON ONLY ONE TABLE 
--2. YOU CAN PERFROM DML OPERATIONS IN BELOW CASES
--    1. IT HAS ALL COLUMNS AND ALL RECORDS 
--    2. IT HAS ALL COLUMNS AND RESTRICTED RECORDS 
--    2. IT HAS ALL COLUMNS AND ALL/RESTRICTED RECORDS BUT HAVE CHECK CONSTRAINT
--#################################################################################
--    1. IT HAS ALL COLUMNS AND ALL RECORDS 
--  UPDATE THE SAL OF EMP IN  DEPT 10 BY 10%
--7782	CLARK	MANAGER	7839	09-JUN-81	2450		10
--7934	MILLER	CLERK	7782	23-JAN-82	1300		10
--#################################################################################
SELECT * FROM vw_hr WHERE deptno=10;

UPDATE vw_hr
    SET 
        SAL=SAL+SAL*0.10
    WHERE
        deptno=10;
        

SELECT * FROM vw_hr WHERE deptno=10;

INSERT INTO vw_hr values(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,10)

SELECT * FROM vw_hr WHERE deptno=10;

DELETE FROM vw_hr  WHERE empno=1234;

SELECT * FROM vw_hr WHERE deptno=10;    
SELECT * FROM emp WHERE deptno=10;  
rollback;
SELECT * FROM vw_hr WHERE deptno=10;    
SELECT * FROM emp WHERE deptno=10;  

--#################################################################################
--    2. IT HAS ALL COLUMNS AND RESTRICTED RECORDS 
--  Create a view to access employees working in SALES
--#################################################################################
CREATE VIEW vw_sales_emp
    AS 
    SELECT 
        empno,ename,job,mgr,hiredate,sal,comm,deptno
    FROM
        emp 
    WHERE
        deptno=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

UPDATE vw_sales_emp
    SET 
        COMM=NVL(COMM,0)+100
    
SELECT * FROM vw_sales_emp;
-- AS VIEW DO NOT HAVE ACCESS TO THE RECORDS HAVIG DEPTNO=10 NO CHANGES APPLIED
--UPDATE vw_sales_emp
--    SET 
--        COMM=NVL(COMM,0)+100
--    WHERE DEPTNO=10


--VIEW CAN INSERT RECORD FOR DEPTNO=10
INSERT INTO vw_sales_emp VALUES(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,10)


SELECT * FROM EMP WHERE DEPTNO=10;
ROLLBACK;

--vw_sales_emp should not add records of deptno=10
--to achieve this we must put check on it





--#################################################################################
-- vw_EMP			: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW vw_emp
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM
				emp;

SELECT * FROM vw_emp;	
--#################################################################################
--vw_hr		: empno,ename,job,mgr,hiredate,sal,comm,deptno
--#################################################################################
CREATE VIEW vw_hr
	AS
			SELECT
				empno,ename,job,mgr,hiredate,sal,comm,deptno
			FROM 
				emp;
--#################################################################################
--vw_other_emp: empno,ename,job,mgr,deptno 	  
--#################################################################################
CREATE VIEW vw_other_emp
	AS
			SELECT
				empno,ename,job,mgr,deptno
			FROM 
				emp;

SELECT * FROM vw_emp;
SELECT * FROM vw_hr;
SELECT * FROM vw_other_emp;
--#################################################################################
--1. IF YOUR VIEW WORKS ON ONLY ONE TABLE 
--2. YOU CAN PERFROM DML OPERATIONS IN BELOW CASES
--    1. IT HAS ALL COLUMNS AND ALL RECORDS 
--    2. IT HAS ALL COLUMNS AND RESTRICTED RECORDS 
--    2. IT HAS ALL COLUMNS AND ALL/RESTRICTED RECORDS BUT HAVE CHECK CONSTRAINT
--#################################################################################
--    1. IT HAS ALL COLUMNS AND ALL RECORDS 
--  UPDATE THE SAL OF EMP IN  DEPT 10 BY 10%
--7782	CLARK	MANAGER	7839	09-JUN-81	2450		10
--7934	MILLER	CLERK	7782	23-JAN-82	1300		10
--#################################################################################
SELECT * FROM vw_hr WHERE deptno=10;

UPDATE vw_hr
    SET 
        SAL=SAL+SAL*0.10
    WHERE
        deptno=10;
        

SELECT * FROM vw_hr WHERE deptno=10;

INSERT INTO vw_hr values(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,10)

SELECT * FROM vw_hr WHERE deptno=10;

DELETE FROM vw_hr  WHERE empno=1234;

SELECT * FROM vw_hr WHERE deptno=10;    
SELECT * FROM emp WHERE deptno=10;  
rollback;
SELECT * FROM vw_hr WHERE deptno=10;    
SELECT * FROM emp WHERE deptno=10;  

--#################################################################################
--    2. IT HAS ALL COLUMNS AND RESTRICTED RECORDS 
--  Create a view to access employees working in SALES
--#################################################################################
CREATE VIEW vw_sales_emp
    AS 
    SELECT 
        empno,ename,job,mgr,hiredate,sal,comm,deptno
    FROM
        emp 
    WHERE
        deptno=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

UPDATE vw_sales_emp
    SET 
        COMM=NVL(COMM,0)+100
    
SELECT * FROM vw_sales_emp;
-- AS VIEW DO NOT HAVE ACCESS TO THE RECORDS HAVIG DEPTNO=10 NO CHANGES APPLIED
--UPDATE vw_sales_emp
--    SET 
--        COMM=NVL(COMM,0)+100
--    WHERE DEPTNO=10


--VIEW CAN INSERT RECORD FOR DEPTNO=10
INSERT INTO vw_sales_emp VALUES(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,10)


SELECT * FROM EMP WHERE DEPTNO=10;
ROLLBACK;
--#################################################################################
-- SINCE VIEW HAS SUBQUERY AND CHECK OPTION WE GET VIRTUAL COLUMN ERROR 
--#################################################################################
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##ERPUSER"."VW_SALES_EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") AS 
  SELECT 
        empno,ename,job,mgr,hiredate,sal,comm,deptno
    FROM
        emp 
    WHERE
        deptno=(SELECT deptno FROM dept WHERE dname='SALES') WITH CHECK OPTION;
--#################################################################################
--VIEW CAN NOT INSERT RECORD FOR DEPTNO=10 CAUSE OF VIRTUAL COLUMN ERROR
--Error report -
--SQL Error: ORA-01733: virtual column not allowed here
--01733. 00000 -  "virtual column not allowed here"
--*Cause:    
--*Action:
--#################################################################################
INSERT INTO vw_sales_emp (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,10)

SELECT * FROM EMP WHERE DEPTNO=10;
--#################################################################################
--CREATE VIEW WITHOUT SUBQUERY 
--to achieve this we must put WITH CHECK OPTION ON SPECIFIC DEPTNO
--#################################################################################
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##ERPUSER"."VW_SALES_EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") AS 
  SELECT 
        empno,ename,job,mgr,hiredate,sal,comm,deptno
    FROM
        emp 
    WHERE
        deptno=30 WITH CHECK OPTION;
--#################################################################################        
--vw_sales_emp should not add records of deptno=10
--Error report -
--ORA-01402: view WITH CHECK OPTION where-clause violation
--#################################################################################
INSERT INTO vw_sales_emp (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(1234,'Janhavi','CLERK',7782,
                        to_date('09-JUN-1992','DD-MM-YYYY'),
                        1300,0,30)


--#################################################################################
-- Drop view
--#################################################################################

SELECT * FROM vw_emp;

DROP VIEW vw_emp;

--#################################################################################
-- Display 5 employees on the basis salary from higest to the lowest
--#################################################################################
SELECT
    empno,ename,deptno,sal
FROM
    emp
ORDER BY 
    sal desc;
--#################################################################################
-- Above query gives 15 records order by sal in desc
-- we need top 5 records
--#################################################################################
SELECT
    *
FROM
    (   SELECT
            empno,ename,deptno,sal
        FROM
            emp
        ORDER BY 
            sal desc
    )
WHERE 
    ROWNUM <= 5;
    
    
SELECT
    *
FROM
    (   SELECT
            empno,ename,deptno,sal
        FROM
            emp
        ORDER BY 
            sal ASC
    )
WHERE 
    ROWNUM = 2 ;    
    
--#################################################################################
--C) LATERAL inline view example 
-- dept(dname),branch(branchname) WITHOUT LATERAL
--#################################################################################
SELECT dname,branchname
from dept d,(SELECT  * FROM BRANCH b
        WHERE b.branchno=d.branchno)
ORDER BY dname;
--#################################################################################
-- above query can't idetify the dept d declare outside the inlinview
--ORA-00904: "D"."BRANCHNO": invalid identifier
--00904. 00000 -  "%s: invalid identifier"
--*Cause:    
--*Action:
--Error at Line: 318 Column: 24
--#################################################################################
--C) LATERAL inline view example 
-- dept(dname),branch(branchname) WITH LATERAL ON INLINEVIEW
--#################################################################################
SELECT
    dname,branchname
from
    dept d,
    LATERAL(
        SELECT  * FROM BRANCH b
        WHERE 
            b.branchno=d.branchno        
    )
ORDER BY dname;

##############################################

--1. UNION,UNION ALL,INTERSECTS
--2. INDEX
-- HIGHEST 
SELECT DEPTNO,MAX(SAL) FROM EMP GROUP BY DEPTNO;
-- LOWEST 
SELECT DEPTNO,MIN(SAL) FROM EMP GROUP BY DEPTNO;

-- MAX(SAL) AS WELL AS MIN(SAL) 
SELECT DEPTNO,MAX(SAL),MIN(SAL) FROM EMP GROUP BY DEPTNO;
--#######################################################
--10   1300  LOW  
--10   2450  HIGH
--20    800  LOW  
--20   3000  HIGH
--30    950  LOW
--30   3000  HIGH
--NULL 5000  LOW
--NULL 5000  HIGH
--#######################################################
-- UNION
SELECT E.DEPTNO,ENAME,DNAME FROM 
EMP E JOIN DEPT D ON E.DEPTNO=D.DEPTNO
--#######################################################
SELECT * FROM
    (
    SELECT DEPTNO,MIN(SAL),'LOW' AS MESSAGE FROM EMP GROUP BY DEPTNO
    UNION
    SELECT DEPTNO,MAX(SAL),'HIGH'AS MESSAGE FROM EMP GROUP BY DEPTNO
    )
ORDER BY DEPTNO;
-- 2ND HIGHEST SALARY 
SELECT * FROM
(
SELECT * FROM (SELECT DEPTNO,MAX(SAL) FROM EMP GROUP BY DEPTNO) WHERE ROWNUM<=2
) 
FETCH NEXT 1 ROW ONLY

-- SECOND HIGHEST SAL IN EMP
SELECT * FROM
(
SELECT DEPTNO,SAL FROM EMP ORDER BY SAL DESC
) 
FETCH NEXT 1 ROW ONLY;


-- FIRST AND SECOND HIGHEST SAL
SELECT * FROM (SELECT DEPTNO,SAL FROM EMP ORDER BY SAL DESC) WHERE ROWNUM <=2;
-- FIRST AND SECOND LOWEST SAL
SELECT * FROM (SELECT DEPTNO,SAL FROM EMP ORDER BY SAL ASC) WHERE ROWNUM <=2;

SELECT * FROM (SELECT DEPTNO,SAL FROM EMP ORDER BY SAL DESC) WHERE ROWNUM <=2
UNION
SELECT * FROM (SELECT DEPTNO,SAL FROM EMP ORDER BY SAL ASC) WHERE ROWNUM <=2;

-- employee table find the ename with largest length and smallest length
-- print the name with length value.


SELECT 
    ENAME,LENGTH(ENAME)
FROM
    EMP
ORDER BY LENGTH(ENAME);

-- employee table find the ename with largest length and smallest length
-- print the name with length value.
-- NAME SHOULD BE SORTED ALPHABETICALLY FOR THE LENGTH(ENAME)
SELECT 
    ENAME,LENGTH(ENAME)
FROM
    EMP
ORDER BY LENGTH(ENAME),ENAME;

-- UNION OF ENAME WITH SMALL LENGTH AND ENAME WITH BIGGER LENGTH
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME) WHERE ROWNUM<2;
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) DESC,ENAME) WHERE ROWNUM<2;

SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME) WHERE ROWNUM<=2
UNION 
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) DESC,ENAME) WHERE ROWNUM<=2


SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME)DESC,ENAME) WHERE ROWNUM<=2
UNION 
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) DESC,ENAME) WHERE ROWNUM<=2



SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME)DESC,ENAME) WHERE ROWNUM<=2
UNION ALL
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) DESC,ENAME) WHERE ROWNUM<=2


--- Lateral
SELECT
    DNAME, BRANCHNAME
FROM 
    DEPT d JOIN BRANCH b
    ON  d.branchno=b.branchno;
--------------------------- In line view
-- 1. BRANCH ALL DETAILS 
SELECT BRANCHNO,BRANCHNAME,LOCATION FROM BRANCH;
-- 2. COMBINE WITH DNAME,BRANCHNAME WITH DEPT.BRANCHNO=BRANCH.BRANCHNO

--SELECT DNAME,BRANCHNAME
--    FROM DEPT,BRANCH
--    WHERE DEPT.BRANCHNO=BRANCH.BRANCHNO;
-- INLINE VIEW

SELECT 
        DNAME,BRANCHNAME
    FROM DEPT d, Lateral(SELECT * FROM BRANCH b where b.branchno=d.branchno);
    
--===============================================================
--INDEX
--==================================================================
-- TO CHECK THE EXECUTION PLAN OF A QUERY 
EXPLAIN PLAN FOR SELECT * FROM EMP WHERE EMPNO=7844;
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

EXPLAIN PLAN FOR SELECT * FROM EMP WHERE ename='KING';
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
--  APPLICATION USES EMP TABLE WHERE EMPNO IS PRIMARY KEY
--  HOWEVER MOST SEARCH HAPPENS ON ENAME  
-- CREATE INDEX ON COLUMN WHICH IS USED MORE IN WHERE CLAUSES

--CREATE INDEX index_name 
--ON table_name(column1[,column2,...])

CREATE INDEX i_emp_ename
ON EMP(ENAME);

EXPLAIN PLAN FOR SELECT * FROM EMP WHERE ename='KING';
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

-- DEPTNO - FK IN EMP 
-- DO WE HAVE INDEX ON FK IN ORACLE=>NO
-- IS DEPTNO PART OF WHERE CLAUSE VERY OFTEN
-- DO YOU THINK WE WILL NEED INDEX ON DEPTNO ->YES

EXPLAIN PLAN FOR SELECT * FROM EMP WHERE DEPTNO=30;
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

CREATE INDEX i_emp_deptnofk
on EMP(deptno)

EXPLAIN PLAN FOR SELECT * FROM EMP WHERE DEPTNO=30;
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
--#############################################################################
CREATE TABLE members(
    member_id INT GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)
);

select count(*) from emp;
select * from emp;
--####################################################
select * from all_indexes
WHERE 
    table_name = 'MEMBERS';
--####################################################

SELECT 
    index_name, 
    index_type, 
    visibility, 
    status 
FROM 
    all_indexes
WHERE 
    table_name = 'MEMBERS'
    and
    table_owner='C##ERPUSER';

--####################################################
create index i_members_lastname
on members(last_name);

drop index i_members_lastname;
    
DROP INDEX MEMBERS_GENDER_I;    

create index i_members_name
on members(first_name,last_name);

drop index i_emp_deptnofk;

create unique index iu_emp_deptno on emp(deptno);


select empno,deptno from emp order by deptno;

create unique index i_emp_empno
on emp(empno);

#######################################################
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;


SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

SELECT DEPTNO FROM EMP
MINUS
SELECT DEPTNO FROM DEPT;

SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

--data is case sensitive
SELECT * FROM EMP WHERE ENAME='kING';
SELECT ename,lower(ename) FROM EMP 
WHERE lower(ENAME)=lower('kING')

SELECT ename,lower(ename) FROM EMP 
order by lower(ename);

EXPLAIN PLAN FOR
SELECT * FROM EMP WHERE ENAME='KING';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

EXPLAIN PLAN FOR
SELECT * FROM EMP WHERE LOWER(ENAME)=LOWER('KING');

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());


CREATE INDEX i_emp_lower_ename
on emp(lower(ename));

EXPLAIN PLAN FOR
SELECT * FROM EMP WHERE LOWER(ENAME)=LOWER('KING');

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());


-- WHICH COLUMN HAS LOW CARDINALITY IN MEMBERS
SELECT gender,count(member_id) from members group by gender;
SELECT dob,count(member_id) from members group by dob;
select first_name ,count(member_id) from members group by first_name; 
select last_name ,count(member_id) from members group by last_name; 
select email ,count(member_id) from members group by email; 

EXPLAIN PLAN FOR
SELECT * FROM MEMBERS WHERE GENDER='M';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

--MEMBERS [998] 
--=>M[509] 
--=>F[489] 
CREATE BITMAP INDEX i_members_gender
on MEMBERS (GENDER);

EXPLAIN PLAN FOR
SELECT * FROM MEMBERS WHERE GENDER='M';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

--####################################################
--Oracle Synonym
--####################################################
--schema objects such as 
--tables, views, materialized views, sequences, procedures, and stored function.
--Synonyms create a level of "abstraction" of the underlying schema objects so that 
--you can rename and move of the underlying objects without affecting the applications based on the synonyms.
--Create synonym – show you how to create a new synonym for a table.
--Drop a synonym – describe how to drop a synonym from the database.
--####################################################
-- ACCESS THE DATA OF C##ADUSER 
--####################################################
SELECT * FROM C##ADUSER.EMP;
--####################################################
-- ABOVE QUERY IN GENERAL GIVING DATA OF EMPLOYEE
-- PUBLIC  -> ANY USER CAN ACCESS 
-- PRIVATE -> SPECIFIC USER
--####################################################
CREATE PUBLIC SYNONYM EMPLOYEES
FOR C##ADUSER.EMP;
--####################################################

SELECT * FROM EMPLOYEES;
################################################
--###########################################################################
-- PRINT MESSSAGE HELLO WORLD
--###########################################################################
SET SERVEROUTPUT ON;
BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO WORLD');

END;
--###########################################################################
-- PRINT MESSSAGE HELLO WORLD using variable
-- ":=" is assignment operator which assigns value to variable
--"=" is comparision operator
--###########################################################################
DECLARE
	v_message varchar2(100); --declaration
BEGIN
		v_message:='Hello World';
		dbms_output.put_line(v_message);
END;
--###########################################################################
-- Add two numbers
-- Arithmatic operator as well as we are using || concatenation of messages in put_line method
--###########################################################################
DECLARE
	v_num1 number:=10;
	v_num2 number:=10;
	v_result number:=0;
BEGIN
		v_result:=v_num1+v_num2;
		dbms_output.put_line('Addition of two number is ' || v_result);
END;
--###########################################################################
-- get data from table and use it in your plsql
-- for empno 7788 get the ename print it with welcome message
-- how to use column type on plsql variable: 	v_ename     emp.ename%type;
-- how to use select into to assign values from tables to plsql variables
--###########################################################################
DECLARE
	v_ename     emp.ename%type; --varchar2(100);
BEGIN
		SELECT 
			ENAME  INTO v_ename
		FROM 
			EMP 
		WHERE 
			EMPNO=7788;

		DBMS_OUTPUT.PUT_LINE('WELCOME '|| v_ename);
END;
--#############################################################################
-- constant variable
-- declare a 10% incentive for employee with comm=0
--display the salary with additional 10% incentive
--#############################################################################
DECLARE
	constant v_incentive number:=0.10;
		      v_sal emp.sal%type;
BEGIN
	SELECT
		SAL INTO v_sal
	FROM
		EMP
	WHERE
		comm=0;
	v_sal:= v_sal+v_sal*v_incentive;
	
	DBMS_OUTPUT.PUT_LINE('SALARY WITH 10% INCENTIVE IS '|| v_sal);
END;
--#############################################################################
-- if max(sal) <3000 	then
-- else if max(sal)<4000  	then
-- else ...
--#############################################################################
DECLARE
	v_maxsal emp.sal%type;
BEGIN
		SELECT 
			MAX(SAL) INTO v_maxsal
		FROM
			EMP;
		IF v_maxsal < 3000 

			THEN DBMS_OUTPUT.PUT_LINE('< 3000');
	
		ELSIF v_maxsal < 4000 
			THEN DBMS_OUTPUT.PUT_LINE('< 4000');		
		ELSE		
			 DBMS_OUTPUT.PUT_LINE('> 4000');			
		END IF;
END;
--#############################################################################
-- USING CASE WHEN 
--#############################################################################
DECLARE
	v_maxsal emp.sal%type;
BEGIN
		SELECT 
			MAX(SAL) INTO v_maxsal
		FROM
			EMP;
		CASE
			WHEN  v_maxsal < 3000 THEN DBMS_OUTPUT.PUT_LINE('< 3000');
			WHEN v_maxsal < 3000  THEN DBMS_OUTPUT.PUT_LINE('< 4000');		
			ELSE   DBMS_OUTPUT.PUT_LINE('> 4000');	
	        END CASE;
END;
--#############################################################################
-- USING CASE WHEN 
--#############################################################################
DECLARE
	v_color varchar2(10);
BEGIN
	SELECT COLOR INTO v_color FROM COLORS WHERE ID=3;
	CASE v_color
		 when 'Red' then DBMS_OUTPUT.PUT_LINE('#ff0000');
				 when 'Brown' then DBMS_OUTPUT.PUT_LINE('#ffaaaa');
						 when 'Green' then DBMS_OUTPUT.PUT_LINE('#00ff00');
							ELSE DBMS_OUTPUT.PUT_LINE('NOCOLOR');
	END CASE;

END;

--#############################################################################
-- USING BASIC LOOP
	LOOP

	END LOOP;
-- PRINT 1 TO 10 NUMBERS	 
--#############################################################################
DECLARE 
	v_i number:=1;
BEGIN
		LOOP
			-- PRINT 
			DBMS_OUTPUT.PUT_LINE(v_i);
			-- INCREMENT 
			v_i:=v_i+1;
			-- CHECK IF >10 EXIT	
			IF v_i=11 
				then Exit;
			END IF;
		END LOOP;
END;

--#############################################################################
--WHILE
--#############################################################################

DECLARE 
	v_i number:=1;
BEGIN
		WHILE v_i<11 
			LOOP
					-- PRINT 
						DBMS_OUTPUT.PUT_LINE(v_i);
					-- INCREMENT 
					v_i:=v_i+1;
			END LOOP;
END;
--#############################################################################
--for
--#############################################################################
DECLARE 
	
BEGIN
		FOR v_i 
			LOOP
					-- PRINT 
						DBMS_OUTPUT.PUT_LINE(v_i);
					-- INCREMENT 
					v_i:=v_i+1;
			END LOOP;
END;