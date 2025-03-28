 --- Get Highest Paid Employee in a Department
    CREATE OR REPLACE FUNCTION HIGHEST_PAID_EMP(DEPT_ID NUMBER)
    RETURN VARCHAR2
    IS
        EMP_ENAME VARCHAR2(20);
    BEGIN
        SELECT ENAME INTO EMP_ENAME FROM EMP_LARGE WHERE DEPTNO=DEPT_ID
        ORDER BY SAL DESC FETCH FIRST ROW ONLY;
        
        RETURN EMP_ENAME;
        END;
        
        SELECT HIGHEST_PAID_EMP(10) FROM DUAL;
        
        SELECT * FROM EMP_LARGE WHERE EMPNO=2193;