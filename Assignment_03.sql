drop TABLE customers;
#########################################################
CREATE TABLE customers  
( customer_id number(10) NOT NULL,  
  customer_name varchar2(50) NOT NULL,  
  city varchar2(50),  
  CONSTRAINT customers_pk PRIMARY KEY (customer_id)  
); 

###########################################################

CREATE TABLE newcustomers  
AS (SELECT *   FROM customers  WHERE customer_id < 5000); 

######################################################
CREATE TABLE newcustomers2  
AS (SELECT customer_id,name  
    FROM customers  
    WHERE customer_id < 5000); 
    
CREATE TABLE  "regularcustomers"   
   (    "RCUSTOMER_ID" NUMBER(10,0) NOT NULL ENABLE,   
    "RCUSTOMER_NAME" VARCHAR2(50) NOT NULL ENABLE,   
    "RC_CITY" VARCHAR2(50)  
   )  
/  
######################################################
CREATE TABLE  "irregularcustomers"   
   (    "IRCUSTOMER_ID" NUMBER(10,0) NOT NULL ENABLE,   
    "IRCUSTOMER_NAME" VARCHAR2(50) NOT NULL ENABLE,   
    "IRC_CITY" VARCHAR2(50)  
   )  
/
####################################################

CREATE TABLE newcustomers3  
  AS (SELECT regularcustomers.rcustomer_id, regularcustomers.rc_city, irregularcustomers.ircustomer_name  
      FROM regularcustomers, irregularcustomers  
      WHERE regularcustomers.rcustomer_id = irregularcustomers.ircustomer_id  
      AND regularcustomers.rcustomer_id < 5000);
      
######################################################

insert into irregularcustomers values(1,'Smith','NYC');
insert into irregularcustomers values(2,'John','Boston');
insert into irregularcustomers values(3,'Dev','Sweden');
insert into irregularcustomers values(4,'Carry','Nepal');
insert into irregularcustomers values(5,'Sam','UK');


insert into regularcustomers values(1,'Smith','NYC');
insert into regularcustomers values(2,'Vick','London');
insert into regularcustomers values(3,'Nicola','UAE');
insert into regularcustomers values(4,'Krish','Mumbai');
insert into regularcustomers values(5,'Hic','Washington');
insert into regularcustomers values(6,'Cherry','NYC');

#############################################################

SELECT count(*)  
FROM customers  
WHERE customer_id > 20;  

##########################################################

SELECT customer_id, address, salary  
FROM customers  
WHERE  customer_id < 4  
AND salary > '20000'  
ORDER BY age ASC, salary DESC;  

#################################################

UPDATE customers  
SET name = (SELECT supplier_name  
                 FROM suppliers  
                 WHERE suppliers.supplier_name = customers.name)  
WHERE customer_id < 3;  

#################################################

DELETE FROM customers  
WHERE name = 'john'; 

###################################################

DELETE FROM customers  
WHERE name = 'Smith'  
AND customer_id > 2;  

###########################################################
TRUNCATE TABLE customers;

############################################

CREATE TABLE CUSTOMERS   
   (    "NAME" VARCHAR2(4000),   
    "AGE" NUMBER,   
    "SALARY" NUMBER,   
    "STATE" VARCHAR2(4000)  
   )  
/  

###################################################

SELECT DISTINCT name, age, salary  
FROM customers  
WHERE age >= '60'; 

##############################################

SELECT *  
FROM customers  
WHERE salary >= 20000  
ORDER BY salary ASC; 

###########################################

select * 
from customers 
order by age;

#############################################

SELECT state, COUNT(*) AS "Number of customers"  
FROM customers  
WHERE salary > 10000  
GROUP BY state;  

#############################################
SELECT state, COUNT(*) AS "Number of customers"  
FROM customers  
WHERE salary > 10000  
GROUP BY state  
HAVING COUNT(*) >= 2; 
################################################


