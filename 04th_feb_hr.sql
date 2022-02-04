-- ################################################################	 
-- DENSE_RANK computes the rank of a row in an ordered group of rows and returns the rank as a NUMBER. 
-- ################################################################	 

SELECT 
    DENSE_RANK(5000) 
    WITHIN GROUP  (ORDER BY sal DESC) "Dense Rank sal desc",
    DENSE_RANK(5000)     WITHIN GROUP  (ORDER BY sal asc) "Dense Rank sal asc"
    FROM emp;
-- ################################################################	 
-- The following statement selects the department name, employee name, and salary of all employees
-- who work in the human resources or purchasing department, and then computes a rank for each unique 
-- salary in each of the two departments.
-- dense_rank without partition Over() gives error
-- ################################################################	 
SELECT * FROM dept;
-- DISPLAY employees working in  Research -20 and Sales -30
SELECT
    empno,empname,deptno,salary,DENSE_RANK() OVER ( PARTITION  BY deptno ORDER BY salary desc),
FROM 
    emp
WHERE
    deptno IN (SELECT deptno FROM dept WHERE dname IN ('RESEARCH','SALES'))
ORDER BY deptno,salary desc;

-- ################################################################	 	
-- The following example returns, within each department of the sample table hr.employees, 
-- the minimum salary among the employees who make the lowest commission and the maximum 
-- salary among the employees who make the highest commission:
--MIN(salary) KEEP (DENSE_RANK FIRST ORDER BY commission_pct) "Worst",
--MAX(salary) KEEP (DENSE_RANK LAST ORDER BY commission_pct) "Best"

-- ################################################################	 
SELECT deptno,
MIN(sal) KEEP (DENSE_RANK FIRST ORDER BY comm) "Worst",
MAX(sal) KEEP (DENSE_RANK LAST ORDER BY comm) "Best"
   FROM emp
   GROUP BY deptno;

-- ################################################################	 	
-- For each department in the sample table oe.employees, the following example assigns 
-- numbers to each row in order of employee's hire date:
-- ################################################################	 	   
--SELECT department_id, last_name, employee_id, ROW_NUMBER() OVER 
--(PARTITION BY department_id ORDER BY employee_id) AS emp_id
-- FROM employees;   

SELECT 
    DEPTNO, EMPNO,ENAME, ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY EMPNO) AS EMPID
FROM 
    EMP;
-- ################################################################	  
--List all employees join in dec 81 and working for dept 10 as manager as 
--per the highest to lowest salary
-- ################################################################	 
--select * from emp where hiredate like '%-12-81' order by sal desc;

--order by sal desc;
  
SELECT 
    EMPNO,ENAME,JOB,HIREDATE,DEPTNO
FROM 
    EMP
WHERE 
    HIREDATE LIKE '%-DEC-81' 
    AND JOB='CLERK'
ORDER BY
    SAL;
--select * from emp where to_char(hiredate,'yy')=81 and to_char(hiredate,'mm')=12 and deptno=10 and job='manager'    
    
SELECT 
    EMPNO,ENAME,JOB,HIREDATE,DEPTNO
FROM 
    EMP
WHERE 
    TO_CHAR(HIREDATE,'YY')=81  AND  TO_CHAR(HIREDATE,'MM')= 12 AND JOB='CLERK'
ORDER BY
    SAL;
-- ################################################################	 		
-- Module 4 Displaying Data from Multiple Tables
--   A. SUBQUERY ->
--            1. PROJECTION TAKES ALL COLUMN FROM ONE TABLE WE USE SUBQUERY
--            2. QUERY WITHIN QUERY NESTED QUERIES 
--            3. INNER QUERY AND OUTER QUERY WHERE OUTER QUERY DEPENDS ON RESULTS OF INNER QUERY
--            4. INNER QUERY IS EXECUED FIRST THEN THE OUTER QUERY
--            5. = it indicates we are matching exactly one record from the inner query
--            6. IN it indicates we are matching values with list of records given by inner query
--   B. JOIN->PROJECTION TAKES COLUMNS FROM MORE THAN ONE TABLE WE USE JOINS
-- ################################################################	 	
-- List all emp who are working in same dept of martin
-- To solve above requirement we are using inner query or subquery
-- ################################################################	 	
-- 1. GET DEPTNO FOR MARTIN
SELECT DEPTNO FROM EMP WHERE ENAME='MARTIN';
-- 2. ALL EMPLOYEES WORKING WITH MARTIN 
SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=30;
-- 3. FINAL 
SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='MARTIN');
-- ################################################################	 
-- List detail of Max earning employee
-- ################################################################	  
-- 1. get max(sal)
SELECT MAX(SAL) FROM EMP;
-- 2. get employees who has max sal
SELECT EMPNO,ENAME,DEPTNO,JOB,MGR,HIREDATE,SAL,COMM FROM EMP
WHERE SAL=5000
--
3. 
SELECT EMPNO,ENAME,DEPTNO,JOB,MGR,HIREDATE,SAL,COMM FROM EMP
WHERE SAL=(SELECT MAX(SAL) FROM EMP);
-- ################################################################	 
-- List all emp who have joined in same month and year with martin and working in turner department
-- ################################################################	 
--1.working in turner department->GET DEPTNO OF TURNER
   SELECT DEPTNO FROM EMP WHERE ENAME='TURNER' 
--2.HIRE DATE OF MARTIN
   SELECT HIREDATE FROM EMP WHERE ename='MARTIN';
--3.who have joined in same month with martin
   SELECT ENAME,HIREDATE FROM EMP 
   WHERE TO_CHAR(HIREDATE,'MM')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'MM')
--4.who have joined in same  year with martin
SELECT ENAME,HIREDATE FROM EMP 
   WHERE TO_CHAR(HIREDATE,'YY')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'YY')
--5. fINAL   List all emp who have joined in same month and year with martin and working in turner department

-- uSING  TO_CHAR(HIREDATE,'MM') AND TO_CHAR(HIREDATE,'YY')
SELECT ENAME,DEPTNO,HIREDATE FROM EMP 
WHERE 
    TO_CHAR(HIREDATE,'MM')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'MM')   
    AND
     TO_CHAR(HIREDATE,'YY')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'YY')
    AND
    DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='TURNER' );

-- OR TO_CHAR(HIREDATE,'MM:YY')

SELECT ENAME,DEPTNO,HIREDATE FROM EMP 
WHERE 
TO_CHAR(HIREDATE,'MM:YY')=(SELECT TO_CHAR(HIREDATE,'MM:YY') FROM EMP WHERE ename='MARTIN')
AND
deptno=(SELECT DEPTNO FROM EMP WHERE ENAME='TURNER')

-- ################################################################	 
-- LIST ALL EMPLOYEES WHOES MANAGER IS KING
-- ################################################################	 
-- 1. GET EMPNO OF KING
    SELECT EMPNO FROM EMP 
    WHERE
        ENAME='KING';
-- 2. COMPARE IT WITH MGR OF OTHER EMPLOYEES
    SELECT EMPNO,ENAME,MGR FROM EMP
    WHERE 
        MGR=7839;
--3. fINAL LIST ALL EMPLOYEES WHOES MANAGER IS KING
    SELECT EMPNO,ENAME,MGR FROM EMP
    WHERE 
        MGR=(SELECT EMPNO FROM EMP     WHERE        ENAME='KING');

-- ################################################################	 
-- LIST ALL EMP WHO ARE WORKING IN RESEARCH DEPARTMENT
-- ################################################################	 
--1. DEPTNO FOR RESEARCH
    SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH';
--2. DEPTNO == COMMPARED WITH RESEARCH DEPTNO
    SELECT EMPNO,ENAME,DEPTNO FROM EMP
    WHERE DEPTNO=20;
--3. LIST ALL EMP WHO ARE WORKING IN RESEARCH DEPARTMENT    
SELECT EMPNO,ENAME,DEPTNO FROM EMP
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH');

-- ################################################################	 
-- LIST TOTAL EMPLOYEE WORKING IN SALES DEPARTMENT
-- ################################################################	 
--    TOTAL=> COUNT
SELECT COUNT(*) FROM EMP
-- WORKING IN SALES =>
SELECT DEPTNO FROM DEPT WHERE dname='SALES';
-- LIST TOTAL EMPLOYEE WORKING IN SALES DEPARTMENT
SELECT COUNT(*) FROM EMP
    WHERE 
        DEPTNO=(SELECT DEPTNO FROM DEPT WHERE dname='SALES');

        
-- ################################################################	 
-- LIST ALL EMPLOYEE WHO ARE WORKING IN SALES DEPARTMENT IN NEW YORK
-- ################################################################	 
-- BRANCHNO FROM BRANCH TABLE
    SELECT BRANCHNO FROM BRANCH
    WHERE LOCATION='NEW YORK';
-- WORKING IN SALES DEPARTMENT
    SELECT DEPTNO FROM DEPT
    WHERE DNAME='SALES';
    
SELECT ENAME,DEPTNO FROM EMP
WHERE DEPTNO=(SELECT DEPTNO FROM DEPT 
                WHERE DNAME='SALES'
                AND BRANCHNO IN (SELECT BRANCHNO FROM BRANCH     WHERE LOCATION='NEW YORK')
              );  
              

-- ################################################################
-- LIST ALL EMP WHO HAVE JOINED IN THE INCEPTION YEAR OF COMPANY
-- ################################################################
SELECT HIREDATE FROM EMP ORDER BY HIREDATE;
SELECT MIN(HIREDATE) FROM EMP 
-- SELECT * FROM EMP
SELECT * FROM EMP
    WHERE
        HIREDATE =(SELECT MIN(HIREDATE) FROM EMP) ;
        
---- LIST ALL EMP WHO HAVE JOINED IN THE INCEPTION YEAR OF COMPANY        
SELECT * FROM EMP
    WHERE
        TO_CHAR(HIREDATE,'YY') =(SELECT TO_CHAR(MIN(HIREDATE),'YY') FROM EMP) ;

-- ################################################################
-- COPY OF A TABLE: COLUMNS AND DATA_TYPES ARE SAME AS ORGINAL TABLE HOWEVER NO CONSTRAINTS ARE APPLIED
-- CREATE TABLE EMP1 WHICH IS REPLICA OF EMP WITHOUT DATA
-- ################################################################
SELECT * FROM emp WHERE EMPNO=0
-- CREATE COPY OF EMP TABLE WITHOUT ANY DATA
    CREATE TABLE 
                EMP1 
            AS 
                SELECT * FROM emp WHERE EMPNO=0
SELECT * fROM EMP1; 
-- WE REQUIRED SAMPLE DATA FROM EMPLOYE BASED ON CERTAIN CRITERIA
-- ################################################################
-- INSERT DATA INTO EMP1 FROM EMP WHERE DEPTNO=20
-- ################################################################
INSERT INTO EMP1 (SELECT * FROM EMP WHERE DEPTNO=20)
SELECT * fROM EMP1; 
-- ################################################################
-- TRUNCATE EMP1 KEEPS THE TABLE STRUCTURE HOWEVER DELETES ALL RECORDS 
-- ################################################################
TRUNCATE TABLE EMP1; 
DROP TABLE EMP1;

-- ################################################################
--  EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
-- ################################################################
-- LOCATION -> BRANCH-> BRANCHNO
-- DEPT=>BRANCHNO=>DEPTNO
-- DEPTNO=> ALL EMPLOYEES WORKING IN THAT DEPT

    SELECT * FROM EMP
        WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))

--INSERT DATA INTO EMP1 FROM EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
    INSERT INTO
            EMP1
            (
            
    SELECT * FROM EMP
        WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
            )
-- ################################################################
-- UPDATE SALARY BY 10% WHO ARE WORKING IN ACCOUNTING DEPARTMENT 
-- ################################################################
UPDATE  EMP
    SET 
        SAL=SAL+SAL*0.1
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING')
SELECT * FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING');
UPDATE  EMP
    SET 
        SAL=SAL-SAL*0.1
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING')
rollback ;

-- ################################################################
-- DELETE ALL EMP  WHO ARE WORKING IN NEW YORK
-- ################################################################
SELECT * FROM EMP WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
DELETE  EMP
    WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
ROLLBACK;

-- CREATE COPY OF EMP TABLE WITH ALL RECRODS FROM EMP
DROP TABLE EMP1;
CREATE TABLE EMP1 AS SELECT * FROM emp ;
SELECT * fROM EMP1; 