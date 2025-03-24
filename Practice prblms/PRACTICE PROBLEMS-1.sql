CREATE TABLE EMP2
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));
 
INSERT INTO EMP2 VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('17-DEC-1980', 'DD-MON-YYYY'),  800, NULL, 20);
INSERT INTO EMP2 VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600,  300, 30);
INSERT INTO EMP2 VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250,  500, 30);
INSERT INTO EMP2 VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('2-APR-1981', 'DD-MON-YYYY'),  2975, NULL, 20);
INSERT INTO EMP2 VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMP2 VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1-MAY-1981', 'DD-MON-YYYY'),  2850, NULL, 30);
INSERT INTO EMP2 VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('9-JUN-1981', 'DD-MON-YYYY'),  2450, NULL, 10);
INSERT INTO EMP2 VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP2 VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMP2 VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('8-SEP-1981', 'DD-MON-YYYY'),  1500,    0, 30);
INSERT INTO EMP2 VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMP2 VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),   950, NULL, 30);
INSERT INTO EMP2 VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),  3000, NULL, 20);
INSERT INTO EMP2 VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);
 
 DROP TABLE DEPT PURGE;
CREATE TABLE DEPT
       (DEPTNO NUMBER(2),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );
 
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
 
 DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);
 
INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

COMMIT;

SELECT * FROM EMP2;

SELECT * FROM DEPT2;

SELECT * FROM SALGRADE2;

🔹 Basic SQL Queries
--1️ Retrieve all employees working in the SALES department.
SELECT * FROM EMP2 WHERE JOB='SALESMAN';
--2️ Find employees who joined before 01-JAN-1982.
SELECT * FROM EMP2 WHERE HIREDATE<'01-JAN-1982';
--3️ List employees who don’t have a manager (MGR is NULL).
SELECT * FROM EMP2 WHERE MGR IS NULL;

--4️ Get the total number of employees per department.
SELECT DEPTNO,COUNT(*) AS TOTAL FROM EMP2 
GROUP BY DEPTNO order by deptno;

--5️ Display unique job roles from the EMP table.
SELECT DISTINCT(JOB) FROM EMP2;

🔹 Intermediate SQL Queries
--6  Find the second highest salary in the company.
SELECT * FROM EMP2 WHERE SAL=(SELECT MAX(SAL) FROM EMP2 WHERE SAL<(SELECT MAX(SAL) FROM EMP2));

--7️ List employees earning more than their managers.
SELECT M.ENAME AS MANAGERS,E.ENAME AS EMPLOYEES 
FROM EMP E JOIN EMP M ON M.EMPNO=E.MGR WHERE E.SAL>M.SAL;


--8️ Get the department-wise highest salary.
SELECT DEPTNO,MAX(SAL) FROM EMP2 GROUP BY DEPTNO;

SELECT DNAME,MAX(SAL) FROM EMP2 E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO group by dname;

--9️ Display employees who earn less than the average salary of their department.
    SELECT EMPNO,ENAME,SAL,JOB,DEPTNO FROM EMP WHERE SAL<(SELECT AVG(SAL)FROM EMP E2
    WHERE E2.DEPTNO=EMP.DEPTNO);
    
    SELECT JOB,AVG(SAL) FROM EMP GROUP BY JOB;

--10 Retrieve employees with the same salary as someone else in the company.
SELECT EMPNO,ENAME,SAL FROM EMP2 WHERE SAL IN(SELECT SAL FROM EMP2 GROUP BY SAL HAVING COUNT(*)>1);

--waq to display managers and their employees from emp table?
SELECT M.ENAME AS MANAGERS,E.ENAME AS EMPLOYEES 
FROM EMP2 E JOIN EMP M ON M.EMPNO=E.MGR;

--waq to display employees who are working under "BLAKE" manager?
SELECT M.ENAME AS MANAGERS,E.ENAME AS EMPLOYEES
FROM EMP E JOIN EMP M ON M.EMPNO=E.MGR WHERE M.ENAME='BLAKE';

--waq to display employees who are joined before their managers from emp table?
SELECT M.ENAME AS MANAGERS,E.ENAME AS EMPLOYEES 
FROM EMP E JOIN  EMP M ON M.EMPNO=E.MGR WHERE E.HIREDATE<M.HIREDATE;

--waq to display employees whose salary is more than to their manager salary?
SELECT M.ENAME AS MANAGERS,E.ENAME AS EMPLOYEES
FROM EMP E JOIN EMP M ON M.EMPNO=E.MGR WHERE E.SAL>M.SAL;

--Rank employees based on salary within each department using RANK() & DENSE_RANK().
SELECT ENAME,SAL,RANK() OVER (ORDER BY SAL DESC) AS RANKS FROM EMP2;

SELECT ENAME,SAL,job,DENSE_RANK() OVER (partition by job ORDER BY SAL DESC) AS RANKS FROM EMP2;
--Find departments where the total salary expense is above 5000
SELECT D.DNAME,SUM(SAL)AS TOTAL FROM EMP2 E JOIN DEPT2 D ON E.DEPTNO=D.DEPTNO GROUP BY D.DNAME HAVING SUM(SAL)>5000;

--️⃣️Display employees along with their department name (Use JOIN).
SELECT D.DNAME,E.ENAME FROM EMP2 E JOIN DEPT2 D ON E.DEPTNO=D.DEPTNO;

--Identify the employees who were hired last in each department.
SELECT * FROM EMP2 E WHERE HIREDATE=(SELECT MAX(HIREDATE) FROM EMP2 WHERE DEPTNO=E.DEPTNO);

SELECT DEPTNO,MAX(HIREDATE) FROM EMP2 E WHERE DEPTNO=E.DEPTNO GROUP BY DEPTNO;

-- Generate a running total of salaries in order of hire date (Use WINDOW functions).