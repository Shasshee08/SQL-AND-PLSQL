CREATE TABLE EMP_LARGE AS
SELECT * FROM EMP WHERE 1=0;

SELECT * FROM EMP_LARGE;

============
INSERT /*+ APPEND */ INTO EMP_LARGE
SELECT 
    1000 + MOD(ROWNUM, 9000),  -- EMPNO (Ensures unique values)
    'EMP_' || ROWNUM,          -- ENAME
    CASE MOD(ROWNUM, 4)        -- Random JOB values
        WHEN 0 THEN 'CLERK' 
        WHEN 1 THEN 'MANAGER' 
        WHEN 2 THEN 'SALESMAN' 
        ELSE 'ANALYST' 
    END, 
    MOD(ROWNUM, 9000),         -- MGR (Randomized)
    SYSDATE - DBMS_RANDOM.VALUE(1000, 5000), -- HIREDATE (Random past dates)
    TRUNC(DBMS_RANDOM.VALUE(800, 5000)),    -- SAL (Salary between 800 and 5000)
    NULL,                                   -- COMM (NULL for now)
    MOD(ROWNUM, 4) * 10 + 10                -- DEPTNO (10, 20, 30, 40)
FROM DUAL
CONNECT BY LEVEL <= 1000000;  -- Adjust for the required row count


=======================================
DESC EMP_LARGE;

ALTER TABLE EMP_LARGE MODIFY EMPNO NUMBER(8); 

SELECT COUNT(*) FROM EMP_LARGE;

SELECT * FROM EMP_LARGE;
WHERE ROWNUM<=10;

EXPLAIN PLAN FOR 
SELECT * FROM EMP_LARGE WHERE ENAME='EMP_01';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

CREATE INDEX IDX_EMP_JOB_LARGE ON EMP_LARGE(JOB);

SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS, STATUS 
FROM USER_INDEXES 
WHERE TABLE_NAME = 'EMP_LARGE';

SELECT TABLE_NAME, NUM_ROWS, LAST_ANALYZED
FROM USER_TABLES
WHERE TABLE_NAME = 'EMP_LARGE';

CREATE INDEX IDX_ENAME_LARGE ON EMP_LARGE(ENAME);

EXPLAIN PLAN FOR
CREATE INDEX IDX_EMP_JOB_DEPTNO ON EMP_LARGE(JOB,DEPTNO);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT  * FROM EMP_LARGE WHERE DEPTNO=10 AND JOB='CLERK';

SELECT * FROM EMP_LARGE ORDER BY SAL DESC ;

SELECT INDEX_NAME,COLUMN_NAME,TABLE_NAME FROM USER_IND_COLUMNS
WHERE TABLE_NAME='EMP_LARGE';
====================================================

EXPLAIN PLAN FOR
SELECT 
E.ENAME,E.JOB,D.DNAME,E.SAL FROM EMP_LARGE E
JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE E.SAL>3000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

CREATE INDEX IDX_EMP_LARGE_DEPTNO ON EMP_LARGE(DEPTNO);

CREATE INDEX IDX_EMP_LARGE_SAL ON EMP_LARGE(SAL);

CREATE INDEX IDX_EMP_LARGE_SAL_DEPTNO ON EMP_LARGE(SAL,DEPTNO);

EXPLAIN PLAN FOR
SELECT * FROM EMP_LARGE WHERE DEPTNO IN(10,20) AND SAL>2000;

EXPLAIN PLAN FOR
SELECT * FROM EMP_LARGE WHERE DEPTNO IN(10,20);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




